package com.spring.javawebS.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.spring.javawebS.dao.StudyDAO;
import com.spring.javawebS.vo.ChartVO;
import com.spring.javawebS.vo.KakaoAddressVO;
import com.spring.javawebS.vo.MemberVO;
import com.spring.javawebS.vo.QrCodeVO;
import com.spring.javawebS.vo.TransactionVO;
import com.spring.javawebS.vo.UserVO;

import net.coobird.thumbnailator.Thumbnailator;

@Service
public class StudyServiceImpl implements StudyService {

	@Autowired
	StudyDAO studyDAO;

	@Override
	public String[] getCityStringArray(String dodo) {
		String[] strArray = new String[100];
		
		if(dodo.equals("서울")) {
			strArray[0] = "강남구";
			strArray[1] = "서초구";
			strArray[2] = "마포구";
			strArray[3] = "영등포구";
			strArray[4] = "관악구";
			strArray[5] = "중구";
			strArray[6] = "동대문구";
			strArray[7] = "성북구";
		}
		else if(dodo.equals("경기")) {
			strArray[0] = "수원시";
			strArray[1] = "안양시";
			strArray[2] = "안성시";
			strArray[3] = "고양시";
			strArray[4] = "일산시";
			strArray[5] = "용인시";
			strArray[6] = "의정부시";
			strArray[7] = "광명시";
		}
		else if(dodo.equals("충북")) {
			strArray[0] = "청주시";
			strArray[1] = "충주시";
			strArray[2] = "옥천군";
			strArray[3] = "제천시";
			strArray[4] = "단양군";
			strArray[5] = "음성군";
			strArray[6] = "괴산군";
			strArray[7] = "증평군";
		}
		else if(dodo.equals("충남")) {
			strArray[0] = "천안시";
			strArray[1] = "아산시";
			strArray[2] = "홍성군";
			strArray[3] = "예산군";
			strArray[4] = "공주시";
			strArray[5] = "청양군";
			strArray[6] = "부여군";
			strArray[7] = "논산시";
		}
		else if(dodo.equals("경북")) {
			strArray[0] = "봉화군";
			strArray[1] = "구미시";
			strArray[2] = "영주시";
			strArray[3] = "칠곡군";
			strArray[4] = "안동시";
			strArray[5] = "의성군";
			strArray[6] = "청송군";
			strArray[7] = "포항시";
		}
		
		return strArray;
	}

	@Override
	public ArrayList<String> getCityArrayList(String dodo) {
		ArrayList<String> vos = new ArrayList<String>();
		
		if(dodo.equals("서울")) {
			vos.add("강남구");
			vos.add("서초구");
			vos.add("마포구");
			vos.add("영등포구");
			vos.add("관악구");
			vos.add("중구");
			vos.add("동대문구");
			vos.add("성북구");
		}
		else if(dodo.equals("경기")) {
			vos.add("수원시");
			vos.add("안양시");
			vos.add("안성시");
			vos.add("고양시");
			vos.add("일산시");
			vos.add("용인시");
			vos.add("의정부시");
			vos.add("광명시");
		}
		else if (dodo.equals("충북")) {
	    vos.add("청주시");
	    vos.add("충주시");
	    vos.add("옥천군");
	    vos.add("제천시");
	    vos.add("단양군");
	    vos.add("음성군");
	    vos.add("괴산군");
	    vos.add("증평군");
		} 
		else if (dodo.equals("충남")) {
	    vos.add("천안시");
	    vos.add("아산시");
	    vos.add("홍성군");
	    vos.add("예산군");
	    vos.add("공주시");
	    vos.add("청양군");
	    vos.add("부여군");
	    vos.add("논산시");
		} 
		else if (dodo.equals("경북")) {
	    vos.add("봉화군");
	    vos.add("구미시");
	    vos.add("영주시");
	    vos.add("칠곡군");
	    vos.add("안동시");
	    vos.add("의성군");
	    vos.add("청송군");
	    vos.add("포항시");
		}
		return vos;
	}

	@Override
	public MemberVO getMemberMidSearch(String name) {
		return studyDAO.getMemberMidSearch(name);
	}

	@Override
	public ArrayList<MemberVO> getMemberMidSearch2(String name) {
		return studyDAO.getMemberMidSearch2(name);
	}

	@Override
	public int fileUpload(MultipartFile fName, String mid) {
		int res = 0;
		
		UUID uid = UUID.randomUUID();
		String oFileName = fName.getOriginalFilename();
		String saveFileName = mid + "_" + uid + "_" + oFileName;
		// System.out.println("oFileName : " + oFileName);
		
		// 메모리에 올라와 있는 파일의 정보를 실제 서버 파일시스템에 저장처리한다.
		try {
			writeFile(fName, saveFileName);
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return res;
	}

	public void writeFile(MultipartFile fName, String saveFileName) throws IOException {
		byte[] data = fName.getBytes();
		//String realPath = request.getRealPath("/resources/data/study/");
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/study/");
		
		FileOutputStream fos = new FileOutputStream(realPath + saveFileName);
		fos.write(data);
		fos.close();
	}

	@Override
	public int setUserInput(UserVO vo) {
		return studyDAO.setUserInput(vo);
	}

	@Override
	public ArrayList<UserVO> getUserList() {
		return studyDAO.getUserList();
	}

	@Override
	public void setUserDelete(int idx) {
		studyDAO.setUserDelete(idx);
	}

	@Override
	public KakaoAddressVO getKakaoAddressName(String address) {
		return studyDAO.getKakaoAddressName(address);
	}

	@Override
	public void setKakaoAddressInput(KakaoAddressVO vo) {
		studyDAO.setKakaoAddressInput(vo);
	}

	@Override
	public List<KakaoAddressVO> getKakaoAddressList() {
		return studyDAO.getKakaoAddressList();
	}

	@Override
	public void setKakaoAddressDelete(String address) {
		studyDAO.setKakaoAddressDelete(address);
	}

	@Override
	public String qrCreate(QrCodeVO vo, String realPath) {
		// 날짜_아이디_성명_메일주소_랜덤번호2
		String qrCodeName = "", qrCodeName2 = "";
		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");
			UUID uid = UUID.randomUUID();
			String strUid = uid.toString().substring(0,2);
			qrCodeName = sdf.format(new Date()) + "_" + vo.getMid() + "_" + vo.getName() + "_" + vo.getEmail() + "_" + strUid;
			qrCodeName2 = sdf.format(new Date()) + "\n" + vo.getMid() + "\n" + vo.getName() + "\n" + vo.getEmail() + "\n" + strUid;
			qrCodeName2 = new String(qrCodeName2.getBytes("UTF-8"), "ISO-8859-1");
		
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs();
			
			//String name = new String(vo.getName().getBytes("UTF-8"), "ISO-8859-1");
			
			
			// qr코드 만들기
			int qrCodeColor = 0xFF000000; 		// qr코드 전경색(글자색) - 검정
			int qrCodeBackColor = 0xFFFFFFFF; // qr코드 배경색(바탕색) - 흰색
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter();	// QR 코드 객체 생성
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeName2, BarcodeFormat.QR_CODE, 200, 200);
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			// ImageIO객체를 이용하면 byte배열단위로 변환없이 바로 파일을 write 시킬 수 있다.
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		
		return qrCodeName;
	}

	@Override
	public String qrCreate2(QrCodeVO vo, String realPath) {
		// qr코드명은 사이트 주로소 만들어준다.
		String qrCodeName = "";
		
		try {
			qrCodeName = new String(vo.getMoveUrl().getBytes("UTF-8"), "ISO-8859-1");
		
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs();
			
			// qr코드 만들기
			int qrCodeColor = 0xFF000000; 		// qr코드 전경색(글자색) - 검정
			int qrCodeBackColor = 0xFFFFFFFF; // qr코드 배경색(바탕색) - 흰색
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter();	// QR 코드 객체 생성
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeName, BarcodeFormat.QR_CODE, 200, 200);
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			// ImageIO객체를 이용하면 byte배열단위로 변환없이 바로 파일을 write 시킬 수 있다.
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		
		return qrCodeName;	
	}

	@Override
	public String qrCreate3(QrCodeVO vo, String realPath) {
		// qr코드명은 사이트 주로소 만들어준다.
		String qrCodeName = "";
		
		try {
			qrCodeName = new String(vo.getMovieTemp().getBytes("UTF-8"), "ISO-8859-1");
		
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs();
			
			// qr코드 만들기
			int qrCodeColor = 0xFF000000; 		// qr코드 전경색(글자색) - 검정
			int qrCodeBackColor = 0xFFFFFFFF; // qr코드 배경색(바탕색) - 흰색
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter();	// QR 코드 객체 생성
			BitMatrix bitMatrix = qrCodeWriter.encode(qrCodeName, BarcodeFormat.QR_CODE, 200, 200);
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			// ImageIO객체를 이용하면 byte배열단위로 변환없이 바로 파일을 write 시킬 수 있다.
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		
		return qrCodeName;
	}

	@Override
	public String qrCreate4(QrCodeVO vo, String realPath) {
		// qr코드명은 "" 만들어준다.
		String qrCodeName = "";
		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			UUID uid = UUID.randomUUID();
			String strUid = uid.toString().substring(0,4);
			qrCodeName = sdf.format(new Date()) + "_" + strUid;
			
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs();
			
			String qrTemp = new String(vo.getMovieTemp().getBytes("UTF-8"), "ISO-8859-1");
			
			// qr코드 만들기
			int qrCodeColor = 0xFF000000; 		// qr코드 전경색(글자색) - 검정
			int qrCodeBackColor = 0xFFFFFFFF; // qr코드 배경색(바탕색) - 흰색
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter();	// QR 코드 객체 생성
			BitMatrix bitMatrix = qrCodeWriter.encode(qrTemp, BarcodeFormat.QR_CODE, 200, 200);
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			BufferedImage bufferedImage = MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			// ImageIO객체를 이용하면 byte배열단위로 변환없이 바로 파일을 write 시킬 수 있다.
			ImageIO.write(bufferedImage, "png", new File(realPath + qrCodeName + ".png"));
			
			// 생성된 QR코드의 정보를 DB에 저장한다.
			vo.setQrCodeName(qrCodeName+".png");
			studyDAO.setQrCreateDB(vo);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (WriterException e) {
			e.printStackTrace();
		}
		
		return qrCodeName;
	}

	@Override
	public QrCodeVO getQrCodeSearch(String qrCode) {
		return studyDAO.getQrCodeSearch(qrCode);
	}

	@Override
	public int thumbnailCreate(MultipartFile file) {
		int res = 0;
		try {
			UUID uid = UUID.randomUUID();
			String strUid = uid.toString();
			String oFileName = file.getOriginalFilename();
			
			String saveFileName = strUid.substring(strUid.lastIndexOf("-")+1) + "_" + oFileName;
			
			// 먼저 MultipartFile객체로 원본이미지를 저장하고, Thumbnailator객체로 썸네일 생성저장하기
			HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
			String realPath = request.getSession().getServletContext().getRealPath("/resources/data/thumbnail/");
			File realFileName = new File(realPath + saveFileName);
			file.transferTo(realFileName);	// 원본 이미지 저장하기
			
			// 썸네일 이미지 생성하기(썸네일파일명은 "s_"로 시작하도록처리);
			String thumbnailSaveName = realPath + "s_" + saveFileName;
			File thumbnailFile = new File(thumbnailSaveName);
			
			int width = 120;
			int height = 160;
			// 썸네일 라이브러리(Thumbnailator)를 이용한 썸네일 이미지 생성저장하기: createThumbnail(원본이미지,썸네일이미지,폭,높이)
			Thumbnailator.createThumbnail(realFileName, thumbnailFile, width, height);
			
			res = 1;
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public void setTransactionUserInput1(TransactionVO vo) {
		studyDAO.setTransactionUserInput1(vo);
	}

	@Override
	public void setTransactionUserInput2(TransactionVO vo) {
		studyDAO.setTransactionUserInput2(vo);
	}

	@Transactional
	@Override
	public void setTransactionUserInput(TransactionVO vo) {
		studyDAO.setTransactionUserInput(vo);
	}

	@Override
	public List<TransactionVO> setTransactionUserList(String userSelect) {
		return studyDAO.setTransactionUserList(userSelect);
	}

	@Override
	public List<ChartVO> getRecentlyVisitCount(int i) {
		return studyDAO.getRecentlyVisitCount(i);
	}

	@Override
	public void getCalendar() {
	  // model객체를 사용하게되면 불필요한 메소드가 많이 따라오기에 여기서는 request객체를 사용했다.
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		
		// 오늘 날짜 저장시켜둔다.(calToday변수, 년(toYear), 월(toMonth), 일(toDay))
		Calendar calToday = Calendar.getInstance();
		int toYear = calToday.get(Calendar.YEAR);
		int toMonth = calToday.get(Calendar.MONTH);
		int toDay = calToday.get(Calendar.DATE);
				
		// 화면에 보여줄 해당 '년(yy)/월(mm)'을 셋팅하는 부분(처음에는 오늘 년도와 월을 가져오지만, '이전/다음'버튼 클릭하면 해당 년과 월을 가져오도록 한다.
		Calendar calView = Calendar.getInstance();
		int yy = request.getParameter("yy")==null ? calView.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
	  int mm = request.getParameter("mm")==null ? calView.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
	  
	  if(mm < 0) { // 1월에서 전월 버튼을 클릭시에 실행
	  	yy--;
	  	mm = 11;
	  }
	  if(mm > 11) { // 12월에서 다음월 버튼을 클릭시에 실행
	  	yy++;
	  	mm = 0;
	  }
	  calView.set(yy, mm, 1);		// 현재 '년/월'의 1일을 달력의 날짜로 셋팅한다.
	  
	  int startWeek = calView.get(Calendar.DAY_OF_WEEK);  						// 해당 '년/월'의 1일에 해당하는 요일값을 숫자로 가져온다.
	  int lastDay = calView.getActualMaximum(Calendar.DAY_OF_MONTH);  // 해당월의 마지막일자(getActualMaxximum메소드사용)를 구한다.
	  
	  // 화면에 보여줄 년월기준 전년도/다음년도를 구하기 위한 부분
	  int prevYear = yy;  			// 전년도
	  int prevMonth = (mm) - 1; // 이전월
	  int nextYear = yy;  			// 다음년도
	  int nextMonth = (mm) + 1; // 다음월
	  
	  if(prevMonth == -1) {  // 1월에서 전월 버튼을 클릭시에 실행..
	  	prevYear--;
	  	prevMonth = 11;
	  }
	  
	  if(nextMonth == 12) {  // 12월에서 다음월 버튼을 클릭시에 실행..
	  	nextYear++;
	  	nextMonth = 0;
	  }
	  
	  // 현재달력에서 앞쪽의 빈공간은 '이전달력'을 보여주고, 뒷쪽의 남은공간은 '다음달력'을 보여주기위한 처리부분(아래 6줄)
	  Calendar calPre = Calendar.getInstance(); // 이전달력
	  calPre.set(prevYear, prevMonth, 1);  			// 이전 달력 셋팅
	  int preLastDay = calPre.getActualMaximum(Calendar.DAY_OF_MONTH);  // 해당월의 마지막일자를 구한다.
	  
	  Calendar calNext = Calendar.getInstance();// 다음달력
	  calNext.set(nextYear, nextMonth, 1);  		// 다음 달력 셋팅
	  int nextStartWeek = calNext.get(Calendar.DAY_OF_WEEK);  // 다음달의 1일에 해당하는 요일값을 가져온다.
	  
	  /* ---------  아래는  앞에서 처리된 값들을 모두 request객체에 담는다.  -----------------  */
	  
	  // 오늘기준 달력...
	  request.setAttribute("toYear", toYear);
	  request.setAttribute("toMonth", toMonth);
	  request.setAttribute("toDay", toDay);
	  
	  // 화면에 보여줄 해당 달력...
	  request.setAttribute("yy", yy);
	  request.setAttribute("mm", mm);
	  request.setAttribute("startWeek", startWeek);
	  request.setAttribute("lastDay", lastDay);
	  
	  // 화면에 보여줄 해당 달력 기준의 전년도, 전월, 다음년도, 다음월 ...
	  request.setAttribute("prevYear", prevYear);
		request.setAttribute("prevMonth", prevMonth);
		request.setAttribute("nextYear", nextYear);
		request.setAttribute("nextMonth", nextMonth);
		
		// 현재 달력의 '앞/뒤' 빈공간을 채울, 이전달의 뒷부분과 다음달의 앞부분을 보여주기위해 넘겨주는 변수
		request.setAttribute("preLastDay", preLastDay);				// 이전달의 마지막일자를 기억하고 있는 변수
		request.setAttribute("nextStartWeek", nextStartWeek);	// 다음달의 1일에 해당하는 요일을 기억하고있는 변수
	}
	
}
