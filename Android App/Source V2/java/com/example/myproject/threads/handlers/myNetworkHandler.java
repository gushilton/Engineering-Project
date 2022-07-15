package com.example.myproject.threads.handlers;

import android.os.Handler;
import android.os.Looper;
import android.os.Message;

import com.example.myproject.Runnables.JSONRunnable;
import com.example.myproject.TaskRunnable;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.nio.charset.StandardCharsets;

import static com.example.myproject.MainActivity.backgroundThread;
import static com.example.myproject.MainActivity.filterpreference;
import static com.example.myproject.MainActivity.settingpreference;
//import static com.example.myproject.MainActivity.taskgetMain;

import static com.example.myproject.TaskActivity.taskUpdate;
import static com.example.myproject.TaskActivity.taskgetTask;
import static com.example.myproject.fragment.HomeFragment.homeFragment;

public class myNetworkHandler extends Handler {


    @Override
    public void handleMessage(Message msg) {
        httpRequest(msg);
    }

    void httpRequest(Message msg) {
        int toDo = msg.what;
        HttpURLConnection connection = null;
        BufferedReader bufferedReader = null;
        StringBuffer stringBuffer = new StringBuffer();
        String connectionURL = "";

        String username = settingpreference.getString("Username", "false");
        String password = settingpreference.getString("Password", "false");
        String connection_server = settingpreference.getString("Server", "false");

        Boolean complete = filterpreference.getBoolean("filter_completed",false);
        Boolean AssignedMe = filterpreference.getBoolean("filter_AssignedMe",false);

        Boolean jobid = filterpreference.getBoolean("sort_jobID",true);
        Boolean dateDue = filterpreference.getBoolean("sort_dueDate",false);
        Boolean setDate = filterpreference.getBoolean("sort_setDate",false);
        Boolean maintID = filterpreference.getBoolean("sort_MaintenanceID",false);

        String sortby = "";
        String orderby = "";

        if (jobid && !dateDue && !setDate && !maintID){
            sortby = "Job_ID";
        } else if(!jobid && dateDue && !setDate && !maintID){
            sortby = "Date_Due";
        }else if(!jobid && !dateDue && setDate && !maintID){
            sortby = "Date_Set";
        }else if(!jobid && !dateDue && !setDate && maintID){
            sortby = "Maintanence_ID";
        }else{
            sortby = "Job_ID";
        }

        if (filterpreference.getBoolean("sort_Asc",true)){
            orderby = "ASC";
        }else {
            orderby = "DESC";
        }

        JSONObject send_json = new JSONObject();
        JSONObject filter_json = new JSONObject();
        JSONObject sort_json = new JSONObject();
        byte[] sendHeader;


        try {
            filter_json.put("complete",complete);
            filter_json.put("AssignedMe",AssignedMe);
            sort_json.put("sortby",sortby);
            sort_json.put("orderby",orderby);
            send_json.put("username", username);
            send_json.put("password", password);
            send_json.put("sort",sort_json);
            send_json.put("filters",filter_json);

            if (toDo == homeFragment) {
                connectionURL = "http://"+connection_server+"/Task/get_Tasks.php";
                send_json.put("sort",sort_json);
                send_json.put("filters",filter_json);
            }else if (toDo == taskgetTask){
                connectionURL = "http://"+connection_server+"/Task/get_TaskInfo.php";
                String jobID = msg.obj.toString();
                send_json.put("Job_ID",jobID);
            }else if (toDo == taskUpdate){
                connectionURL = "http://"+connection_server+"/Task/update_Task.php";
                String jobID = msg.obj.toString();
                send_json.put("Job_ID",jobID);
            }
            sendHeader = send_json.toString().getBytes(StandardCharsets.UTF_8);
            URL url = new URL(connectionURL);
            connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");

            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setRequestProperty("Content-Type", "application/json; utf-8");
            OutputStream outputStream = new DataOutputStream(connection.getOutputStream());
            outputStream.write(sendHeader);
            outputStream.close();

            InputStreamReader inputStreamReader = new InputStreamReader(connection.getInputStream());
            bufferedReader = new BufferedReader(inputStreamReader);
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                stringBuffer.append(line);
            }

        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (JSONException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            String response = stringBuffer.toString();
            Handler mainhandler = new Handler(Looper.getMainLooper());
            if (toDo == homeFragment) {
                backgroundThread.backgroundHandler.post(new JSONRunnable(response));
            } else if (toDo == taskgetTask) {
                mainhandler.post(new TaskRunnable(response));
            } else if (toDo == taskUpdate) {
            }

        }
    }
}
