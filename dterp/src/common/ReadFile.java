package common;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;



public class ReadFile {

	/**
	 * @param args
	 */
	
	
	
	public static List readFile(String name) {
		List barcodeList=new ArrayList();
        File file = new File(name);
       String abc= file.getAbsolutePath();
       if(!file.exists()){
    	   return new ArrayList();
       }
        
        String[] fileList=file.list();
        for(int i=0;i<fileList.length;i++){
        	Barcode barcode=new Barcode();
        	barcodeList.add(barcode);
        	BufferedReader reader = null;
            try {
                reader = new BufferedReader(new FileReader(file+"\\"+fileList[i]));
                String tempString = null;
                int line=1;
                barcode.setFileName(fileList[i]);
                barcode.setData(new ArrayList());
                while ((tempString = reader.readLine()) != null) {
                	if(tempString.trim().equals("")){
                		break;
                	}
                   if(line==1){
                	   barcode.setCreateTime(tempString);
                   }else if(line==2){
                	   barcode.setEmpNo(tempString);
                   }else if(line==3){
                	   barcode.setTag(tempString);
                   }else if(line==4){
                	   barcode.setStock(tempString);
                   }else{
                	  // char[] arr1=tempString.trim().toCharArray();
                	  // String temp1="";
                	  // for(int j=0;j<arr1.length;j++){
                		  // if(j==arr1.length-1){
                			   //temp1+=arr1[j];
                		   //}else{
                			   //temp1+=arr1[j]+"-";
                		   //}
                	   //}
                	   barcode.getData().add(tempString);
                   }
                    line++;
                }
                reader.close();
            } catch (IOException e) {
                e.printStackTrace();
            } finally {
                if (reader != null) {
                    try {
                        reader.close();
                    } catch (IOException e1) {
                    	e1.printStackTrace();
                    }
                }
            }
        }
        return barcodeList;
        
    
        
    }

}
