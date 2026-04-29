package com.rabbiter.hospital.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.rabbiter.hospital.pojo.Patient;
import com.rabbiter.hospital.pojo.PatientCheck;
import com.rabbiter.hospital.pojo.PatientDrug;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PatientMapper extends BaseMapper<Patient> {
    /**
     * 统计患者男女人数
     */
    Integer patientAge(@Param("startAge") int startAge, @Param("endAge") int endAge);

    List<PatientDrug> patientDrug();
    List<PatientCheck> patientCheck();
}
