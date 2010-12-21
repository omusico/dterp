package common;

import java.util.List;

public class Barcode {
	
    //文件名字
	private String fileName;
	//时间
	private String createTime;
	//员工编号
	private String empNo;
	//标记
	private String tag;
	//仓库
	private String stock;
	//数据
	private List data;
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
	
	public List getData() {
		return data;
	}
	public void setData(List data) {
		this.data = data;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getEmpNo() {
		return empNo;
	}
	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getStock() {
		return stock;
	}
	public void setStock(String stock) {
		this.stock = stock;
	}
}
