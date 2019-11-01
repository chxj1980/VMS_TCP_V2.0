
#ifndef XVideo_H
#define XVideo_H
#include <QQuickPaintedItem>
#include <QImage>
#include <QList>
#include <QTimer>
#include <QAudioFormat>
#include <QAudioDeviceInfo>
#include <QAudioOutput>
#include <QSGSimpleTextureNode>
#include <QDateTime>
#include <QDir>

#include <QQuickWindow>
#include "tcpworker.h"
#include "playaudio.h"
#include "dispatchmsgmanager.h"
#include "p2pworker.h"
#include "mp4format.h"



class ImageInfo{

public:
    QImage *pImg;
    quint64 time;
};

#define QML_PROPERTY(type, name, READ, getter, WRITE, setter, NOTIFY, notifyer)  type m_##name; \
    Q_PROPERTY(type name READ getter WRITE setter NOTIFY notifyer) \
    public: type getter() const { return m_##name;} \
    public Q_SLOTS: void setter(type arg) { m_##name = arg; emit notifyer(arg);} \
    Q_SIGNALS:  \
    void notifyer(type arg);\
    private:

class XVideo : public QQuickItem
{
    Q_OBJECT
    //控制属性
    //QML_PROPERTY(bool isPlayAudio READ isPlayAudio WRITE setisPlayAudio NOTIFY isPlayAudioChanged);
    QML_PROPERTY(int,isAuthenticationSucc, READ, isAuthenticationSucc, WRITE, setisAuthenticationSucc, NOTIFY, isAuthenticationSuccChanged)//鉴权成功则判断视频流即将更新

    //媒体信息属性
    QML_PROPERTY(QVariantMap ,mediaInfo, READ, mediaInfo, WRITE, setmediaInfo, NOTIFY, mediaInfoChanged)

    //设备信息
    QML_PROPERTY(QVariantMap ,deviceInfo, READ, deviceInfo, WRITE, setdeviceInfo, NOTIFY, deviceInfoChanged)

    //系统属性
    QML_PROPERTY(QString, shotScreenPath, READ ,shotScreenPath, WRITE ,setshotScreenPath, NOTIFY ,shotScreenPathChanged)
    QML_PROPERTY(QString, recordScreenPath, READ, recordScreenPath, WRITE, setrecordScreenPath ,NOTIFY, recordScreenPathChanged)

public:
    Q_INVOKABLE void sendAuthentication(QString did,QString name,QString pwd);
    Q_INVOKABLE void connectServer(QString ip,QString port);
    Q_INVOKABLE void disConnectServer();
    Q_INVOKABLE void funPlayAudio(bool isPlay);
    Q_INVOKABLE void funRecordVedio(bool isRecord);
    Q_INVOKABLE void funScreenShot();
    Q_INVOKABLE void funUpdateTcpPar(QString ip,QString port,QString acc,QString pwd,QString did);

    Q_INVOKABLE void funSetShotScrennFilePath(QString str);
    Q_INVOKABLE void funSetRecordingFilePath(QString str);

    explicit XVideo();
    ~XVideo();

signals:
    //tcp
    void signal_connentSer(QString ip,int port);
    void signal_disconnentSer();
    void signal_tcpSendAuthentication(QString did,QString name,QString pwd);
    void signal_destoryTcpWork();
    void signal_updateTcpPar(QString ip,QString port,QString acc,QString pwd,QString did);
    //qml
    void signal_loginStatus(QString msg);
    void signal_waitingLoad(QString msgload);
    void signal_endLoad();
    void signal_videoDataUpdate(bool isSucc);
    //audio
    void signal_stopPlayAudio();
    void signal_startPlayAudio();
    void signal_playAudio(unsigned char * buff,int len,long pts);
    void signal_preparePlayAudio(int samplerate,int prenum,int bitwidth,int soundmode,long pts);
    //p2p
    void signals_p2pDowork();
    //
    void signal_update();
    //record
    void signal_recordAudio(char *buff,int len,long long tempTime);
    void signal_recordVedio(char *buff,int len,long long tempTime);
    void signal_startRecord(QString did,long long tempTime);
    void signal_endRecord();
    void signal_setRecordingFilePath(QString str);




public slots:
    void slot_trasfer_waitingLoad(QString msgload);
    void slot_trasfer_endLoad();


    void slot_sendToastMsg(MsgInfo *msg);//经过dispatchMsgManager后出来消息
    void slot_recMsg(MsgInfo *msg);//所有其他类的消息都先到此
    void slot_recH264(char *buff,int len,quint64 time,QVariantMap map);
    void slot_recPcmALaw(char *buff,int len,quint64 time,QVariantMap map);
    void slot_authentication(bool isSucc);

    void slot_reconnectP2p();

    void slot_timeout();
    void sendWaitLoad(bool &isWaiting);


protected:
    QSGNode* updatePaintNode(QSGNode *old, UpdatePaintNodeData *);
private:

    void createTcpThread();
    void createP2pThread();
    void createMp4RecordThread();
    void createFFmpegDecodec();
    void creatDateProcessThread();
    void createPlayAudio();
    void createAviRecord();

    void initVariable();

    QThread *m_readThread;
    TcpWorker *worker;

    QThread *m_p2pThread;
    P2pWorker *p2pWorker;

    FfmpegCodec *pffmpegCodec;

    QThread *m_threadReadDate;
    MediaDataProcess *m_dataProcess;

    PlayAudio *playAudio;
    QThread *playAudioThread;

    QThread *recordThread;
    AviRecord *aviRecord;

    QThread *mp4RecordThread;
    Mp4Format *mp4Record;


    QTimer timerUpdate;
    DispatchMsgManager *mpDispatchMsgManager;

    QList<ImageInfo> listImgInfo;
    QImage *m_Img;



    bool isImgUpdate;

    int minBuffLen;

    bool isPlayAudio;
    bool isRecord;
    bool isStartRecord;//是否启动录像
    bool isScreenShot;
    bool isAudioFirstPlay;
    bool isFirstData;

    quint64 preAudioTime;



    QString mTcpIp;
    QString mTcpPort;
    QString mDid;
    QString mAccount;
    QString mPassword;
    QString mshotScreenFilePath;//有用

};

#endif // XVideo_H
