#ifndef TIMELINE_H
#define TIMELINE_H

#include <QObject>
#include <QQuickPaintedItem>
#include <QPainter>
#include <QPointF>
#include <QDebug>
#include <QPolygon>
#include <QTimer>


class dataInfo{

public:
    dataInfo(QPointF pt,QColor color){
        mPt = pt;
        mColor = color;
    }
    QPointF mPt;
    QColor mColor;

};

class TimeLine : public QQuickPaintedItem
{
    Q_OBJECT
public:
    TimeLine();


    Q_INVOKABLE void setCoordinateOriginX(float cx);
    Q_INVOKABLE void setCoordinateOriginY(float cy);
    Q_INVOKABLE void setUnitScale(float tx);
    Q_INVOKABLE void setScalePixHeight(int h,int m,int s);

    Q_INVOKABLE virtual void startAxisAnimation(int ms);
    Q_INVOKABLE virtual void startChartAnimation(int ms);


public slots:
    virtual void slot_timeout_axisAnnimation();
    //由于所有子类都有图表出现的动画形式 ，故定时器播放动画放到了基类，子类控制定时器的启动以及重新实现该槽函数就能实现图表的绘制动画
    virtual void slot_timeout_chartAnnimation();

protected:
    void paint(QPainter *painter);

    float timeTransforPix(int time);
    float pixToTime(float pix);

    void mousePressEvent(QMouseEvent* event);
    void mouseMoveEvent(QMouseEvent *event);
    void mouseReleaseEvent(QMouseEvent *event);
    void wheelEvent(QWheelEvent *event);


    virtual void drawAxis(QPainter *painter);
    virtual void drawChart(QPainter *painter);


    QList<dataInfo> testData;

    QTimer chartAnimationTimer;
private:
    QPointF m_coordinateOrigin;//原点
    float secondsPerPix;//每个刻度多少秒

    bool isMousePress;
    QPointF mouseDragPt;


    //时分秒的刻度高度
    int timePix;
    int minutePix;
    int secondsPix;

    //轴动画
    int annimationCount;//每秒变化的次数
    float animationXRate;//每次变化的像素

    QTimer axisAnimationTimer;


};

#endif // CHARTBASE_H
