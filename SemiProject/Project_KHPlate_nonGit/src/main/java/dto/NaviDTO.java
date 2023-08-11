package dto;

import java.util.ArrayList;

public class NaviDTO {
	private ArrayList<Integer> naviList;
	private boolean needPrev;
	private boolean needNext;
	public NaviDTO(ArrayList<Integer> naviList, boolean needPrev, boolean needNext) {
		super();
		this.naviList = naviList;
		this.needPrev = needPrev;
		this.needNext = needNext;
	}
	public ArrayList<Integer> getNaviList() {
		return naviList;
	}
	public void setNaviList(ArrayList<Integer> naviList) {
		this.naviList = naviList;
	}
	public boolean isNeedPrev() {
		return needPrev;
	}
	public void setNeedPrev(boolean needPrev) {
		this.needPrev = needPrev;
	}
	public boolean isNeedNext() {
		return needNext;
	}
	public void setNeedNext(boolean needNext) {
		this.needNext = needNext;
	}
	
}
