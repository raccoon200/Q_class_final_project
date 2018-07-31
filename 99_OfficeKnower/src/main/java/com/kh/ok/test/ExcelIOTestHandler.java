package com.kh.ok.test;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ExcelIOTestHandler {
	
	@RequestMapping("/test/excelTest.do")
	public String excelTest() {
		return "test/excelio";
	}
	
	@RequestMapping("/test/excelIOTest.do")
	public ModelAndView excelIOTest(@RequestParam(value = "file", required = false) MultipartFile excel, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		// 1. 파일업로드처리
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/excel");
		// 파일명 재생성
		String originalFileName = excel.getOriginalFilename();
		String ext = originalFileName.substring(originalFileName.lastIndexOf(".") + 1); // 확장자
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
		int rndNum = (int) (Math.random() * 1000);
		String renamedFileName = sdf.format(new Date(System.currentTimeMillis())) + "_" + rndNum + "."
				+ ext;
		File file = new File(saveDirectory + "/" + renamedFileName);
		List<Test> list = new ArrayList<Test>();
		try {
			excel.transferTo(file); // 실제 서버에 파일을 저장하는 코드
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		if(ext.equals("xlsx")) {
			XSSFWorkbook wb = null;
			FileOutputStream fileOut = null;
			try {
				//엑셀파일 오픈
				wb = new XSSFWorkbook(new FileInputStream(file));
				
				Cell cell = null;
				
				//첫번째 sheet 내용 읽기
				for(Row row : wb.getSheetAt(0)) {
					//셋째줄부터..
					if(row.getRowNum() < 2) {
						continue;
					}
					
					//두번째 셀이 비어잇으면 for문을 멈춘다.
					if(row.getCell(1) == null) {
						break;
					}
					//Test t = new Test(row.getCell(1).getStringCellValue(), (int)row.getCell(2).getNumericCellValue(), row.getCell(3).getStringCellValue(), row.getCell(4).getStringCellValue());
					Test t = new Test();
					t.setName(row.getCell(1) == null?"":row.getCell(1).getStringCellValue());
					t.setAge(row.getCell(2) == null?0:(int)(row.getCell(2).getNumericCellValue()));
					t.setGender(row.getCell(3) == null?"":row.getCell(3).getStringCellValue());
					t.setEtc(row.getCell(4) == null?"":row.getCell(4).getStringCellValue());
					list.add(t);
					// 콘솔출력
					System.out.println("[row] 이름 : " + row.getCell(1) + ", 나이: " + row.getCell(2)
	                				 + ", 성별: " + row.getCell(3) + ", 비고: " + row.getCell(4));
					//4번째 셀값을 변경
					cell = row.createCell(4);
					cell.setCellValue("확인");
				}
				//엑셀파일저장
				fileOut = new FileOutputStream(file);
				wb.write(fileOut);
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				try {
					if(wb != null) {					
						wb.close();
					}
					if(fileOut != null) {
						fileOut.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}else if(ext.equals("xls")) {
			HSSFWorkbook wb = null;
			FileOutputStream fileOut = null;
			try {
				//엑셀파일 오픈
				wb = new HSSFWorkbook(new FileInputStream(file));
				
				Cell cell = null;
				
				//첫번째 sheet 내용 읽기
				for(Row row : wb.getSheetAt(0)) {
					//셋째줄부터..
					if(row.getRowNum() < 2) {
						continue;
					}
					
					//두번째 셀이 비어잇으면 for문을 멈춘다.
					if(row.getCell(1) == null) {
						break;
					}
					//Test t = new Test(row.getCell(1).getStringCellValue(), (int)(row.getCell(2).getNumericCellValue()), row.getCell(3).getStringCellValue(), row.getCell(4).getStringCellValue());
					Test t = new Test();
					t.setName(row.getCell(1) == null?"":row.getCell(1).getStringCellValue());
					t.setAge(row.getCell(2) == null?0:(int)(row.getCell(2).getNumericCellValue()));
					t.setGender(row.getCell(3) == null?"":row.getCell(3).getStringCellValue());
					t.setEtc(row.getCell(4) == null?"":row.getCell(4).getStringCellValue());
					list.add(t);
					// 콘솔출력
					System.out.println("[row] 이름 : " + row.getCell(1) + ", 나이: " + row.getCell(2)
	                				 + ", 성별: " + row.getCell(3) + ", 비고: " + row.getCell(4));
					//4번째 셀값을 변경
					cell = row.createCell(4);
					cell.setCellValue("확인");
				}
				//엑셀파일저장
				fileOut = new FileOutputStream(file);
				wb.write(fileOut);
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				try {
					if(wb != null) {					
						wb.close();
					}
					if(fileOut != null) {
						fileOut.close();
					}
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		file.delete();
		mav.addObject("list", list);
		mav.setViewName("test/excelioend");
		return mav;
	}
	@RequestMapping("/test/textToExcel.do")
	public void textToExcel(String[] name, int[] age, String[] gender, String[] etc, HttpServletRequest request, HttpServletResponse response) {
		// 1. 파일업로드처리
		String saveDirectory = request.getSession().getServletContext().getRealPath("/resources/upload/excel");
		// 파일명 재생성
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
		int rndNum = (int) (Math.random() * 1000);
		String renamedFileName = sdf.format(new Date(System.currentTimeMillis())) + "_" + rndNum + "."
				+ "xlsx";
		
		XSSFWorkbook wb = null;
		FileOutputStream fileOut = null;
		ServletOutputStream sos = null;
		BufferedInputStream bis = null;
		try {
			wb = new XSSFWorkbook();
			Cell cell = null;
			Sheet sheet = wb.createSheet();
			
			
			for(int i = 2; i < name.length+3; i++) {
				Row row = sheet.createRow(i);
				if(row.getRowNum() == 2) {
                	cell = row.createCell(1);
                	cell.setCellValue("이름");
                	cell = row.createCell(2);
                	cell.setCellValue("나이");
                	cell = row.createCell(3);
                	cell.setCellValue("성별");
                	cell = row.createCell(4);
                	cell.setCellValue("비고");
                }else {
                	cell = row.createCell(1);
                	cell.setCellValue(name[row.getRowNum()-3]);
                	cell = row.createCell(2);
                	cell.setCellValue(age[row.getRowNum()-3]);
                	cell = row.createCell(3);
                	cell.setCellValue(gender[row.getRowNum()-3]);
                	cell = row.createCell(4);
                	cell.setCellValue(etc[row.getRowNum()-3]);
                }
			}
			
			//엑셀파일저장
			fileOut = new FileOutputStream(saveDirectory + "/" + renamedFileName);
			wb.write(fileOut);
			fileOut.close();
			wb.close();
			//다운로드
			File file = new File(saveDirectory + "/" + renamedFileName);
			bis = new BufferedInputStream(new FileInputStream(file));
			sos = response.getOutputStream();
			response.setContentType("application/octet-stream; charset=utf-8");
			
			String resFilename = "";
			boolean isMSIE = request.getHeader("user-agent").indexOf("MSIE") != -1
					|| request.getHeader("user-agent").indexOf("Trident") != -1;
			// IE 8이하는 MSIE라는 키워드를, 이후는 Trident라는 키워드를 갖고 있기에 둘다 체크해봐야함.

			if (isMSIE) {
				// ie는 utf-8인코딩을 명시적으로 해줌.
				resFilename = URLEncoder.encode(renamedFileName, "utf-8"); // 이렇게 하면 공백이 +로 바뀌는 문제가 있음.
				resFilename = resFilename.replaceAll("\\+", "%20"); // +를 공백으로 바꾸는 코드.
			} else {
				resFilename = new String(renamedFileName.getBytes("utf-8"), "ISO-8859-1"); // 기존 파일명을 바이트로 바꾼 후 ISO-8859-1형식으로 재
																					// 인코딩...
			}

			response.addHeader("Content-Disposition", "attachment; filename=\"" + resFilename + "\"");
			
			int read = 0;
			while ((read = bis.read()) != -1) {
				sos.write(read);
			}
			bis.close();
			file.delete();
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				if(wb != null) {					
					wb.close();
				}
				if(fileOut != null) {
					fileOut.close();
				}
				if(sos != null) {					
					sos.close();
				}
				if(bis != null) {					
					bis.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}
