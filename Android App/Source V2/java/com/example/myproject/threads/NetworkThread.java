package com.example.myproject.threads;

import android.os.Looper;

import com.example.myproject.threads.handlers.myNetworkHandler;


public class NetworkThread  extends Thread{
    public myNetworkHandler networkHandler;
    @Override
    public void run() {
        Looper.prepare();
        networkHandler = new myNetworkHandler();
        Looper.loop();
    }
}
