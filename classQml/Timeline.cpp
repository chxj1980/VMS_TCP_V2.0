/*              图表基类
 * 描述：自定义绘制图表的基类（折线图，饼图，条形图）
 *
 * 功能：1、图表之外的一切绘制，包括背景绘制，坐标轴的绘制(子类提供具体的图表绘制)
 *      2、坐标变换（将显示的坐标转换为屏幕像素坐标）,坐标自由伸缩，平移
 *      3、轴的尺寸动画
 *
 * 作者：DMJ
 *
*/

#include "Timeline.h"


TimeLine::TimeLine()
{

    setAcceptedMouseButtons(Qt::LeftButton
                            | Qt::RightButton
                            | Qt::MiddleButton);
    setFlag(QQuickItem::ItemHasContents);

    isMousePress = false;



    connect(&axisAnimationTimer,&QTimer::timeout,this,&TimeLine::slot_timeout_axisAnnimation);
    connect(&chartAnimationTimer,&QTimer::timeout,this,&TimeLine::slot_timeout_chartAnnimation);

}


void TimeLine::setScalePixHeight(int h, int m, int s)
{
    timePix = h;
    minutePix = m;
    secondsPix = s;

}

//在这里设置原点坐标是因为在构造函数没结束之前，控件的几何信息还未定
void TimeLine::setCoordinateOriginX(float cx)
{

    m_coordinateOrigin.setX(cx);

}

void TimeLine::setCoordinateOriginY(float cy)
{

    m_coordinateOrigin.setY(cy);

}

void TimeLine::setUnitScale(float tx)
{
    secondsPerPix = 1;
}

void TimeLine::paint(QPainter *painter)
{

    painter->setRenderHint(QPainter::Antialiasing);

    drawAxis(painter);
    drawChart(painter);
}



void TimeLine::drawAxis(QPainter *painter)
{

    painter->setPen(QPen(QBrush(Qt::black),1));

    //字体
    QFont newFont;
    newFont.setPixelSize(10);
    //newFont.setFamily("");
    QFontMetrics fontMetrics(newFont);

    //轴
    painter->drawLine(m_coordinateOrigin,QPointF(width(),m_coordinateOrigin.ry()));


    qDebug()<<"secondsPerPix    "<<secondsPerPix;
    for(int pix = 0 ;pix < width();pix++){

        int time =secondsPerPix*( pix-m_coordinateOrigin.rx());

        qDebug()<<"time "<<time;
        if(time >= (3600 * 24 ))
            break;

        if(time%3600==0){
            int timeH = time/3600;
            qDebug()<<"timeH "<<timeH;
            QString showNum = QString::number(timeH)+":00";
            QRect boundingRect = fontMetrics.boundingRect(showNum);
            painter->setPen(QPen(QBrush(Qt::darkGray),1));

            QPointF desPt(pix,m_coordinateOrigin.ry() -timePix);
            painter->drawLine(QPointF(pix,m_coordinateOrigin.ry()),desPt);
            painter->drawText(desPt.rx()-boundingRect.width()/2,desPt.ry() - boundingRect.height()/2,showNum);
            continue;
        }

        if(time%60==0){
            int tmpimeM = time/60;
            int timeM = tmpimeM%60;
            qDebug()<<"tmpimeM%60 "<<timeM;
            QString showNum = QString::number(timeM);
            QRect boundingRect = fontMetrics.boundingRect(showNum);

            painter->setPen(QPen(QBrush(Qt::gray),1));
            QPoint desPt(pix,m_coordinateOrigin.ry() - minutePix);


            if(secondsPerPix>=3){
                if(timeM%10==0){
                    painter->drawText(desPt.rx()-boundingRect.width()/2,desPt.ry() - boundingRect.height()/2,showNum);
                    painter->drawLine(QPoint(pix,m_coordinateOrigin.ry()),QPoint(pix,m_coordinateOrigin.ry() - minutePix));
                }
            }else{
                painter->drawText(desPt.rx()-boundingRect.width()/2,desPt.ry() - boundingRect.height()/2,showNum);
                painter->drawLine(QPoint(pix,m_coordinateOrigin.ry()),QPoint(pix,m_coordinateOrigin.ry() - minutePix));
            }
            continue;

        }

        //qDebug()<<"time "<<time;
        if(secondsPerPix<=0.25 && time%10==0){
            painter->setPen(QPen(QBrush(Qt::lightGray),1));
            painter->drawLine(QPointF(pix,m_coordinateOrigin.ry()),QPointF(pix,m_coordinateOrigin.ry() - secondsPix));
        }

    }


}



float TimeLine::timeTransforPix(int t)
{

    return t*secondsPerPix - m_coordinateOrigin.rx();


}

float TimeLine::pixToTime(float pix)
{
    return (pix-m_coordinateOrigin.rx())*secondsPerPix;
}

void TimeLine::slot_timeout_axisAnnimation()
{


    secondsPerPix += animationXRate;

    update();

    annimationCount --;
    if(annimationCount <= 1)
        axisAnimationTimer.stop();
}

/*
 * 动画的思路是将 secondsPerPix，YunitScale 大小从0恢复原来的大小，
 * 每个时钟周期恢复animationXRate，animationYRate 个大小
 *

*/
void TimeLine::startAxisAnimation(int ms)
{

    annimationCount = 20;

    animationXRate = secondsPerPix / annimationCount;

    axisAnimationTimer.start(ms / annimationCount);


    secondsPerPix = 0;

}


void TimeLine::mousePressEvent(QMouseEvent* event)
{


    if(event->button() == Qt::LeftButton){
        isMousePress = true;
        mouseDragPt.setX(event->x());
        mouseDragPt.setY(event->y());

    }else if(event->button() == Qt::RightButton){

        testData.append(dataInfo(QPointF(10.4, 20.5),Qt::red));
        testData.append(dataInfo(QPointF(20.2, 30.2),Qt::yellow));
        testData.append(dataInfo(QPointF(30.4, 20.5),Qt::green));
        testData.append(dataInfo(QPointF(50.4, 33.5),Qt::blue));
        testData.append(dataInfo(QPointF(70.4, 5.5),Qt::cyan));

    }
}

void TimeLine::mouseMoveEvent(QMouseEvent *event)
{

    if(isMousePress){

        float dx = event->x() - mouseDragPt.x();
        float dy = event->y() - mouseDragPt.y();


        if(m_coordinateOrigin.rx() + dx <= 0){
            m_coordinateOrigin.setX(m_coordinateOrigin.rx() + dx);
            // m_coordinateOrigin.setY(m_coordinateOrigin.ry() + dy);

            qDebug()<<"m_coordinateOriginX  "<<m_coordinateOrigin.rx();

            mouseDragPt.setX(event->x());
            mouseDragPt.setY(event->y());

            update();
        }
    }
}

void TimeLine::mouseReleaseEvent(QMouseEvent *event)
{
    isMousePress = false;
}

void TimeLine::wheelEvent(QWheelEvent *event)
{

    int curWheelX = event->x();
    //float k = (curWheelX - m_coordinateOrigin.rx())/secondsPerPix;


    if(event->delta() > 0){


        //m_coordinateOrigin.setX(m_coordinateOrigin.rx() - 0.2*k*secondsPerPix);

        if(secondsPerPix <=0.25)
            return;
        if(secondsPerPix<=1){

            secondsPerPix *= 0.5;

        }else
            secondsPerPix--;

    }else {
        //m_coordinateOrigin.setX(m_coordinateOrigin.rx() + k*secondsPerPix/6);

        if(secondsPerPix < 1)
            secondsPerPix *= 2;
        else
            secondsPerPix++;

    }


    update();
}
//空函数，由子类实现
void TimeLine::slot_timeout_chartAnnimation(){}

void TimeLine::drawChart(QPainter *painter){}

void TimeLine::startChartAnimation(int ms){
    qDebug()<<"ChartPolyLine::startChartAnimation";
}
