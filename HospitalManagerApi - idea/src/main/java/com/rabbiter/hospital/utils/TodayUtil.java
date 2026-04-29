package com.rabbiter.hospital.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class TodayUtil {

    public static String getToday() {
        Calendar calendar = Calendar.getInstance();
        String year = String.valueOf(calendar.get(Calendar.YEAR));
        String month = String.valueOf(calendar.get(Calendar.MONTH) + 1);
        String date = String.valueOf(calendar.get(Calendar.DATE));
        String day = String.valueOf(calendar.get(Calendar.HOUR_OF_DAY));
        String minute = String.valueOf(calendar.get(Calendar.MINUTE));
        String second = String.valueOf(calendar.get(Calendar.SECOND));
        if (calendar.get(Calendar.MONTH) + 1 < 10)
            month = "0" + month;
        if (calendar.get(Calendar.DATE) < 10)
            date = "0" + date;
        return year + "-" + month + "-" + date + " " + day + ":" + minute + ":" + second;
    }

    public static String getTodayYmd() {
        Calendar calendar = Calendar.getInstance();
        Date today = calendar.getTime();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String result = format.format(today);
        return result;
    }

    //获取过去的第past天
    public static String getPastDate(int past) {
        Calendar calendar = Calendar.getInstance();
        //System.out.println(calendar.get(Calendar.DAY_OF_YEAR));
        calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - past);
        Date today = calendar.getTime();
        //System.out.println(today);
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        String result = format.format(today);
        return result;
    }

    public static double getDrugTotal(String drugInfo) {
        String regex = "药物总价(\\d+)元";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(drugInfo);

        if (matcher.find()) {
            return Double.valueOf(matcher.group(1));
        }
        return 0;

    }

    public static double getCheckTotal(String checkInfo) {
        String regex = "项目总价(\\d+)元";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(checkInfo);

        if (matcher.find()) {
            return Double.valueOf(matcher.group(1));
        }
        return 0;

    }
}
