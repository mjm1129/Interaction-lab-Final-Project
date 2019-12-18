import android.media.MediaMetadataRetriever;
import android.os.Handler;
import android.os.HandlerThread;
import android.os.Looper;
import android.app.Activity;
import android.view.ViewGroup;
import android.view.View;
import android.view.SurfaceHolder;
import android.view.SurfaceView;
import android.media.MediaMetadataRetriever;
import android.media.MediaPlayer;
import android.content.res.Resources;
import android.content.res.AssetFileDescriptor;
import android.content.res.AssetManager;
import android.content.Context;

AssetFileDescriptor afd;
Context context;
Activity act;
SurfaceView mySurface;
SurfaceHolder mSurfaceHolder;
MediaMetadataRetriever metaRetriever;
MediaPlayer mMediaPlayer;

//File[] SDcards ; 
//String primarySD, externalSD;

PImage broken;
PImage endScreen;
boolean videoPlayed = false;

String[] bullyingQuotes = {};

int opacity = 0;

void loadEnding() {
  //size(400,400,P2D);
  act = this.getActivity();
  context = act.getApplicationContext();
    endScreen = loadImage("images/end.png");

  //SDcards = context.getExternalFilesDirs(null);
  //primarySD = SDcards[0].getPath().split("/Android")[0];
  //externalSD = SDcards[1].getPath().split("/Android")[0];
  Looper.prepare();
  mMediaPlayer = new MediaPlayer();
  try {
    afd = context.getAssets().openFd("video/endingVideo.mp4"); /// video is in the sketch Data folder
    MediaMetadataRetriever metaRetriever = new MediaMetadataRetriever();
    metaRetriever.setDataSource(afd.getFileDescriptor(), afd.getStartOffset(), afd.getLength());
    String height = metaRetriever.extractMetadata(MediaMetadataRetriever.METADATA_KEY_VIDEO_HEIGHT); 
    if (int(height) < 2) {
      throw new IOException();
    }
  }
  catch (IllegalArgumentException e) {
    e.printStackTrace();
  }
  catch (IllegalStateException e) {
    e.printStackTrace();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }

  mySurface = new SurfaceView(act);
  mySurface.setZOrderOnTop(true) ;
  mSurfaceHolder = mySurface.getHolder();
  mSurfaceHolder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS);
  mSurfaceHolder.addCallback(new SurfaceHolder.Callback() {
    //<a href="/two/profile/Override">@Override</a>
    public void surfaceCreated(SurfaceHolder surfaceHolder) {
      mMediaPlayer.setDisplay(surfaceHolder);
    }

    // <a href="/two/profile/Override">@Override</a>
    public void surfaceChanged(SurfaceHolder surfaceHolder, int i, int i2, int i3) {
      mMediaPlayer.setDisplay(surfaceHolder);
    }

    // <a href="/two/profile/Override">@Override</a>
    public void surfaceDestroyed(SurfaceHolder surfaceHolder) {
    }
  }
  );
}

void startVideo() {
  act.runOnUiThread(new Runnable() {
    public void run() {
      try {
        mMediaPlayer.setDataSource(afd.getFileDescriptor(), afd.getStartOffset(), afd.getLength());
        mSurfaceHolder = mySurface.getHolder();
        mSurfaceHolder.setType(SurfaceHolder.SURFACE_TYPE_PUSH_BUFFERS);
        mMediaPlayer.prepare();
        //        act.addContentView(mySurface, new ViewGroup.LayoutParams(ViewGroup.LayoutParams.WRAP_CONTENT,ViewGroup.LayoutParams.WRAP_CONTENT));
        //act.addContentView(mySurface, new ViewGroup.LayoutParams(400, 400));
        act.addContentView(mySurface, new ViewGroup.LayoutParams(width, height));
        if (mMediaPlayer.isPlaying() == false) {
          mMediaPlayer.start();
        }
      }
      catch (IllegalArgumentException e) {
        e.printStackTrace();
      }
      catch (IllegalStateException e) {
        e.printStackTrace();
      } 
      catch (IOException e) {
        e.printStackTrace();
      }
    }
  }
  );
};

void ending(){
  String elapseTime;
  if(!videoPlayed){
    startVideo();
    videoPlayed = true;
  }
  if(System.currentTimeMillis() - 105000 > finishedTime){
    if (mMediaPlayer!=null) {
      println("in");
        mMediaPlayer.release();
        mMediaPlayer = null;
      }
     
    mySurface.setZOrderOnTop(false);mySurface.setZOrderOnTop(false);
    textSize(25 * ratioY);
    image(endScreen, 0, 0);
    if(elapseTime(startedTime, finishedTime)[0] < 1){
      elapseTime = str(elapseTime(startedTime, finishedTime)[1]) + " seconds";
      //println(1, elapseTime);
      text(elapseTime, 115 * ratioX, 150 * ratioY);
    } else {
      elapseTime = str(elapseTime(startedTime, finishedTime)[0]) + " mins " + str(elapseTime(startedTime, finishedTime)[1]) + " seconds";
      println(2, elapseTime);
      text(elapseTime, 80 * ratioX, 150 * ratioY);
    }
  }
  //if (endingVideo.available()) {
  //  endingVideo.read();
  //}
  //image(endingVideo, 0, 0);
  //endingVideo.play();
  //if(!brokenPlayed){
  //  breakingSound.play();
  //  brokenPlayed = true;
  //} 
  //background(0);
  
  //if(finishedTime + 5 < elapseSeconds()){
  //  image(broken, 0, 0);
  //} else if (finishedTime + 10 < elapseSeconds()){
  //  for(int i = 255; i > 0; i--){
  //    tint(255, i);
  //    image(broken, 0, 0);
  //  } 
  //} else if(finishedTime + 12 < elapseSeconds()){
  //  if(opacity < 250){
  //    delay(10);
  //    opacity+=5;
  //    }
  //  tint(255, opacity);
  //  image(endScreen, 0, 0);
    
  //  textSize(25 * ratioY);
  //  text(elapseTime, pmouseX, pmouseY);
  //} else {
  //  image(endScreen, 0, 0);
  //}
 
}
