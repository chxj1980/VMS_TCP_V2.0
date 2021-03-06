import QtQuick 2.0

Rectangle {

    id:root

    property int myLayoutSquare: 2  //几乘几的显示

    property alias myModel: repeater.model

    property int currentIndex: -1

    signal s_doubleClick(var index,var ismax);
    signal s_click(var clickIndex);
    signal s_showToastMsg(string str)
    signal s_deleteObject()

    Repeater{
        id:repeater


        VideoLivePlay{
            id:video
            width: (index === currentIndex && model.isMax >0)?root.width:(root.width/myLayoutSquare)
            height:  (index === currentIndex && model.isMax>0)?root.height:(root.height/myLayoutSquare)

            x:(index === currentIndex && model.isMax >0)?0:(index%myLayoutSquare) * width
            y:(index === currentIndex && model.isMax >0)?0:Math.floor(index/myLayoutSquare) * height

            color: "black"
            mip:model.ip
            mport:model.port
            mID:model.did
            mAcc:model.account
            mPwd:model.password
            mIsPlayAudio:(index===0 && model.isMax>0)?true:false


            mIsSelected: index === currentIndex

            onClick: {

                //console.debug("current index "+ index)

                currentIndex = index

                s_click(currentIndex)
            }

            onDoubleClick: {
                //console.debug("VideoLivePlay onDoubleClick")

                if( model.isMax > 0 )
                    model.isMax = 0;
                else
                    model.isMax = 1;

                s_doubleClick(index,model.isMax)
            }

            onS_showToastMsg:st_showToastMsg(str)

            onS_deleteObject:{

                isCreateConnected = 0;

            }

            onS_deviceInfo: {
                console.debug("onS_deviceInfo       "+map)

                deviceInfo.serip = map.ip
                deviceInfo.serport = map.port
                deviceInfo.serAcc = map.acc
                deviceInfo.serPwd = map.pwd
                deviceInfo.did = map.did
                deviceInfo.open()

            }
            onS_mediaInfo: {


                //    m_mediaInfo.insert("fps",map.value("fps").toInt());
                //    m_mediaInfo.insert("rcmode",map.value("rcmode").toInt());
                //    m_mediaInfo.insert("frametype",map.value("frametype").toInt());
                //    m_mediaInfo.insert("staty0",map.value("staty0"));
                //    m_mediaInfo.insert("width",map.value("width"));
                //    m_mediaInfo.insert("height",map.value("height"));

                //    m_mediaInfo.insert("samplerate",map.value("samplerate"));
                //    m_mediaInfo.insert("prenum",map.value("prenum"));
                //    m_mediaInfo.insert("bitwidth",map.value("bitwidth"));
                //    m_mediaInfo.insert("soundmode",map.value("soundmode"));

                mediaInfo.did = map.did
                mediaInfo.fps = map.fps;
                mediaInfo.rcmode = map.rcmode;
                mediaInfo.frametype = map.frametype;
                mediaInfo.staty0 = map.staty0;
                mediaInfo.mwidth = map.width;
                mediaInfo.mheight = map.height;

                mediaInfo.samplerate = map.samplerate;
                mediaInfo.prenum = map.prenum;
                mediaInfo.bitwidth = map.bitwidth;
                mediaInfo.soundmode = map.soundmode;

                mediaInfo.open()


            }
        }

    }

    QmlDeviceInfo{
        id:deviceInfo
    }

    QmlMediaInfo{
        id:mediaInfo
    }
    function updateTcpPar(pos){

        repeater.itemAt(pos).updatePar();

    }


}
