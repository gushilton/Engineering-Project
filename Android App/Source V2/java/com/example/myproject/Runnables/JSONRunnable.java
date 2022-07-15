package com.example.myproject.Runnables;

import android.content.Context;
import android.content.Intent;

import android.os.Handler;
import android.os.Looper;
import android.view.View;
import android.widget.CheckBox;

import android.widget.TableRow;
import android.widget.TextView;

import com.example.myproject.MainActivity;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import static com.example.myproject.fragment.HomeFragment.tableHome;


//import static com.example.myproject.MainActivity.filterpreference;
//import static com.example.myproject.MainActivity.mainContext;
//import static com.example.myproject.MainActivity.mainTablelayout;


public class JSONRunnable implements Runnable {

    public static final String intentmsg = "taskId";
    private String getResponse;


    public JSONRunnable(String response) {
        this.getResponse = response;
    }


    @Override
    public void run() {
        JSONArray JSONarray;
        Handler mainHandler = new Handler(Looper.getMainLooper());
        try {
            JSONObject jsonObject = new JSONObject(getResponse);
            String status = jsonObject.getString("status");
            if (status == "successfull"){
                JSONarray = jsonObject.getJSONArray("tasks");
                for (int i = 0; i < JSONarray.length(); i++) {
                    JSONObject taskJSON = JSONarray.getJSONObject(i);
                    String WONumber = taskJSON.getString("WONumber");
                    String jobTitle = taskJSON.getString("jobTitle");

                    mainHandler.post(new addTableRowRunnable(WONumber,jobTitle));
                }
            }else{

            }

/*            for (int i = 0; i < JSONarray.length(); i++) {
                JSONObject taskJSON = JSONarray.getJSONObject(i);
                tableRow = new TableRow(context);
                tableRow.setBackground(context.getDrawable(R.drawable.myrowborder));
                tableRow.setOnClickListener(this::rowCLick);

                    TextView txtJobID = new TextView(context);
                    txtJobID.setText(taskJSON.getString("Job_ID"));
                    txtJobID.setWidth(250);
                    txtJobID.setTextAlignment(View.TEXT_ALIGNMENT_CENTER);
                    tableRow.addView(txtJobID);
                    TextView txtJobName = new TextView(context);
                    txtJobName.setText(taskJSON.getString("Job_Name"));
                    txtJobName.setWidth(250);
                    txtJobName.setTextAlignment(View.TEXT_ALIGNMENT_CENTER);
                    tableRow.addView(txtJobName);
                    TextView txtassignedTo = new TextView(context);
                    txtassignedTo.setText(taskJSON.getString("AssignedTo"));
                    txtassignedTo.setTextAlignment(View.TEXT_ALIGNMENT_CENTER);
                    txtassignedTo.setWidth(400);
                    tableRow.addView(txtassignedTo);
                    TextView txtDateSet = new TextView(context);
                    txtDateSet.setText(taskJSON.getString("Set_Date"));
                    txtDateSet.setWidth(300);
                    tableRow.addView(txtDateSet);
                    TextView txtDueDate = new TextView(context);
                    txtDueDate.setText(taskJSON.getString("Due_Date"));
                    txtDueDate.setWidth(300);
                    tableRow.addView(txtDueDate);
                    TextView txtCompleteDate = new TextView(context);
                    txtCompleteDate.setText(taskJSON.getString("Complete_Date"));
                    tableRow.addView(txtCompleteDate);
                    CheckBox ckComplete = new CheckBox(context);
                    ckComplete.setChecked(taskJSON.getBoolean("Complete"));
                    tableRow.addView(ckComplete);
                mainTablelayout.addView(tableRow);
            }*/
        } catch (JSONException e) {
            e.printStackTrace();
        }

    }


}