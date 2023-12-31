package web.dto;

import java.util.Date;

public class Info {
	
	private int infoNo;
	private int adminNo;
	private String infoTitle;
	private Date infoUpload;
	private String infoState;
	private String infoUrl;
	
	public Info() {
		// TODO Auto-generated constructor stub
	}

	public Info(int infoNo, int adminNo, String infoTitle, String infoUrl, Date infoUpload, String infoState) {
		super();
		this.infoNo = infoNo;
		this.adminNo = adminNo;
		this.infoTitle = infoTitle;
		this.infoUrl = infoUrl;
		this.infoUpload = infoUpload;
		this.infoState = infoState;
	}

	@Override
	public String toString() {
		return "Info [infoNo=" + infoNo + ", adminNo=" + adminNo + ", infoTitle=" + infoTitle + ", infoUrl=" + infoUrl
				+ ", infoUpload=" + infoUpload + ", infoState=" + infoState + "]";
	}

	public int getInfoNo() {
		return infoNo;
	}

	public void setInfoNo(int infoNo) {
		this.infoNo = infoNo;
	}

	public int getAdminNo() {
		return adminNo;
	}

	public void setAdminNo(int adminNo) {
		this.adminNo = adminNo;
	}

	public String getInfoTitle() {
		return infoTitle;
	}

	public void setInfoTitle(String infoTitle) {
		this.infoTitle = infoTitle;
	}

	public String getInfoUrl() {
		return infoUrl;
	}

	public void setInfoUrl(String infoUrl) {
		this.infoUrl = infoUrl;
	}

	public Date getInfoUpload() {
		return infoUpload;
	}

	public void setInfoUpload(Date infoUpload) {
		this.infoUpload = infoUpload;
	}

	public String getInfoState() {
		return infoState;
	}

	public void setInfoState(String infoState) {
		this.infoState = infoState;
	}
	
	

	
}
	
	
	