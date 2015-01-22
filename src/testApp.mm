//  Copyright (c) 2014 sena. All rights reserved.
#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){	
	srand((unsigned int)time((time_t *)NULL));
	
	// 0 output channels,
	// 2 input channels
	// 44100 samples per second
	// BUFFER_SIZE samples per buffer
	// 4 num buffers (latency)
	
	ofSoundStreamSetup(0,2,this, 44100/2,BUFFER_SIZE, 4);
	left = new float[BUFFER_SIZE];
	right = new float[BUFFER_SIZE];
    
	for (int i = 0; i < NUM_WINDOWS; i++)
	{
		for (int j = 0; j < BUFFER_SIZE/2; j++)
		{
			freq[i][j] = 0;
		}
	}
	
	ofSetColor(0x666666);
    
    touch_x = 150.0;
    touch_y = 300.0;

}


//--------------------------------------------------------------
void testApp::update(){
	ofBackground(0,0,0);
}

//--------------------------------------------------------------
void testApp::draw(){
    
	static int index=0;
	float avg_power = 0.0f;
	
	if(index < 80)
		index += 1;
	else
		index = 0;
	
    ofBackground(0,green,0);
    green = green*0.86;
    
	/* do the FFT	*/
	myfft.powerSpectrum(0,(int)BUFFER_SIZE/2, left,BUFFER_SIZE,&magnitude[0],&phase[0],&power[0],&avg_power);
	
	/* start from 1 because mag[0] = DC component */
	/* and discard the upper half of the buffer */
	for(int j=1; j < BUFFER_SIZE/2; j++) {
		freq[index][j] = magnitude[j];
	}
	
	/* draw the FFT */
	for (int i = 1; i < (int)(BUFFER_SIZE/2); i++){
		ofLine(20+(i*8),400,20+(i*8),400-magnitude[i]*20.0f);
	}
    
    

    ofSetColor(200,0,150);
    ofLine(20,touch_y,300,touch_y);
    ofSetColor(255,255,255);
    
    ofSetColor(200,0,150);
    ofLine(touch_x,20,touch_x,500);
    ofSetColor(255,255,255);
    
    ofSetColor(250,0,100);
    ofCircle(touch_x,touch_y,5);
    ofSetColor(255,255,255);
    
    for (int i = 0; i<BUFFER_SIZE/2; i++){
        if (20+i<touch_x && touch_x<28+i){
            zone = i;
        }
    }
/*
    ofDrawBitmapString(ofToString(magnitude[10]*100),20,40);
    ofDrawBitmapString(ofToString(zone),20,80);
    ofDrawBitmapString(ofToString(touch_y),20,100);
    ofDrawBitmapString(ofToString(400-magnitude[zone]*20.0f),20,120);
*/
    if (400-magnitude[zone]*20.0f<touch_y){
        green = 255;
    }
    
}

//--------------------------------------------------------------
void testApp::exit(){
    
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){
	if( touch.id == 0 ){
        touch_x = touch.x;
        touch_y = touch.y;
	}
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){
	if( touch.id == 0 ){
        touch_x = touch.x;
        touch_y = touch.y;
	}
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
	if( touch.id == 0 ){
        touch_x = touch.x;
        touch_y = touch.y;
	}
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void testApp::lostFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){
    
}

//--------------------------------------------------------------
void testApp::audioReceived 	(float * input, int bufferSize, int nChannels){
	// samples are "interleaved"
	for (int i = 0; i < bufferSize; i++){
		left[i] = input[i*2];
		right[i] = input[i*2+1];
	}
	bufferCounter++;
}
