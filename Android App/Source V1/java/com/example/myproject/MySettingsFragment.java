package com.example.myproject;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.OnSharedPreferenceChangeListener;
import android.os.Bundle;
import android.preference.EditTextPreference;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.widget.EditText;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.preference.EditTextPreferenceDialogFragmentCompat;
import androidx.preference.PreferenceFragmentCompat;
import androidx.preference.PreferenceManager;


public class MySettingsFragment extends PreferenceActivity {
    SharedPreferences sharedPreferences;
    EditTextPreference username,password,server;
    Context context;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        addPreferencesFromResource(R.xml.preferencesettings);
        sharedPreferences = this.getSharedPreferences("preferencesettings",MODE_PRIVATE);

        username =(EditTextPreference)findPreference("Username");
        username.setText(sharedPreferences.getString("Username","false"));
        username.setOnPreferenceChangeListener(new Preference.OnPreferenceChangeListener() {
            @Override
            public boolean onPreferenceChange(Preference preference, Object newValue) {
                String username = newValue.toString();
                SharedPreferences.Editor settingeditor = sharedPreferences.edit();
                settingeditor.putString("Username",username);
                settingeditor.apply();
                return true;
            }
        });

        password = (EditTextPreference)findPreference("Password");
        password.setText(sharedPreferences.getString("Password","false"));
        password.setOnPreferenceChangeListener(new Preference.OnPreferenceChangeListener() {
            @Override
            public boolean onPreferenceChange(Preference preference, Object newValue) {
                String password = newValue.toString();
                SharedPreferences.Editor settingeditor = sharedPreferences.edit();
                settingeditor.putString("Password",password);
                settingeditor.apply();
                return true;
            }
        });

        server = (EditTextPreference)findPreference("Server");
        server.setText(sharedPreferences.getString("Server","false"));
        server.setOnPreferenceChangeListener(new Preference.OnPreferenceChangeListener() {
            @Override
            public boolean onPreferenceChange(Preference preference, Object newValue) {
                String server = newValue.toString();
                SharedPreferences.Editor settingeditor = sharedPreferences.edit();
                settingeditor.putString("Server",server);
                settingeditor.apply();
                return true;
            }
        });

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }
}

