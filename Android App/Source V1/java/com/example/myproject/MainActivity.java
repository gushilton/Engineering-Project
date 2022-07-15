package com.example.myproject;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Message;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TableLayout;


public class MainActivity extends AppCompatActivity {
    public static final int taskgetMain = 0;

    AlertDialog dialog,dialogsetting;
    SwipeRefreshLayout swipeRefreshLayout;
    SharedPreferences filterpreference,settingpreference;


    private threadHTTP threadHTTP;

    private CheckBox jobID,assignedTo,dateSet,dateDue,dateComplete,assignedMe,completeCheck;

    public static TableLayout mainTablelayout;

    EditText usernameed, passworded, servered;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mainTablelayout = findViewById(R.id.tableMain);

        filterpreference = this.getSharedPreferences("preferencefilter",MODE_PRIVATE);
        settingpreference = this.getSharedPreferences("preferencesettings",MODE_PRIVATE);

        swipeRefreshLayout = (SwipeRefreshLayout)findViewById(R.id.mainSwipeRefresh);
        swipeRefreshLayout.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() {
            @Override
            public void onRefresh() {

                refresh();
            }
        });

        String username = settingpreference.getString("Username", "false");
        String password = settingpreference.getString("Password", "false");
        String con_url = settingpreference.getString("Server", "false");

        if (username == "false" || con_url == "false"){
            AlertDialog.Builder builder = new AlertDialog.Builder(this);

            LayoutInflater inflater = this.getLayoutInflater();
            builder.setView(inflater.inflate(R.layout.settings_layout,null));


            builder.setPositiveButton("Confirm", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {
                    String user = usernameed.getText().toString();
                    String urlserver = servered.getText().toString();
                    SharedPreferences.Editor setEditor = settingpreference.edit();
                    setEditor.putString("Username", user);
                    setEditor.putString("Server", urlserver);
                    setEditor.apply();

                }
            }).setNegativeButton("cancel", new DialogInterface.OnClickListener() {
                @Override
                public void onClick(DialogInterface dialog, int which) {

                }
            });

            dialogsetting = builder.show();
            usernameed = (EditText)dialogsetting.findViewById(R.id.username);
            servered = (EditText)dialogsetting.findViewById(R.id.server);
            if (username != "false"){
                usernameed.setText(username);
            }
            if (con_url != "false"){
                servered.setText(con_url);
            }


        }

        threadHTTP = new threadHTTP();
        threadHTTP.start();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater menuInflater = getMenuInflater();
        menuInflater.inflate(R.menu.menu_main,menu);
        return true;
    }

    @Override
    protected void onResume() {
        super.onResume();
        Context context = this;
        Message message = Message.obtain();
        message.what = taskgetMain;
        message.obj = context;
        threadHTTP.threadHTTP_handler.sendMessage(message);
    }

    void refresh(){
        swipeRefreshLayout.setRefreshing(true);
        Context context  = this;
        Message message = Message.obtain();
        message.what = taskgetMain;
        message.obj = context;
        threadHTTP.threadHTTP_handler.sendMessage(message);

        swipeRefreshLayout.setRefreshing(false);
    }


    public void settingbtr(MenuItem item) {
        Intent settingIntent = new Intent(this,MySettingsFragment.class);
        startActivity(settingIntent);
    }

    public void filterbtr(MenuItem item){


        AlertDialog.Builder builder = new AlertDialog.Builder(this);

        LayoutInflater inflater = this.getLayoutInflater();
        builder.setView(inflater.inflate(R.layout.filter_layout,null));


        builder.setPositiveButton("Confirm", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                updateFilter();
            }
        }).setNegativeButton("cancel", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {

            }
        });

        dialog = builder.show();

        jobID = dialog.findViewById(R.id.job_id);
        dateSet = dialog.findViewById(R.id.setDate);
        dateDue = dialog.findViewById(R.id.dueDate);
        dateComplete = dialog.findViewById(R.id.completeDate);
        assignedTo = dialog.findViewById(R.id.assignedTo);
        assignedMe = dialog.findViewById(R.id.assignedMe);
        completeCheck = dialog.findViewById(R.id.checkboxComplete);

        jobID.setChecked(filterpreference.getBoolean("key_jobID",true));
        dateSet.setChecked(filterpreference.getBoolean("key_setDate",true));
        dateDue.setChecked(filterpreference.getBoolean("key_dueDate",true));
        dateComplete.setChecked(filterpreference.getBoolean("key_completeDate",true));
        assignedTo.setChecked(filterpreference.getBoolean("key_assignedTo",true));
        assignedMe.setChecked(filterpreference.getBoolean("key_assignedMe",true));
        completeCheck.setChecked(filterpreference.getBoolean("key_completeTick",true));

    }

    private void updateFilter() {

        boolean job_id = jobID.isChecked();
        boolean date_set = dateSet.isChecked();
        boolean date_due = dateDue.isChecked();
        boolean date_complete = dateComplete.isChecked();
        boolean assigned_to = assignedTo.isChecked();
        boolean assigned_me = assignedMe.isChecked();
        boolean complete = completeCheck.isChecked();

        SharedPreferences.Editor filterEditor = filterpreference.edit();
        filterEditor.putBoolean("key_jobID",job_id);
        filterEditor.putBoolean("key_setDate",date_set);
        filterEditor.putBoolean("key_dueDate",date_due);
        filterEditor.putBoolean("key_completeDate",date_complete);
        filterEditor.putBoolean("key_assignedTo",assigned_to);
        filterEditor.putBoolean("key_assignedMe",assigned_me);
        filterEditor.putBoolean("key_completeTick",complete);
        filterEditor.apply();

    }

}
