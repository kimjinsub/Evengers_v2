package com.event.evengers_v2.userClass;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;


@Component
public class UploadFile {
	private String root;
	private String path;
	private File dir;

	public Map<String, String> singleFileUp(MultipartHttpServletRequest multi, int param) {
		Map<String,String> fileMap = new HashMap<String, String>();
		String e_orifilename = null;
		String e_sysfilename = null;
		switch (param) {
		case 1: // 썸네일 사진
			/*C:\Users\22\work\.metadata\.plugins\org.eclipse.wst.server.core\tmp2\wtpwebapps\Evengers*/
			root = multi.getSession().getServletContext().getRealPath("/");
			System.out.println("root=" + root);
			path = root + "upload/thumbnail/";
			dir = new File(path);
			if (!dir.isDirectory()) { // upload폴더 없다면
				dir.mkdirs(); // upload폴더 생성
			}
			List<MultipartFile> files=multi.getFiles("e_orifilename");//비동기 2개이상 파일전송
			for(MultipartFile file : files) {
				String multiRepName=file.getOriginalFilename();
				e_orifilename=multiRepName;
				System.out.println("multiRepName="+multiRepName);
				e_sysfilename = System.currentTimeMillis() + "."// 현재 시간
						+ e_orifilename.substring(e_orifilename.lastIndexOf(".") + 1);
				try {
					file.transferTo(new File(path + e_sysfilename));
				} catch (Exception e) {
				}
			}
			fileMap.put("e_orifilename", e_orifilename);
			fileMap.put("e_sysfilename", e_sysfilename);
			System.out.println("orifilename="+e_orifilename);
			System.out.println("sysfilename="+e_sysfilename);
		}
		return fileMap;
	}

	public ArrayList<String[]> multiFileUp(MultipartHttpServletRequest multi,int param) {
		ArrayList<String[]> fileList = new ArrayList<String[]>();
		String ei_orifilename=null;
		String ei_sysfilename=null;
		switch(param) {
		case 1:
			root = multi.getSession().getServletContext().getRealPath("/");
			System.out.println("root=" + root);
			path = root + "upload/eventImage/"; // 클린하면 폴더가 사라질수도 있어서 2번 실행
			dir = new File(path);
			if (!dir.isDirectory()) { // upload폴더 없다면
				dir.mkdirs(); // upload폴더 생성
			}
			List<MultipartFile> files2=multi.getFiles("ei_files");//비동기 2개이상 파일전송
			for(MultipartFile file2 : files2) {
				String multiRepName=file2.getOriginalFilename();
				ei_orifilename=multiRepName;
				System.out.println("multiRepName="+multiRepName);
				ei_sysfilename = System.currentTimeMillis() + "."// 현재 시간
						+ ei_orifilename.substring(ei_orifilename.lastIndexOf(".") + 1);
				try {
					file2.transferTo(new File(path + ei_sysfilename));
				} catch (Exception e) {
				}
				System.out.println("orifilename="+ei_orifilename);
				System.out.println("sysfilename="+ei_sysfilename);
				String[] names= {ei_orifilename,ei_sysfilename};
				fileList.add(names);
			}
		case 2:
			String q_orifilename = null;
			String q_sysfilename = null;
			root = multi.getSession().getServletContext().getRealPath("/");
			System.out.println("root=" + root);
			path = root + "upload/questionImage/"; // 클린하면 폴더가 사라질수도 있어서 2번 실행
			dir = new File(path);
			if (!dir.isDirectory()) { // upload폴더 없다면
				dir.mkdirs(); // upload폴더 생성
			}
			List<MultipartFile> q_files = multi.getFiles("q_files");// 비동기 2개이상 파일전송
			for (MultipartFile q_file : q_files) {
				String multiRepName = q_file.getOriginalFilename();
				q_orifilename = multiRepName;
				System.out.println("multiRepName=" + multiRepName);
				q_sysfilename = System.currentTimeMillis() + "."// 현재 시간
						+ q_orifilename.substring(q_orifilename.lastIndexOf(".") + 1);
				try {
					q_file.transferTo(new File(path + q_sysfilename));
				} catch (Exception e) {
				}
				System.out.println("orifilename=" + q_orifilename);
				System.out.println("sysfilename=" + q_sysfilename);
				String[] names = { q_orifilename, q_sysfilename };
				
				
				fileList.add(names);
			}
		}
		return fileList;
	}
}
