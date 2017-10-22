package coordinate;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class main {
	public static void main(String[] args) throws FileNotFoundException{
		String csvFile = "/Users/xmeng17/city.csv";
        String line = "";
        String cvsSplitBy = ",";


        
        PrintWriter pw = new PrintWriter(new File("/Users/xmeng17/city2.csv"));
        StringBuilder sb = new StringBuilder();
        
       // CoordinateConversion cc=new CoordinateConversion();
        
        try (BufferedReader br = new BufferedReader(new FileReader(csvFile))) {
        	
                while ((line = br.readLine()) != null) {
                	String[] city = line.split(cvsSplitBy);
                	sb.append(city[0]);
                	sb.append(",");
                	sb.append(Double.toString((Double.parseDouble(city[1])/10000-0.498)*1.14));
                	sb.append(",");
                    sb.append(Double.toString((Double.parseDouble(city[2])/4235-0.51)*0.8));
                    sb.append("\n");
                }

         
        } catch (IOException e) {
            e.printStackTrace();
        }
		
        pw.write(sb.toString());
        pw.close();
		
		
		
	}

}
