package com.example.myproject.Runnables;

import android.view.View;
import android.widget.TableRow;
import android.widget.TextView;

import static com.example.myproject.fragment.HomeFragment.tableHome;

public class addTableRowRunnable implements Runnable{

    private String WONumber;
    private String jobTitle;
    public addTableRowRunnable(String WONumber,String jobTitle){
        this.WONumber = WONumber;
        this.jobTitle = jobTitle;
    }

    @Override
    public void run() {
        TableRow homeTableRow;
        homeTableRow = new TableRow(tableHome.getContext());
        homeTableRow.setOnClickListener(this::rowCLick);
        TextView WONumberTXT = new TextView(tableHome.getContext());
        WONumberTXT.setText(WONumber);
        WONumberTXT.setTextAlignment(View.TEXT_ALIGNMENT_CENTER);
        WONumberTXT.setWidth(250);
        homeTableRow.addView(WONumberTXT);
        TextView jobTitleTXT = new TextView(tableHome.getContext());
        jobTitleTXT.setText(jobTitle);
        jobTitleTXT.setTextAlignment(View.TEXT_ALIGNMENT_CENTER);
        jobTitleTXT.setWidth(250);
        homeTableRow.addView(jobTitleTXT);

        tableHome.addView(homeTableRow);
    }

    private void rowCLick(View row){
        TableRow thisRow = (TableRow) row;
        TextView WONumber = (TextView) thisRow.getChildAt(0);
        String JobID = WONumber.getText().toString();
        // Intent taskActivity = new Intent(context, TaskActivity.class);
        // taskActivity.putExtra(intentmsg,JobID);
        // context.startActivity(taskActivity);
    }
}
