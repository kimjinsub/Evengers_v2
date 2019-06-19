package com.event.evengers_v2.userClass;

public class Paging {
	private int maxNum; 		// 전체 글의 개수
	private int pageNum; 		// 현재 페이지 번호
	private int listCount; 		// 페이지당 나타낼 글의 갯수
	private int pageCount; 		// 페이지그룹당 페이지 갯수
	private String boardName; 	// 게시판의 종류

	public Paging(int maxNum, int pageNum, int listCount, int pageCount, String boardName) {
		this.maxNum = maxNum;
		this.pageNum = pageNum;
		this.listCount = listCount;
		this.pageCount = pageCount;
		this.boardName = boardName;
	}

	@SuppressWarnings("unused")
	public String makeHtmlPaging() {
		// 전체 페이지 갯수
		int totalPage = (maxNum % listCount > 0)
				?maxNum/listCount+1 : maxNum/listCount;
		// 전체 페이지 그룹 갯수
		int totalGroup = (totalPage % pageCount > 0)
				? totalPage/pageCount+1 : totalPage/pageCount;
		// 현재 페이지가 속해 있는 그룹 번호
		int currentGroup = (pageNum % pageCount > 0)
				? pageNum/pageCount+1 : pageNum/pageCount;
		
		System.out.println("pageNum:"+pageNum);
		System.out.println("pageCount:"+pageCount);
		System.out.println("maxNum:"+maxNum);
		System.out.println("listCount:"+listCount);
		System.out.println("totalPage:"+totalPage);
		System.out.println("totalGroup:"+totalGroup);
		System.out.println("currentGroup:"+currentGroup);
		
		return makeHtml(currentGroup, totalPage, boardName);
	}

	private String makeHtml(int currentGroup, int totalPage, String boardName) {
		StringBuffer sb = new StringBuffer();
		//현재그룹의 시작 페이지 번호
		int start = (currentGroup * pageCount) 
				    - (pageCount - 1);
		//현재그룹의 끝 페이지 번호
		int end = (currentGroup * pageCount >= totalPage)
				? totalPage
				: currentGroup * pageCount;

		if (start != 1) {
			sb.append("<a href='"+boardName+"pageNum=" + (start -1) + "&listCount="+listCount+"'>");
			sb.append("[이전]");
			sb.append("</a>");
		}

		for (int i = start; i <= end; i++) {
			if (pageNum != i) { //현재 페이지가 아닌 경우 링크처리
				sb.append("<a href='"+boardName+"pageNum=" + i + "&listCount="+listCount+"'>");
				sb.append(" [ ");
				sb.append(i);
				sb.append(" ] ");
				sb.append("</a>");
			} else { //현재 페이지인 경우 링크 해제
				sb.append("<font style='color:red;'>");
				sb.append(" [ ");
				sb.append(i);
				sb.append(" ] ");
				sb.append("</font>");
			}
		}
		if (end != totalPage) {
			sb.append("<a href='"+boardName+"pageNum=" + (end + 1) + "&listCount="+listCount+"'>");
			sb.append("[다음]");
			sb.append("</a>");
		}
		return sb.toString();
	}
	
	@SuppressWarnings("unused")
	public String makeHtmlAjaxPaging() {
		// 전체 페이지 갯수
		int totalPage = (maxNum % listCount > 0)
				?maxNum/listCount+1 : maxNum/listCount;
		// 전체 페이지 그룹 갯수
		int totalGroup = (totalPage % pageCount > 0)
				? totalPage/pageCount+1 : totalPage/pageCount;
		// 현재 페이지가 속해 있는 그룹 번호
		int currentGroup = (pageNum % pageCount > 0)
				? pageNum/pageCount+1 : pageNum/pageCount;
		return makeHtmlAjax(currentGroup, totalPage, boardName, listCount);
	}
	private String makeHtmlAjax(int currentGroup, int totalPage, String boardName,int listCount) {
		StringBuffer sb = new StringBuffer();
		//현재그룹의 시작 페이지 번호
		int start = (currentGroup * pageCount) 
				- (pageCount - 1);
		//현재그룹의 끝 페이지 번호
		int end = (currentGroup * pageCount >= totalPage)
				? totalPage
						: currentGroup * pageCount;
		if (start != 1) {
			sb.append("<div>");
			sb.append("<a href='javascript:"+boardName+"("+(start-1)+","+listCount+")'>");
			sb.append(" < ");
			sb.append("</a>");
			sb.append("</div>");
		}
		
		for (int i = start; i <= end; i++) {
			if (pageNum != i) { //현재 페이지가 아닌 경우 링크처리
				sb.append(" <div> ");
				sb.append("<a href='javascript:"+boardName+"("+i+","+listCount+")'>");
				sb.append(i);
				sb.append("</a>");
				sb.append(" </div> ");
			} else { //현재 페이지인 경우 링크 해제
				sb.append(" <div> ");
				sb.append("<font style='color:red;'>");
				sb.append(i);
				sb.append("</font>");
				sb.append(" </div> ");
			}
		}
		if (end != totalPage) {
			sb.append("<div>");
			sb.append("<a href='javascript:"+boardName+"("+(end+1)+","+listCount+")'>");
			sb.append(" > ");
			sb.append("</a>");
			sb.append("</div>");
		}
		return sb.toString();
	}
}
