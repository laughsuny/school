package com.rocksuny.bean;

public class TreeData {
	/*private String id;
	private String text;
	private String pid;  
	private String url;
	private boolean isSub;
	
	*//**
	 * 是否选中菜单
	 *//*
	private boolean ischecked; 
	
	*//**
	 * 是否显示
	 *//*
	private Integer isdisplay;
	*//**
	 * 是否可编辑
	 *//*
	private Integer iseditable;
	*//**
	 * 删除状态 0 删除 1 没删除
	 *//*
	private Integer status;
	
	private String remark;
	
	private String furl;
	
	private String picUrl;
	private Integer orderNum;
	private Integer layerId;
	private Integer rootid;
	private String roleList;
	private Integer createUser;
	private Date createTime;
	
	
	private List<FsArticle> articleList;//菜单对应文章集合
	
	private List<TreeData> subDatas;//他的子集合
	private List<TreeData> treeData;//菜单对子菜单集合
	
	
	public String lastPublishUserName;//最后文章发布者
	public Date lastPublishDate;//最为文章发布时间
	public String lastPublishArticleTitle;//最后发布文章标题
	public Integer articleTotalCount;//文章总数
	
	
	public TreeData(){
		
	}
	public TreeData(String id,String text,String furl){
		this.id = id;
		this.text = text;
		this.furl = furl;
	}
	
	public TreeData(String id,String text,String pid,String url,boolean isSub){
		this.id = id;
		this.text = text;
		this.pid = pid;
		this.url = url;
		this.isSub = isSub;
	}
	public TreeData(String id,String text,String pid,boolean isSub){
		this.id = id;
		this.text = text;
		this.pid = pid;
		this.isSub = isSub;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public boolean isSub() {
		return isSub;
	}
	public void setSub(boolean isSub) {
		this.isSub = isSub;
	}
	public boolean isIschecked() {
		return ischecked;
	}
	public void setIschecked(boolean ischecked) {
		this.ischecked = ischecked;
	}
	public Integer getIsdisplay() {
		return isdisplay;
	}
	public void setIsdisplay(Integer isdisplay) {
		this.isdisplay = isdisplay;
	}
	public Integer getIseditable() {
		return iseditable;
	}
	public void setIseditable(Integer iseditable) {
		this.iseditable = iseditable;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getFurl() {
		return furl;
	}
	public void setFurl(String furl) {
		this.furl = furl;
	}
	public String getPicUrl() {
		return picUrl;
	}
	public void setPicUrl(String picUrl) {
		this.picUrl = picUrl;
	}
	public Integer getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}
	public Integer getLayerId() {
		return layerId;
	}
	public void setLayerId(Integer layerId) {
		this.layerId = layerId;
	}
	public Integer getRootid() {
		return rootid;
	}
	public void setRootid(Integer rootid) {
		this.rootid = rootid;
	}
	public String getRoleList() {
		return roleList;
	}
	public void setRoleList(String roleList) {
		this.roleList = roleList;
	}
	public Integer getCreateUser() {
		return createUser;
	}
	public void setCreateUser(Integer createUser) {
		this.createUser = createUser;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public List<FsArticle> getArticleList() {
		return articleList;
	}
	public void setArticleList(List<FsArticle> articleList) {
		this.articleList = articleList;
	}
	public List<TreeData> getSubDatas() {
		return subDatas;
	}
	public void setSubDatas(List<TreeData> subDatas) {
		this.subDatas = subDatas;
	}
	public List<TreeData> getTreeData() {
		return treeData;
	}
	public void setTreeData(List<TreeData> treeData) {
		this.treeData = treeData;
	}
	public String getLastPublishUserName() {
		return lastPublishUserName;
	}
	public void setLastPublishUserName(String lastPublishUserName) {
		this.lastPublishUserName = lastPublishUserName;
	}
	public Date getLastPublishDate() {
		return lastPublishDate;
	}
	public void setLastPublishDate(Date lastPublishDate) {
		this.lastPublishDate = lastPublishDate;
	}
	public String getLastPublishArticleTitle() {
		return lastPublishArticleTitle;
	}
	public void setLastPublishArticleTitle(String lastPublishArticleTitle) {
		this.lastPublishArticleTitle = lastPublishArticleTitle;
	}
	public Integer getArticleTotalCount() {
		return articleTotalCount;
	}
	public void setArticleTotalCount(Integer articleTotalCount) {
		this.articleTotalCount = articleTotalCount;
	}
	*/
	
	
}
