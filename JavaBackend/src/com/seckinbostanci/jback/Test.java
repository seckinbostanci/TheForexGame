package com.seckinbostanci.jback;

import java.io.*;
import java.net.*;

public class Test {
    public static void main(String[] args) throws IOException {

        int c;
        Socket s = new Socket("192.168.8.109", 1007);
        InputStream in = s.getInputStream();


        while ((c = in.read()) != -1) {
            System.out.print((char) c);
        }

        s.close();

    }
}
