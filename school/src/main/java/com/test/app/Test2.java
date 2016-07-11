package com.test.app;

import java.io.IOException;
import java.util.Scanner;

public class Test2 {

	public static void main(String[] args) {
		
		test1();
		
		/*try {
			(new java.lang.ProcessBuilder(new java.lang.String[]{"whoami"})).start();
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		
		
	}
	
	
	@SuppressWarnings("resource")
	public static void test1(){
		try {
			Scanner s = new java.util.Scanner(
					(new java.lang.ProcessBuilder("cmd /c dir d:\\".toString().split("\\s"))).start().getInputStream()
					)
							.useDelimiter("\\AAAA");

			String str = s.hasNext() ? s.next() : "";

			System.out.println(str);

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
