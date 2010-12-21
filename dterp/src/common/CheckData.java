package common;

import java.util.Dictionary;

public class CheckData {
		private String  product_spec;
		private String product_lot_no;
		private String lot_no;
		private String product_status;
		private String product_stock;
		private String inven_month;
		private String emp_no;
		private int stock_count;
		private int inven_stock_count;
		private int revision_count;
		private String file_stock;
		private String producdt_stock;
		private String inven_time;
	
		public String getProducdt_stock() {
			return producdt_stock;
		}
		public void setProducdt_stock(String producdt_stock) {
			this.producdt_stock = producdt_stock;
		}
		public String getFile_stock() {
			return file_stock;
		}
		public void setFile_stock(String file_stock) {
			this.file_stock = file_stock;
		}
		public String getEmp_no() {
			
			return emp_no;
		}
		public void setEmp_no(String emp_no) {
			this.emp_no = emp_no;
		}
		public String getInven_month() {
			return inven_month;
		}
		public void setInven_month(String inven_month) {
			this.inven_month = inven_month;
		}
		public int getInven_stock_count() {
			return inven_stock_count;
		}
		public void setInven_stock_count(int inven_stock_count) {
			this.inven_stock_count = inven_stock_count;
		}
		public String getLot_no() {
			if(lot_no!=null){
				lot_no=lot_no.trim();
			}
			return lot_no;
		}
		public void setLot_no(String lot_no) {
			this.lot_no = lot_no;
		}
		public String getProduct_lot_no() {
			if(product_lot_no!=null){
				product_lot_no=product_lot_no.trim();
			}
			return product_lot_no;
		}
		public void setProduct_lot_no(String product_lot_no) {
			this.product_lot_no = product_lot_no;
		}
		public String getProduct_spec() {
			return product_spec;
		}
		public void setProduct_spec(String product_spec) {
			this.product_spec = product_spec;
		}
		public String getProduct_status() {
			return product_status;
		}
		public void setProduct_status(String product_status) {
			this.product_status = product_status;
		}
		public String getProduct_stock() {
			return product_stock;
		}
		public void setProduct_stock(String product_stock) {
			this.product_stock = product_stock;
		}
		public int getRevision_count() {
			return revision_count;
		}
		public void setRevision_count(int revision_count) {
			this.revision_count = revision_count;
		}
		public int getStock_count() {
			return stock_count;
		}
		public void setStock_count(int stock_count) {
			this.stock_count = stock_count;
		}
		public String getInven_time() {
			return inven_time;
		}
		public void setInven_time(String inven_time) {
			this.inven_time = inven_time;
		}
}
