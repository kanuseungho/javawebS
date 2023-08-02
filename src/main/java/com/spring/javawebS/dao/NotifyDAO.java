package com.spring.javawebS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javawebS.vo.NotifyVO;

public interface NotifyDAO {

	public void notifyInput(@Param("vo") NotifyVO vo);

	public List<NotifyVO> getNotifyList();

	public void setNotifyDelete(@Param("idx") int idx);

	public NotifyVO getNotifyUpdate(@Param("idx") int idx);

	public void setNotifyUpdateOk(@Param("vo") NotifyVO vo);

	public void setPopupCheckUpdate(@Param("idx") int idx, @Param("popupSw") String popupSw);

	public List<NotifyVO> getNotifyPopup();

	public NotifyVO getNotifyView(@Param("idx") int idx);

}
