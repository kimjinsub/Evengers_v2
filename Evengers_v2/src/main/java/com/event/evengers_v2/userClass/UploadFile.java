package com.event.evengers_v2.userClass;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

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
		String reqi_orifilename = null;
		String reqi_sysfilename = null;
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
			
		case 2:	//의뢰 첨부사진
			root = multi.getSession().getServletContext().getRealPath("/");
			System.out.println("root=" + root);
			path = root + "upload/evtReqImage/";
			System.out.println("path = " + path);
			
			dir = new File(path);
			if (!dir.isDirectory()) { // upload폴더 없다면
				dir.mkdirs(); // upload폴더 생성
			}
			
			List<MultipartFile> files1 = multi.getFiles("reqi_orifilename");
			for (MultipartFile file : files1) {
				reqi_orifilename=file.getOriginalFilename();
				System.out.println("reqi_orifilename: " + reqi_orifilename);
				
				reqi_sysfilename = System.currentTimeMillis() + "."
						+ reqi_orifilename.substring(reqi_orifilename.lastIndexOf(".") + 1);
				System.out.println("reqi_sysfilename:"+reqi_sysfilename);
				try {
					file.transferTo(new File(path + reqi_sysfilename));
				} catch (Exception e) {
				}
			}
			fileMap.put("reqi_orifilename", reqi_orifilename);
			fileMap.put("reqi_sysfilename", reqi_sysfilename);
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
		case 3:
			String esti_orifilename = null;
			String esti_sysfilename = null;
			root = multi.getSession().getServletContext().getRealPath("/");
			System.out.println("root=" + root);
			path = root + "upload/estimateImage/"; // 클린하면 폴더가 사라질수도 있어서 2번 실행
			dir = new File(path);
			if (!dir.isDirectory()) { // upload폴더 없다면
				dir.mkdirs(); // upload폴더 생성
			}
			List<MultipartFile> est_files = multi.getFiles("est_files");// 비동기 2개이상 파일전송
			for (MultipartFile est_file : est_files) {
				String multiRepName = est_file.getOriginalFilename();
				esti_orifilename = multiRepName;
				System.out.println("multiRepName=" + multiRepName);
				esti_sysfilename = System.currentTimeMillis() + "."// 현재 시간
						+ esti_orifilename.substring(esti_orifilename.lastIndexOf(".") + 1);
				try {
					est_file.transferTo(new File(path + esti_sysfilename));
				} catch (Exception e) {
				}
				System.out.println("orifilename=" + esti_orifilename);
				System.out.println("sysfilename=" + esti_sysfilename);
				String[] names = { esti_orifilename, esti_sysfilename };
				
				
				fileList.add(names);
			}
		}
		return fileList;
	}
	public void download(String fullPath, String oriFileName, HttpServletResponse resp) throws Exception {

	      // 한글파일 깨짐 방지
	      String downFile = URLEncoder.encode(oriFileName, "UTF-8");
	      // 파일 객체 생성
	      File file = new File(fullPath);
	      // 다운로드 경로 파일을 읽어 들임
	      InputStream is = new FileInputStream(file);
	      // 반환객체설정
	      resp.setContentType("application/octet-stream");
	      resp.setHeader("content-Disposition", "attachment; filename=\"" + downFile + "\"");
	      // 반환객체에 스트림 연결
	      OutputStream os = resp.getOutputStream();

	      // 파일쓰기
	      byte[] buffer = new byte[1024];
	      int length;
	      while ((length = is.read(buffer)) != -1) {
	         os.write(buffer, 0, length);
	      }
	      os.flush();
	      os.close();
	      is.close();
	   }
	public Map<String, String> FileUp(MultipartHttpServletRequest multi, int param) {
	      Map<String,String> fileMap = new HashMap<String, String>();
	      String emp_orifilename = null;
	      String emp_sysfilename = null;
	      switch (param) {
	      case 1:
	         root = multi.getSession().getServletContext().getRealPath("/");
	         System.out.println("root=" + root);
	         path = root + "upload/performimage/";
	         dir = new File(path);
	         if (!dir.isDirectory()) { // upload폴더 없다면
	            dir.mkdirs(); // upload폴더 생성
	         }
	         System.out.println("File="+multi.getFiles("emp_orifilename"));
	         List<MultipartFile> files=multi.getFiles("emp_orifilename");//비동기 2개이상 파일전송
	         for(MultipartFile file : files) {
	            String multiRepName=file.getOriginalFilename();
	            emp_orifilename=multiRepName;
	            System.out.println("multiRepName="+multiRepName);
	            emp_sysfilename = System.currentTimeMillis() + "."// 현재 시간
	                  + emp_orifilename.substring(emp_orifilename.lastIndexOf(".") + 1);
	            try {
	               file.transferTo(new File(path + emp_sysfilename));
	            } catch (Exception e) {
	            }
	         }
	         fileMap.put("emp_orifilename", emp_orifilename);
	         fileMap.put("emp_sysfilename", emp_sysfilename);
	         System.out.println("orifilename="+emp_orifilename);
	         System.out.println("sysfilename="+emp_sysfilename);
	      }
	      return fileMap;
	   }
}

