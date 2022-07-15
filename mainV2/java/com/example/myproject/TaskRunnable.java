package com.example.myproject;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import static com.example.myproject.TaskActivity.*;



public class TaskRunnable implements Runnable {
    private String response;

    public TaskRunnable(String response){
        this.response = response;
    }

    @Override
    public void run() {

        try {
            JSONObject jsonObject = new JSONObject(response);
            JSONObject taskObject = jsonObject.getJSONObject("task");
            jobIDtxt.setText(taskObject.getString("Job_ID"));
            jobDescriptiontxt.setText(taskObject.getString("Job_Name"));
            dueDatetxt.setText(taskObject.getString("Date_Due"));
            setDatetxt.setText(taskObject.getString("Date_Set"));
            completeDatetxt.setText(taskObject.getString("Date_Complete"));
            ckComplete.setChecked(taskObject.getBoolean("Complete"));
        } catch (JSONException e) {
            e.printStackTrace();
        }
    }
}
