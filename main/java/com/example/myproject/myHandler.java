package com.example.myproject;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import android.widget.TableLayout;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.concurrent.Callable;

import static com.example.myproject.MainActivity.taskgetMain;
import static com.example.myproject.TaskActivity.taskUpdate;
import static com.example.myproject.TaskActivity.taskgetTask;

public class myHandler extends Handler {


    @Override
    public void handleMessage(Message msg) {
        Context context = (Context) msg.obj;
        httpRequest(context,msg.what);
    }

    void httpRequest(Context context, int toDo) {
        HttpURLConnection connection = null;
        BufferedReader bufferedReader = null;
        StringBuffer stringBuffer = new StringBuffer();
        String connectionURL="";

        String username = context.getSharedPreferences("preferencesettings", Context.MODE_PRIVATE).getString("Username", "false");
        String password = context.getSharedPreferences("preferencesettings", Context.MODE_PRIVATE).getString("Password", "false");
        String connection_server = context.getSharedPreferences("preferencesettings", Context.MODE_PRIVATE).getString("Server", "false");

        JSONObject send_json = new JSONObject();
        byte[] tosend;

        try {
            send_json.put("username", username);
            send_json.put("password", password);
            tosend = send_json.toString().getBytes("utf-8");

            if (toDo == taskgetMain) {
                connectionURL = "http://"+connection_server+"/getTasks.php";
            }else if (toDo == taskgetTask){
                connectionURL = "http://"+connection_server+"/getTaskInfo.php";
            }else if (toDo == taskUpdate){
                connectionURL = "http://"+connection_server+"/getTaskInfo.php";
            }
            URL url = new URL(connectionURL);
            connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");


            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setRequestProperty("Content-Type", "application/json; utf-8");
            OutputStream outputStream = new DataOutputStream(connection.getOutputStream());
            outputStream.write(tosend);
            outputStream.close();



            int x = connection.getResponseCode();
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

            if (response != "failed" || response != ""){
            Handler mainhandler = new Handler(Looper.getMainLooper());
                if (toDo == taskgetMain) {
                    mainhandler.post(new JSONRunnable(context,response));
                }else if (toDo == taskgetTask){

                }else if (toDo == taskUpdate){

                }
            }
        }
    }

}
