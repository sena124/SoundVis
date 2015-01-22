#pragma once

#include "ofMain.h"
#include "ofxiPhone.h"
#include "ofxiPhoneExtras.h"
#include "fft.h"


class testApp : public ofxiPhoneApp{
	
    public:
        void setup();
        void update();
        void draw();
        void exit();
    
        void touchDown(ofTouchEventArgs & touch);
        void touchMoved(ofTouchEventArgs & touch);
        void touchUp(ofTouchEventArgs & touch);
        void touchDoubleTap(ofTouchEventArgs & touch);
        void touchCancelled(ofTouchEventArgs & touch);
	
        void lostFocus();
        void gotFocus();
        void gotMemoryWarning();
        void deviceOrientationChanged(int newOrientation);
    
    
        ofTrueTypeFont font;
        float synthPosition;
        float appIphoneScale;
        void audioReceived 	(float * input, int bufferSize, int nChannels);

    
    private:
        #define BUFFER_SIZE 256
        #define NUM_WINDOWS 80
        float * left;
        float * right;
        int 	bufferCounter;
        fft		myfft;
    
        float magnitude[BUFFER_SIZE];
        float phase[BUFFER_SIZE];
        float power[BUFFER_SIZE];
    
        float freq[NUM_WINDOWS][BUFFER_SIZE/2];
        float freq_phase[NUM_WINDOWS][BUFFER_SIZE/2];
    
        float touch_x;
        float touch_y;
        int zone;
        int green;
    

};


