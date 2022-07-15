package com.example.myproject;

import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBarDrawerToggle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.core.view.GravityCompat;
import androidx.drawerlayout.widget.DrawerLayout;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.widget.Toast;

import com.example.myproject.fragment.HomeFragment;
import com.example.myproject.fragment.StockFragment;
import com.example.myproject.fragment.TimesheetFragment;
import com.example.myproject.threads.NetworkThread;
import com.example.myproject.threads.backgroundThread;
import com.google.android.material.navigation.NavigationView;

import org.jetbrains.annotations.NotNull;


public class MainActivity extends AppCompatActivity implements NavigationView.OnNavigationItemSelectedListener {

    private DrawerLayout drawerLayout;
    public static NetworkThread networkThread;
    public static backgroundThread backgroundThread;
    public static SharedPreferences filterpreference,settingpreference;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        filterpreference = this.getSharedPreferences("preferencefilter",MODE_PRIVATE);
        settingpreference = this.getSharedPreferences("preferencesettings",MODE_PRIVATE);

        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        drawerLayout = findViewById(R.id.drawLayout);
        NavigationView navigationView = findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);

        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(this,drawerLayout,toolbar,R.string.nav_draw_open,R.string.nav_draw_close);
        drawerLayout.addDrawerListener(toggle);
        toggle.syncState();
        if(savedInstanceState == null) {
            getSupportFragmentManager().beginTransaction().replace(R.id.frameLayout, new HomeFragment()).commit();
            navigationView.setCheckedItem(R.id.nav_home);
        }
        networkThread = new NetworkThread();
        networkThread.start();
        backgroundThread = new backgroundThread();
        backgroundThread.start();
    }
    @Override
    public boolean onNavigationItemSelected(@NonNull @NotNull MenuItem item) {
        switch (item.getItemId()){
            case R.id.nav_home:
                getSupportFragmentManager().beginTransaction().replace(R.id.frameLayout,new HomeFragment()).commit();
                break;
            case R.id.nav_timesheet:
                getSupportFragmentManager().beginTransaction().replace(R.id.frameLayout,new TimesheetFragment()).commit();
                break;
            case R.id.nav_stock:
                getSupportFragmentManager().beginTransaction().replace(R.id.frameLayout,new StockFragment()).commit();
                break;
            case R.id.nav_random:
                Toast.makeText(this, "Button random pressed", Toast.LENGTH_SHORT).show();
                break;
        }
        drawerLayout.closeDrawer(GravityCompat.START);
        return true;
    }
    @Override
    public void onBackPressed() {
        if (drawerLayout.isDrawerOpen(GravityCompat.START)){
          drawerLayout.closeDrawer(GravityCompat.START);
        }else{
        super.onBackPressed();
        }
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
    }

    public void filterbtr(MenuItem item){
    }

}
