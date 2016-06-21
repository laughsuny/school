package com.rocksuny.dao;

import com.rocksuny.model.Sysbutton;

public interface ISysbuttonDao {
    int deleteByPrimaryKey(Integer id);

    int insert(Sysbutton record);

    int insertSelective(Sysbutton record);

    Sysbutton selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Sysbutton record);

    int updateByPrimaryKey(Sysbutton record);
}