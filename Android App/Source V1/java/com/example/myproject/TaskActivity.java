package com.example.myproject;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.widget.CheckBox;
import android.widget.TextView;
import android.widget.Toast;

import static com.example.myproject.JSONRunnable.*;


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
        int intExtra = intent.getIntExtra(intentmsg,0);

        Toast.makeText(this,"Task ID: "+intExtra,Toast.LENGTH_SHORT).show();

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater menuInflater = getMenuInflater();
        menuInflater.inflate(R.menu.menu_task,menu);
        return true;
    }

    public void menuUpdateBtr(MenuItem menuItem){

    }
}