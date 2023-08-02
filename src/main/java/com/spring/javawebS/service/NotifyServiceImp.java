package com.spring.javawebS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javawebS.dao.NotifyDAO;
import com.spring.javawebS.vo.NotifyVO;

@Service
public class NotifyServiceImp implements NotifyService {
	@Autowired
	NotifyDAO notifyDAO;

	@Override
	public void notifyInput(NotifyVO vo) {
		notifyDAO.notifyInput(vo);
	}

	@Override
	public List<NotifyVO> getNotifyList() {
		return notifyDAO.getNotifyList();
	}

	@Override
	public void setNotifyDelete(int idx) {
		notifyDAO.setNotifyDelete(idx);
	}

	@Override
	public NotifyVO getNotifyUpdate(int idx) {
		return notifyDAO.getNotifyUpdate(idx);
	}

	@Override
	public void setNotifyUpdateOk(NotifyVO vo) {
		notifyDAO.setNotifyUpdateOk(vo);
	}

	@Override
	public int setPopupCheckUpdate(int idx, String popupSw) {
		notifyDAO.setPopupCheckUpdate(idx, popupSw);
		return 1;
	}

	@Override
	public List<NotifyVO> getNotifyPopup() {
		return notifyDAO.getNotifyPopup();
	}

	@Override
	public NotifyVO getNotifyView(int idx) {
		return notifyDAO.getNotifyView(idx);
	}
	
}
