package com.example.myproject.threads;

import android.os.Handler;
import android.os.Looper;

import com.example.myproject.threads.handlers.myBackgroundHandler;

public class backgroundThread extends Thread{
    public static myBackgroundHandler backgroundHandler;
    @Override
    public void run() {
        Looper.prepare();
        backgroundHandler = new myBackgroundHandler();
        Looper.loop();
    }
}
