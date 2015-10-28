package com.csxh.model;

public class Pager {

	//�ܵļ�¼���������ݿ��ѯ�ȵ�
	private int totalRows;
	
	//ÿҳ�����ʾ�ļ�¼��
	private int pageRows;
	
	//������ҳ
	private int pageCount;
	
	//��ǰ�ǵڼ�ҳ����1��ʼ����
	private int currentPage=1;
	

	public Pager(int totalRows, int pageSize) {
		super();
		
		this.totalRows = totalRows;
		this.pageRows = pageSize;
		this.pageCount=(int)Math.ceil((double)this.totalRows/(double)this.pageRows);
		
	}
	
	//��ǰҳ��һ����¼�����ݿ�ı�ţ���0��ʼ��
	public int getFirstRow(){
		return (this.currentPage-1)*this.pageRows;
		
	}
	 
	public int getLastRow(){
		return getFirstRow()+this.pageCount;
	}

	public int getTotalRows() {
		return totalRows;
	}

	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}

	public int getPageRows() {
		return pageRows;
	}
	
	public void setPageRows(int pageRows) {
		this.pageRows = pageRows;
	}
	
	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getPageCount() {
		return pageCount;
	}
	
	public boolean ishasPrev(){
		return this.currentPage-1>0;
	}
	
	public boolean ishasNext(){
		return this.currentPage+1<=this.pageCount;
	}
	
}
