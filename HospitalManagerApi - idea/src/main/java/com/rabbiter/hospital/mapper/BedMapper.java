package com.rabbiter.hospital.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.rabbiter.hospital.pojo.Bed;
import org.apache.ibatis.annotations.Select;

public interface BedMapper extends BaseMapper<Bed> {
    /**
     * 统计今天住院人数
     */
    int bedPeople(String bStart);

   // @Select("select bState where pid=#{pid}")
    int getStatusByPid(int pid);
}
