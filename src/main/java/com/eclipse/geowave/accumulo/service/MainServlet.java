package com.eclipse.geowave.accumulo.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

/**
 * Servlet implementation class MainServlet
 */
public class MainServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public MainServlet() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter write = response.getWriter();
		read(write);
		// write.println("Rukshan");
	}

	public void read(PrintWriter write) {
		try {
			// URL path = new URL("http://localhost:50095/");
			// URL path = new URL("http://localhost:50095/");
			File f = new File(
					"/home/rukshan/rukshan/com.eclipse.geowave.accumulo.service/src/main/resources/index.xml");
			URL path = f.toURL();

			// BufferedReader in = new BufferedReader(new InputStreamReader(
			// oracle.openStream()));

			BufferedReader in = new BufferedReader(new FileReader(f));

			String inputLine;
			String xml = "";
			while ((inputLine = in.readLine()) != null) {
				// System.out.println(inputLine);
				// write.println(inputLine);
				xml += inputLine;
			}
			// write.println("<p>"+xml+"</p>");
			in.close();
			parse(f, write);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	public void parse(File xml, PrintWriter write)
			throws XPathExpressionException, FileNotFoundException {
		XPath xpath = XPathFactory.newInstance().newXPath();
		// String expression =
		// "//*[@id='main']/p/table/tbody/tr[2]/td[1]/script";
		String expression = "//body//*/script";
		// InputSource inputSource = new InputSource("index.xml");
		InputSource inputSource = new InputSource(new FileInputStream(xml));
		NodeList nodes = (NodeList) xpath.evaluate(expression, inputSource,
				XPathConstants.NODESET);
		System.out.println(nodes.getLength());
		int cnt = 0;
		String json = "{";
		for (int i = 0; i < nodes.getLength(); i++) {

			String val = nodes.item(i).getTextContent();
			val = val.replace("$(function () {", "");
			int in = val.indexOf("$.plot");
			// System.out.println(in);
			if (in > 0) {
				val = val.substring(0, in);
				val = val.trim();

				if (val != "" && val != "\n" && val != " ") {
					// cnt++;
					if (i == 1) {
						String vals[] = val.split(";");
						System.out.println(vals[0].trim().replace("d0",
								"d" + cnt));
						vals[0]=vals[0].replace(";", "");
						json += "\"d" + cnt + "\" : " + vals[0].trim().split("=")[1] + ",";

						cnt++;

						System.out.println(vals[1].trim().replace("d1",
								"d" + cnt));
						vals[1]=vals[1].replace(";", "");
						json += "\"d" + cnt + "\" : " + vals[1].trim().split("=")[1] + ",";

					} else {

						// String v=val.replace("d0", "d" + cnt);
						System.out.println(val.replace("d0", "d" + cnt));
						// write.println(val.replace("d0", "d" + cnt));
						val=val.replace(";", "");
						json += "\"d" + cnt + "\" : " + val.split("=")[1] + ",";
					}
					cnt++;

				}
			}
			System.out.println();
		}
		json += "\"a\":123}";
		write.println(json);
	}
}
