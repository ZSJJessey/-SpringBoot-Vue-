<template>
    <div class="patient-card-container">
      <el-card shadow="hover">
        <!-- 患者照片 -->
        <div class="patient-photo">
            患者信息表格
        </div>
        <!-- 患者信息表格 -->
        <div class="patient-info-table">
          <table>
            <tr>
              <td>姓名：</td>
              <td>{{ patientData.pName }}</td>
            </tr>
            <tr>
              <td>账号：</td>
              <td>{{ patientData.pId }}</td>
            </tr>
            <tr>
              <td>性别：</td>
              <td>{{ patientData.pGender }}</td>
            </tr>
            <tr>
              <td>手机号：</td>
              <td>{{ patientData.pPhone }}</td>
            </tr>
            <tr>
              <td>身份证号：</td>
              <td>{{ patientData.pCard }}</td>
            </tr>
            
            <tr>
              <td>出生日期：</td>
              <td>{{ patientData.pBirthday }}</td>
            </tr>
            <tr>
              <td>年龄：</td>
              <td>{{ patientData.pAge }}</td>
            </tr>
          </table>
        </div>
      </el-card>
    </div>
  </template>
  
  <script>
  import jwtDecode from "jwt-decode";
  import { getToken } from "@/utils/storage.js";
  import request from "@/utils/request.js";
  
  export default {
    name: "PatientCard",
    data() {
      return {
        userId: "",
        patientData: {}
      };
    },
    methods: {
      // 请求患者信息
      requestPatient() {
        request.get("doctor/findPatientById", {
          params: {
            pId: this.userId
          }
        })
        .then(res => {
          if (res.data.status != 200) {
            return this.$message.error("获取数据失败");
          }
          this.patientData = res.data.data;
        });
      },
      // token 解码
      tokenDecode(token) {
        if (token !== null) {
          return jwtDecode(token);
        }
      }
    },
    created() {
      // 解码 token 信息
      this.userId = this.tokenDecode(getToken()).pId;
      this.requestPatient();
      console.log(this.userId);
    }
  };
  </script>
  
  <style lang="scss" scoped>
  .patient-card-container {
    width: 100%;
    margin-top: -10px;
    padding: 20px;
  }
  
  .patient-photo {
    text-align: center;
    padding: 20px 0;
  
    img {
      width: 150px;
      height: 150px;
      border-radius: 50%;
      object-fit: cover;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
  }
  
  .patient-info-table {
    padding: 20px;
  
    table {
      width: 100%;
      border-collapse: collapse;
  
      td {
        padding: 10px;
        border-bottom: 1px solid #eee;
      }
  
      td:first-child {
        width: 120px;
        font-weight: bold;
      }
    }
  }
  </style>