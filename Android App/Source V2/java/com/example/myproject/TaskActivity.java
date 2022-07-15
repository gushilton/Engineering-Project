package com.example.myproject;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Message;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.widget.CheckBox;
import android.widget.TextView;

import static com.example.myproject.Runnables.JSONRunnable.*;
//import static com.example.myproject.MainActivity.networkThread;


public class TaskActivity extends AppCompatActivity {
public static final int taskgetTask = 1;
public static final int taskUpdate = 2;
public static TextView jobIDtxt, jobDescriptiontxt, dueDatetxt, setDatetxt, completeDatetxt;
public static CheckBox ckComplete;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_task);
        jobIDtxt = findViewById(R.id.txtJobID);
        jobDescriptiontxt = findViewById(R.id.txtTaskDescription);
        dueDatetxt = findViewById(R.id.txtDueDate);
        setDatetxt = findViewById(R.id.txtSetDate);
        completeDatetxt = findViewById(R.id.txtCompletDate);
        ckComplete = findViewById(R.id.ckCompleteTask);

        Intent intent = getIntent();
        String stringExtra = intent.getStringExtra(intentmsg);
        Message message = Message.obtain();
        message.what = taskgetTask;
        message.obj = stringExtra;
        //networkThread.networkHandler.sendMessage(message);

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater menuInflater = getMenuInflater();
        menuInflater.inflate(R.menu.menu_task,menu);
        return true;
    }

    public void menuUpdateBtr(MenuItem menuItem){
        Message message = Message.obtain();
        message.what = taskUpdate;
        message.obj = jobIDtxt.getText().toString();
        //networkThread.networkHandler.sendMessage(message);
    }
}