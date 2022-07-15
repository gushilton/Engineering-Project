package com.example.myproject;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.view.View;
import android.widget.CheckBox;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import static android.content.Context.MODE_PRIVATE;
import static java.lang.String.*;


public class JSONRunnable implements Runnable {

    public static final String intentmsg = "taskId";
    Context context;
    TableLayout tableLayout;
    String getResponse;
    SharedPreferences filterpreference;

    JSONRunnable(Context context, String response) {
        this.context = context;
        this.getResponse = response;
        this.tableLayout = MainActivity.mainTablelayout;
        filterpreference = context.getSharedPreferences("preferencefilter",MODE_PRIVATE);
    }


    @Override
    public void run() {
        boolean filter_jobID = filterpreference.getBoolean("key_jobID", true);
        boolean filter_assignedTo = filterpreference.getBoolean("key_assignedTo", true);
        boolean filter_dueDate = filterpreference.getBoolean("key_dueDate", true);
        boolean filter_setDate = filterpreference.getBoolean("key_setDate", true);
        boolean filter_completeDate = filterpreference.getBoolean("key_completeDate", true);
        boolean filter_complete = filterpreference.getBoolean("key_completeTick", true);


        while (tableLayout.getChildCount() != 0) {
            tableLayout.removeViewAt(0);
        }

        TableRow tableRow = new TableRow(context);
        if (filter_jobID) {
            TextView txtJobID = new TextView(context);
            txtJobID.setText("  Job ID  ");
            tableRow.addView(txtJobID);
        }
        if (filter_assignedTo) {
            TextView txtassignedTo = new TextView(context);
            txtassignedTo.setText("  AssignedTo  ");
            tableRow.addView(txtassignedTo);
        }
        if (filter_setDate) {
            TextView txtDateSet = new TextView(context);
            txtDateSet.setText("  Date Set  ");
            tableRow.addView(txtDateSet);
        }
        if (filter_dueDate) {
            TextView txtDueDate = new TextView(context);
            txtDueDate.setText("  Date Due  ");
            tableRow.addView(txtDueDate);
        }
        if (filter_completeDate) {
            TextView txtCompleteDate = new TextView(context);
            txtCompleteDate.setText("  Completeted On  ");
            tableRow.addView(txtCompleteDate);
        }
        if (filter_complete) {
            TextView txtComplete = new TextView(context);
            txtComplete.setText("  Complete  ");
            tableRow.addView(txtComplete);
        }
        tableLayout.addView(tableRow);


        JSONArray JSONarray;
        try {
            JSONObject jsonObject = new JSONObject(getResponse);
            JSONarray = jsonObject.getJSONArray("tasks");

            for (int i = 0; i < JSONarray.length(); i++) {
                JSONObject taskJSON = JSONarray.getJSONObject(i);
                tableRow = new TableRow(context);
                int rowID = taskJSON.getInt("Job_ID");
                tableRow.setId(rowID);
                tableRow.setOnClickListener(this::rowCLick);
                if (filter_jobID) {
                    TextView txtJobID = new TextView(context);
                    txtJobID.setText(taskJSON.getString("Job_ID"));
                    tableRow.addView(txtJobID);
                }
                if (filter_assignedTo) {
                    TextView txtassignedTo = new TextView(context);
                    txtassignedTo.setText(taskJSON.getString("AssignedTo"));
                    tableRow.addView(txtassignedTo);
                }
                if (filter_setDate) {
                    TextView txtDateSet = new TextView(context);
                    txtDateSet.setText(taskJSON.getString("Set_Date"));
                    tableRow.addView(txtDateSet);
                }
                if (filter_dueDate) {
                    TextView txtDueDate = new TextView(context);
                    txtDueDate.setText(taskJSON.getString("Due Date"));
                    tableRow.addView(txtDueDate);
                }
                if (filter_completeDate) {
                    TextView txtCompleteDate = new TextView(context);
                    txtCompleteDate.setText(taskJSON.getString("Complete Date"));
                    tableRow.addView(txtCompleteDate);
                }
                if (filter_complete) {
                    CheckBox ckComplete = new CheckBox(context);
                    ckComplete.setChecked(taskJSON.getBoolean("Complete"));
                    tableRow.addView(ckComplete);
                }
                tableLayout.addView(tableRow);

            }
        } catch (JSONException e) {
            e.printStackTrace();
        }

    }

    public void rowCLick(View row){
        int rowID = row.getId();
        Intent taskActivity = new Intent(context, TaskActivity.class);
        taskActivity.putExtra(intentmsg,rowID);
        context.startActivity(taskActivity);
    }
}