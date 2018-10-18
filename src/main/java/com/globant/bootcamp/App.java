package com.globant.bootcamp;

public class App { 
    public static void main(String[] argv) {
        DataBaseQueries dbQueries = new DataBaseQueries();     
        dbQueries.printTeachers();
        dbQueries.printTeacherShedule();
    }
}
