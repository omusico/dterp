package manufacture.process;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;

public class FileRead {
	private SmartUpload upload;

	public FileRead() {
		upload = new SmartUpload();
	}

	/**
	 * 上传和下载的初始化
	 * 
	 * @param config
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 * @throws SmartUploadException
	 */
	public void prepare(ServletConfig config, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException,
			SmartUploadException {

		upload.initialize(config, request, response);

	}

	/**
	 * 上传文件时对文件的约束
	 * 
	 * @param maxFileSize
	 * @param maxTotalSize
	 * @param allowFileList
	 * @param deniedFilesList
	 * @throws SQLException
	 * @throws IOException
	 * @throws ServletException
	 * @throws ServletException
	 * @throws IOException
	 * @throws SQLException
	 */
	public void setUploadLimited(long maxFileSize, long maxTotalSize,
			String allowFileList, String deniedFilesList)
			throws ServletException, IOException, SQLException {
		// 1.限制每个上传文件的最大长度。
		if (maxFileSize != 0) {
			upload.setMaxFileSize(maxFileSize);
		}
		// 2.限制总上传数据的长度。
		if (maxTotalSize != 0) {
			upload.setTotalMaxFileSize(maxTotalSize);
		}

		// 3.设定允许上传的文件（通过扩展名限制）
		if (allowFileList != null && !allowFileList.equals("")) {
			// 仅允许doc,txt文件。
			// upload.setAllowedFilesList("doc,txt");
			upload.setAllowedFilesList(allowFileList);
		}
		// 4.设定禁止上传的文件（通过扩展名限制）
		if (deniedFilesList != null && !deniedFilesList.equals("")) {
			// ,禁止上传带有exe,bat,jsp,htm,html扩展名的文件和没有扩展名的文件。
			// su.setDeniedFilesList("exe,bat,jsp,htm,html");
			upload.setDeniedFilesList(deniedFilesList);
		}
	}

	/**
	 * 上传
	 * 
	 * @throws ServletException
	 * @throws IOException
	 * @throws SmartUploadException
	 */
	public void upload() throws ServletException, IOException,
			SmartUploadException {
		upload.upload();
	}

	/**
	 * 产一个帐单号
	 * 
	 * @return
	 */
	public String getOrderNumber() {
		java.util.Date dt = new java.util.Date(System.currentTimeMillis());
		String t = dt.toString();
		return t.substring(24, t.length()) + t.substring(8, 10)
				+ t.substring(11, 13) + t.substring(14, 16)
				+ t.substring(17, 19);
	}

	/**
	 * 
	 * @return 当前时间
	 */
	public String getTime() {

		return new java.sql.Date(System.currentTimeMillis()).toString();
	}

	/**
	 * 读取文件流 返回一个行数和行内容的hashmap
	 */
	public Map<Integer, String> readF(String filePath) throws IOException {
		FileReader fr = new FileReader(filePath);
		BufferedReader bufferedreader = new BufferedReader(fr);
		String instring;
		Map<Integer, String> filerows = new HashMap<Integer, String>();
		int i = 1;// 记录实际行数

		while ((instring = bufferedreader.readLine()) != null) {

			if (!instring.trim().equals("")) {
				filerows.put(i, instring.trim());
				i++;
			}

		}
		filerows.put(0, String.valueOf(i - 1));// 将记录有效信息存放在key为0的value里
		fr.close();

		return filerows;
	}

	// 1.生产模块的方法 start
	public Map<Integer, String> readF2(String filePath) throws IOException {

		Map<Integer, String> filerows = new HashMap<Integer, String>();
		filerows = readF(filePath);
		Map<Integer, String> filerows_m = new HashMap<Integer, String>();

//		int num_m = filerows.size();
//
//		int y = 1;// 记录有效行数
//		for (int i = 1; i < num_m; i++, y++) {
//			if (filerows.get(i).trim().toLowerCase().equals("err")) {
//				if (y > 3) {
//					y = y - 2;
//				} else {
//					y = 0;// 前三行有错误信息时清0
//				}
//			} else {
//				filerows_m.put(y, filerows.get(i));// 如果信息不是err，添加map集合信息
//			}
//		}
		for(int i=0;i<filerows.size();i++){
			if(filerows.get(i).trim().toLowerCase().equals("err")){
				filerows.put(i,"0");
				filerows.put((i-1),"0");
			}
		}
		int k=0;
		for(int i=0;i<filerows.size();i++){
			if(!filerows.get(i).trim().equals("0")){
				filerows_m.put(k,filerows.get(i));
				k++;
			}
		}
		for(int i=0;i<filerows_m.size();i++){
			System.out.println(filerows_m.get(i));
		}
		
		//filerows_m.put(0, String.valueOf(y - 1));// 将记录有效信息存放在key为0的value里
		return filerows_m;
	}

	public List<String> readF2Over(String filePath) throws IOException {

		Map<Integer, String> filerows = new HashMap<Integer, String>();
		filerows = readF(filePath);
		List<String> filerows_m = new ArrayList<String>();

		for(int i=0;i<filerows.size();i++){
			if(filerows.get(i).toLowerCase().equals("err")){
				filerows.put(i,"0");
				filerows.put((i-1),"0");
			}
		}
		
		for(int i=0;i<filerows.size();i++){
			if(!filerows.get(i).equals("0")){
				filerows_m.add(filerows.get(i));
			}
		}
		
		return filerows_m;
	}

	/**
	 * 
	 * @param filePath
	 * @return
	 * @throws IOException
	 */
	public List<String> readF2Z(String filePath) throws IOException {
		List<String> filerows = this.readF2Over(filePath);
		List<String> list = new ArrayList<String>();
		for (int i = 0; i < filerows.size(); i++) {
			if (i > 3) {
				list.add(filerows.get(i));
			}
		}
		return list;
	}

	// 1.生产模块方法 end

	// 2.库存模块方法 start
	/**
	 * 读取文件的方法
	 * 
	 * @filePath 传入文件的路径 return 正确的数据
	 */
	public List<String> readDocument(String filePath) throws IOException {
		Map<Integer, String> filerows = new HashMap<Integer, String>();
		filerows = readF(filePath);
		Map<Integer, String> text = new HashMap<Integer, String>();
		text = readF(filePath);

		for (int i = 0; i < filerows.values().size(); i++) {
			if (i > 3 && i < filerows.values().size() - 1) {
				// LOTNO
				if (CharIsLetter(filerows.get(i).substring(0, 1)) == false
						&& CharIsLetter(filerows.get(i + 1).substring(0, 1)) == false) {
					filerows.put(i, "0");
					continue;
				}
				// 库位
				if (CharIsLetter(filerows.get(i).substring(0, 1)) == true
						&& CharIsLetter(filerows.get(i + 1).substring(0, 1)) == true) {
					filerows.put(i, "0");
					continue;
				}
			}
		}
		// 把集合除0外的值给LIST集合
		List<String> list = new ArrayList<String>();
		for (int i = 0; i < filerows.values().size(); i++) {
			if (!filerows.get(i).toString().equals("0")) {
				list.add(filerows.get(i));
			}

		}

		return list;
	}
	public List<String> readDocument1(String filePath) throws IOException {
		List list = this.readDocument1(filePath);
		List l = new ArrayList();
		for(int i=0;i<list.size();i++){
				if(i>3){
					list.add(l.get(i));
				}
		}
		return l;
	}
	// 成品内容替换
	public List<String> readSuccess(String filePath) throws IOException {
		Map<Integer, String> filerows = new HashMap<Integer, String>();
		filerows = readF2(filePath);
		List<String> list = new ArrayList<String>();

		for (int i = 0; i < filerows.values().size(); i++) {
			if (i > 3) {
				list.add(filerows.get(i));
			}
		}

		return list;
	}

	// 被替换的LOTNO
	public List<String> readSuccessFirst(String filePath) throws IOException {
		Map<Integer, String> filerows = new HashMap<Integer, String>();
		filerows = readF2(filePath);
		List<String> list = new ArrayList<String>();

		for (int i = 0; i < filerows.values().size(); i++) {
			if (i > 3) {
				if (CharIsLetter(filerows.get(i).substring(0, 2))||CharIsLetter(filerows.get(i).substring(0, 1))) {
					break;
				} else {
					list.add(filerows.get(i));
				}
			}
		}

		return list;
	}

	// 栈板号
	public List<String> readSuccessMiddle(String filePath) throws IOException {
		Map<Integer, String> filerows = new HashMap<Integer, String>();
		filerows = readF2(filePath);
		List<String> list = new ArrayList<String>();

		for (int i = 0; i < filerows.values().size(); i++) {
			if (i > 3) {
				if (CharIsLetter(filerows.get(i).substring(0, 2))||CharIsLetter(filerows.get(i).substring(0, 1))) {
					list.add(filerows.get(i));
					break;
				}
			}
		}

		return list;
	}

	// 要替换内容原来的数据
	public List<String> readSuccessList(String filePath) throws IOException {
		Map<Integer, String> filerows = new HashMap<Integer, String>();
		filerows = readF2(filePath);
		List<String> list = new ArrayList<String>();
		int k = 0;
		for (int i = 0; i < filerows.values().size(); i++) {
			if (i > 3) {
				if (k == 1) {
					list.add(filerows.get(i));
				}
				if (CharIsLetter(filerows.get(i).substring(0, 2))||CharIsLetter(filerows.get(i).substring(0, 1))) {
					k = 1;
				}
			}
		}

		return list;
	}

	/**
	 * 读取文件的方法
	 * 
	 * @filePath 传入文件的路径 return 正确的数据
	 */
	public List<String> readDocumentS(String filePath) throws IOException {
		Map<Integer, String> filerows = new HashMap<Integer, String>();
		filerows = readF(filePath);
		Map<Integer, String> text = new HashMap<Integer, String>();
		text = readF(filePath);

		for (int i = 0; i < filerows.values().size(); i++) {
			if (i > 3 && i < filerows.values().size() - 1) {
				// LOTNO
				if ((filerows.get(i).length()==6||filerows.get(i).length()==7)&& (filerows.get(i+1).length()==6||filerows.get(i+1).length()==7)) {
					filerows.put(i, "0");
					continue;
				}
				// 库位
				if ((filerows.get(i).length()==5)&&(filerows.get(i+1).length()==5)) {
					filerows.put(i, "0");
					continue;
				}
			}
		}
		// 把集合除0外的值给LIST集合
		List<String> list = new ArrayList<String>();
		for (int i = 0; i < filerows.values().size(); i++) {
			if ((!filerows.get(i).toString().equals("0"))) {
				list.add(filerows.get(i));
			}

		}

		return list;
	}

	/**
	 * 获得栈板号
	 * 
	 * @param filePath
	 * @return
	 * @throws IOException
	 */
	public List<String> readDocumentZ(String filePath) throws IOException {
		List<String> list = this.readDocumentS(filePath);

		List<String> list1 = new ArrayList<String>();

		for (int i = 4; i < list.size(); i++) {
			if (list.get(i).length()!=5) {
				list1.add(list.get(i));
			}
		}
		return list1;
	}
	/**
	 * 获得栈板号
	 * 
	 * @param filePath
	 * @return
	 * @throws IOException
	 */
	public List<String> readDocumentZ1(String filePath) throws IOException {
		List<String> list = this.readDocumentS(filePath);

		List<String> list1 = new ArrayList<String>();

		for (int i = 4; i < list.size(); i++) {
			if (!list.get(i).trim().toLowerCase().equals("temp")) {
				list1.add(list.get(i));
			}
		}
		return list1;
	}
	/**
	 * 获得库位
	 * 
	 * @param filePath
	 * @return
	 * @throws IOException
	 */
	public List<String> readDocumentK(String filePath) throws IOException {
		List<String> list = this.readDocumentS(filePath);

		List<String> list1 = new ArrayList<String>();

		for (int i = 4; i < list.size(); i++) {
			if (list.get(i).length()==5) {
				list1.add(list.get(i));
			}
		}
		return list1;
	}
	public List<String> readDocumentK1(String filePath) throws IOException {
		List<String> list = this.readDocumentS(filePath);

		List<String> list1 = new ArrayList<String>();

		for (int i = 4; i < list.size(); i++) {
			if (list.get(i).trim().toLowerCase().equals("temp")) {
				list1.add(list.get(i));
			}
		}
		return list1;
	}

	/**
	 * 
	 * @param filePath
	 * @return
	 * @throws IOException
	 */
	public List<String> readLot(String filePath) throws IOException {
		List<String> listLotNo = this.readDocumentS(filePath);
		List<String> listLotNo1 = new ArrayList<String>();
		for (int i = 4; i < listLotNo.size(); i++) {
			listLotNo1.add(listLotNo.get(i));
		}
		return listLotNo1;
	}

	/**
	 * 读取文件的LOTNO
	 * 
	 * @param filePath
	 * @return
	 * @throws IOException
	 */
	public List<String> readLotNo(String filePath) throws IOException {
		List<String> listLotNo = this.readDocument(filePath);
		List<String> listLotNo1 = new ArrayList<String>();
		for (int i = 4; i < listLotNo.size(); i++) {
			if (CharIsLetter(listLotNo.get(i).substring(0, 1)) == false) {
				listLotNo1.add(listLotNo.get(i));
			}
		}
		return listLotNo1;
	}

	/**
	 * 读取文件的头部信息
	 * 
	 * @param filePath
	 * @return
	 * @throws IOException
	 */
	public List<String> readInformation(String filePath) throws IOException {
		List<String> listLotNo = this.readDocument(filePath);
		List<String> listLotNo1 = new ArrayList<String>();
		for (int i = 0; i < 4; i++) {
			listLotNo1.add(listLotNo.get(i));
		}
		return listLotNo1;
	}

	/**
	 * 读取文件库位信息
	 * 
	 * @param filePath
	 * @return
	 * @throws IOException
	 */
	public List<String> readDepart(String filePath) throws IOException {
		List<String> listLotNo = this.readDocument(filePath);
		List<String> listLotNo1 = new ArrayList<String>();
		for (int i = 4; i < listLotNo.size(); i++) {
			if (CharIsLetter(listLotNo.get(i).substring(0, 1)) == true) {
				listLotNo1.add(listLotNo.get(i));
			}
		}
		return listLotNo1;
	}

	public boolean CharIsLetter(String word) {
		boolean sign = true; // 初始化标志为为'true'
		for (int i = 0; i < word.length(); i++) { // 遍历输入字符串的每一个字符
			if (!Character.isLetter(word.charAt(i))) { // 判断该字符是否为英文字符
				sign = false; // 若有一位不是英文字符，则将标志位修改为'false'
			}
		}
		return sign; // 返回标志位结果
	}

	// 2.库存模块方法 end

	/**
	 * 验证一个字符串是否是整形
	 * 
	 * @param s
	 *            要验证的字符串
	 * @return 如果是整形则返回true,否则返回false
	 */
	public static boolean isInteger(String s) {
		if (s == null || s.length() == 0) {
			return false;
		} else {
			String str = "0123456789";
			String num = "-0123456789";
			if (num.indexOf(s.charAt(0)) < 0)
				return false;
			for (int i = 1; i < s.length(); i++) {
				if (str.indexOf(s.charAt(i)) < 0) {
					return false;
				} else {
					try {
						Integer.parseInt(s);
					} catch (NumberFormatException e) {
						return false;
					}
				}
			}
		}
		return true;
	}
}