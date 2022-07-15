package com.example.myproject.fragment;

import android.os.Bundle;
import android.os.Message;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;

import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout;

import com.example.myproject.R;

import static com.example.myproject.MainActivity.networkThread;

public class HomeFragment extends Fragment {
    public static final int homeFragment = 0;
    public static TableLayout tableHome;
    private SwipeRefreshLayout homeRefreshLayout;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
       View homeview = inflater.inflate(R.layout.homefragment,container,false);
        tableHome = (TableLayout) homeview.findViewById(R.id.tableHome);
        homeRefreshLayout = (SwipeRefreshLayout)homeview.findViewById(R.id.homeSwipeRefresh);
        homeRefreshLayout.setOnRefreshListener(new SwipeRefreshLayout.OnRefreshListener() {
            @Override
            public void onRefresh() {
                refresh();
            }
        });
        return homeview;
    }

    private void refresh(){
        homeRefreshLayout.setRefreshing(true);
        while (tableHome.getChildCount() != 0) {
            tableHome.removeViewAt(0);
        }

        TableRow tableRow = new TableRow(tableHome.getContext());
        TextView txtJobIDLB = new TextView(tableHome.getContext());
        txtJobIDLB.setText("Job ID");
        txtJobIDLB.setWidth(250);
        txtJobIDLB.setTextAlignment(View.TEXT_ALIGNMENT_CENTER);
        tableRow.addView(txtJobIDLB);
        TextView txtJobNameLB = new TextView(tableHome.getContext());
        txtJobNameLB.setText("Name");
        txtJobNameLB.setWidth(250);
        txtJobNameLB.setTextAlignment(View.TEXT_ALIGNMENT_CENTER);
        tableRow.addView(txtJobNameLB);
        TextView txtassignedTo = new TextView(tableHome.getContext());
        txtassignedTo.setText("Assigned To");
        txtassignedTo.setWidth(400);
        txtassignedTo.setTextAlignment(View.TEXT_ALIGNMENT_CENTER);
        tableRow.addView(txtassignedTo);
        TextView txtDateSet = new TextView(tableHome.getContext());
        txtDateSet.setText("Date Set");
        txtDateSet.setWidth(300);
        tableRow.addView(txtDateSet);
        TextView txtDueDate = new TextView(tableHome.getContext());
        txtDueDate.setText("Date Due");
        txtDueDate.setWidth(300);
        tableRow.addView(txtDueDate);
        TextView txtCompleteDate = new TextView(tableHome.getContext());
        txtCompleteDate.setText("  Completeted On  ");
        tableRow.addView(txtCompleteDate);
        TextView txtComplete = new TextView(tableHome.getContext());
        txtComplete.setText("  Complete  ");
        tableRow.addView(txtComplete);

        Message message = Message.obtain();
        message.what = homeFragment;
        networkThread.networkHandler.sendMessage(message);
        homeRefreshLayout.setRefreshing(true);
    }

}
