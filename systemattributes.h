#ifndef SYSTEMATTRIBUTES_H
#define SYSTEMATTRIBUTES_H

#include <QObject>
#define QML_PROPERTY(type, name, READ, getter, WRITE, setter, NOTIFY, notifyer)  type m_##name; \
    Q_PROPERTY(type name READ getter WRITE setter NOTIFY notifyer) \
    public: type getter() const { return m_##name;} \
    public Q_SLOTS: void setter(type arg) { m_##name = arg; emit notifyer(arg);} \
    Q_SIGNALS:  \
        void notifyer(type arg);\
    private:



class SystemAttributes : public QObject{

    Q_OBJECT
    QML_PROPERTY(bool,isAutoLogin,READ,isAutoLogin,WRITE,setisAutoLogin,NOTIFY,isAutoLoginChange)


};


















#endif // SYSTEMATTRIBUTES_H
