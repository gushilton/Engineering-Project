package com.example.myproject;


import android.os.Handler;
import android.os.Looper;
import android.widget.TableLayout;

import com.google.android.material.tabs.TabLayout;

public class threadHTTP extends Thread{

    public Handler threadHTTP_handler;

    @Override
    public void run() {
        Looper.prepare();
        threadHTTP_handler = new myHandler();

        Looper.loop();

    }
}
