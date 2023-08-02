package com.spring.javawebS.service;

import java.util.List;

import com.spring.javawebS.vo.NotifyVO;

public interface NotifyService {

	public void notifyInput(NotifyVO vo);

	public List<NotifyVO> getNotifyList();

	public void setNotifyDelete(int idx);

	public NotifyVO getNotifyUpdate(int idx);

	public void setNotifyUpdateOk(NotifyVO vo);

	public int setPopupCheckUpdate(int idx, String popupSw);

	public List<NotifyVO> getNotifyPopup();

	public NotifyVO getNotifyView(int idx);

}
