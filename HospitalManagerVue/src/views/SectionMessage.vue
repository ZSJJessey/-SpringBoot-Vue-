<template>
    <div>
        <!-- 卡片 -->
        <el-card>
            <!-- 面包屑 -->
            <el-breadcrumb separator-class="el-icon-arrow-right">
                <el-breadcrumb-item :to="{ path: '/orderOperate' }">科室选择</el-breadcrumb-item>
                <el-breadcrumb-item>日期选择</el-breadcrumb-item>
                <el-breadcrumb-item>挂号</el-breadcrumb-item>
            </el-breadcrumb>

            <!-- 两边布局 -->
            <div class="head">
                <div>
                    <i class="iconfont icon-r-user1" style="margin: 5px; font-size: 26px">
                        {{ sectionOpt }}医生列表</i>
                </div>

                <!-- 选择挂号时间 -->
                <div>
                    <i class="iconfont icon-r-paper" style="font-size: 24px">
                        请选择你要挂号的日期：</i>
                    <ul class="dateUl">
                        <li v-for="monthDay in monthDays" :key="monthDay">
                            <el-button icon="iconfont icon-r-paper" style="font-size: 24px"
                                @click="dateClick(monthDay)">
                                {{ monthDay }}</el-button>
                        </li>
                    </ul>
                </div>
            </div>

            <div>
                <el-row :gutter="20">
                    <!-- 循环渲染 el-col 组件 -->
                    <el-col :span="6" v-for="(item, index) in sectionData" :key="index">
                        <div class="doctor-card">
                            <!-- 医生图片 -->
                            <img :src="getFullImageUrl(item.d_avatarUrl)" alt="Doctor Image" class="doctor-image"
                                @click="getDoctorInfo(item)">
                            <!-- 医生姓名 -->
                            <p class="doctor-name">{{ item.dPost }} {{ item.dName }}</p>
                        </div>
                    </el-col>
                </el-row>
            </div>

            <el-dialog :visible.sync="dialogVisible" title="医生详细信息" width="60%">
                <div style="display: flex;">


                    <div style="width: 30%">
                        <img :src="getFullImageUrl(doctorInfo.d_avatarUrl)" alt="Doctor Image" width="250px"
                            style=" border-radius: 5px;">
                    </div>
                    <div style=" width: 70%;font-size: 20px; font-weight: bold;"> {{ doctorInfo.dIntroduction }}</div>
                </div>
                <div class="bottom-div">
                    <el-table :data="[doctorInfo]" style="width: 100%"
                        :header-cell-style="{ background: '#f0f9eb', color: '#67c23a' }">
                        <el-table-column prop="dName" label="姓名"></el-table-column>
                        <el-table-column prop="dSection" label="科室"></el-table-column>
                        <el-table-column prop="dPost" label="职称"></el-table-column>
                        <el-table-column prop="dAvgStar" label="评价/5分"></el-table-column>
                        <el-table-column prop="dPrice" label="挂号费用/元"></el-table-column>
                    </el-table>
                </div>
                <div style=" display: flex;
      justify-content: center; /* 水平居中 */
      align-items: center; /* 垂直居中 */">
                    <el-button class="iconfont icon-r-paper" v-if="clickTag" style="font-size: 14px; " type="warning"
                        @click="openClick(doctorInfo.dId, doctorInfo.dName)">
                        挂号</el-button>
                </div>
            </el-dialog>





        </el-card>
        <!-- 挂号对话框 -->
        <el-dialog title="填写挂号信息" :visible.sync="orderFormVisible">
            <el-form :model="orderForm" ref="orderForm" :rules="orderRules">
                <el-form-item label="挂号时间段" label-width="100px" prop="oTime">
                    <el-select v-model="orderForm.oTime" placeholder="请选择" no-data-text="请尝试预约明日">
                        <el-option v-for="time in times" :key="time" :label="time" :value="time">
                        </el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="挂号日期" label-width="100px">
                    <el-input v-model="orderForm.orderDate" autocomplete="off" disabled></el-input>
                </el-form-item>
                <el-form-item label="医生工号" label-width="100px">
                    <el-input v-model="orderForm.dId" autocomplete="off" disabled></el-input>
                </el-form-item>
                <el-form-item label="医生姓名" label-width="100px">
                    <el-input v-model="orderForm.dName" autocomplete="off" disabled></el-input>
                </el-form-item>
                <el-form-item label="患者姓名" label-width="100px">
                    <el-input v-model="orderForm.pName" autocomplete="off" disabled></el-input>
                </el-form-item>
                <el-form-item label="患者身份证号" label-width="100px">
                    <el-input v-model="orderForm.pCard" autocomplete="off" disabled></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="orderFormVisible = false" style="font-size: 18px"><i class="iconfont icon-r-left"
                        style="font-size: 20px"></i>
                    取 消</el-button>
                <el-button type="primary" @click="orderSuccess('orderForm')" style="font-size: 18px"><i
                        class="iconfont icon-r-yes" style="font-size: 20px"></i>
                    确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>
<script>
import jwtDecode from "jwt-decode";
import request from "@/utils/request.js";
import { getToken } from "@/utils/storage.js";
export default {
    name: "sectionMessage",
    data() {
        return {
            sectionOpt: this.$route.query.sectionOpt,
            sectionData: [],
            doctorInfo: {},
            monthDays: [],
            clickTag: false,
            orderFormVisible: false,
            dialogVisible: false,
            orderForm: { orderDate: "" },
            times: [],
            orderRules: {
                oTime: [
                    { required: true, message: "选择时间段", trigger: "blur" },
                ],
            },
            //挂号日期
            orderDate: "",
            //拼接时间和日期成为oId
            idTime: "",
        };
    },
    methods: {
        // 生成完整的图片 URL
        getFullImageUrl(imageName) {
            return `http://localhost:9000/uploads/${imageName}`;
        },
        getDoctorInfo(item) {
            this.dialogVisible = true;
            this.doctorInfo = item
            console.log(this.doctorInfo.dName)
        },
        //打开挂号对话框触发,获取挂号时间段已剩余票数
        requestTime(id) {
            this.idTime = id + this.orderDate;
            request
                .get("order/findOrderTime", {
                    params: {
                        arId: this.idTime,
                    },
                })
                .then((res) => {
                    const date = new Date(this.orderDate);
                    const today = new Date();
                    const isToday =
                        date.getFullYear() === today.getFullYear() &&
                        date.getMonth() === today.getMonth() &&
                        date.getDate() === today.getDate();
                    var array = [];
                    if (!this.isTimeAfterTarget("09:30") || !isToday) {
                        array.push(
                            "08:30-09:30  " + "   余号 " + res.data.data.eTOn
                        );
                    }
                    if (!this.isTimeAfterTarget("10:30") || !isToday) {
                        array.push(
                            "09:30-10:30  " + "   余号 " + res.data.data.nTOt
                        );
                    }
                    if (!this.isTimeAfterTarget("11:30") || !isToday) {
                        array.push(
                            "10:30-11:30  " + "   余号 " + res.data.data.tTOe
                        );
                    }
                    if (!this.isTimeAfterTarget("15:30") || !isToday) {
                        array.push(
                            "14:30-15:30  " + "   余号 " + res.data.data.fTOf
                        );
                    }
                    if (!this.isTimeAfterTarget("16:30") || !isToday) {
                        array.push(
                            "15:30-16:30  " + "   余号 " + res.data.data.fTOs
                        );
                    }
                    if (!this.isTimeAfterTarget("17:30") || !isToday) {
                        array.push(
                            "16:30-17:30  " + "   余号 " + res.data.data.sTOs
                        );
                    }
                    this.times = array;
                    this.dialogVisible = false
                });
        },
        isTimeAfterTarget(timeString) {
            // 判断时间是否超过timeString(入参格式如：09:30)
            const currentTime = new Date();

            // 解析传入的目标时间字符串，获取小时和分钟
            const [targetHour, targetMinute] = timeString.split(":");

            // 设置要比较的时间
            const targetTime = new Date();
            targetTime.setHours(targetHour);
            targetTime.setMinutes(targetMinute);
            targetTime.setSeconds(0);

            // 比较当前时间是否超过了目标时间
            return currentTime > targetTime;
        },
        //挂号点击确认
        orderSuccess(formName) {
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    request
                        .get("patient/addOrder", {
                            params: {
                                pId: this.orderForm.pId,
                                dId: this.orderForm.dId,
                                oStart:
                                    this.orderForm.orderDate +
                                    " " +
                                    this.orderForm.oTime,
                                arId: this.idTime,
                                dSection: this.sectionOpt,
                                pName: this.orderForm.pName

                            },
                        })
                        .then((res) => {
                            if (res.data.status != 200)
                                return this.$message.error(
                                    "该时间段无剩余号源！请重新选择！"
                                );
                            this.orderFormVisible = false;
                            this.$message.success("挂号成功！");
                            this.orderForm.oTime = "";
                        })
                        .catch((e) => {
                            if (e.response.data == undefined) {
                                this.$message.error(e);
                            } else {
                                this.$message.error(e.response.data);
                            }
                        });
                } else {
                    console.log("error submit!!");
                    return false;
                }
            });
        },
        //token解码
        tokenDecode(token) {
            if (token !== null) return jwtDecode(token);
        },
        //打开挂号对话框
        openClick(id, name) {
            this.orderForm.dId = id;
            this.orderForm.dName = name;
            this.orderFormVisible = true;

            //请求挂号时间段
            this.requestTime(id);
        },
        //选择日期触发时间
        dateClick(date) {
            //获取挂号年月日
            const nowDate = new Date();
            let year = nowDate.getFullYear();
            this.orderForm.orderDate = year + "-" + date;
            let dateYear = year + "-" + date;
            this.orderDate = dateYear;
            request
                .get("/arrange/findByTime", {
                    params: {
                        arTime: dateYear,
                        dSection: this.sectionOpt,
                    },
                })
                .then((res) => {
                    //this.sectionData.dId = res.data.data.doctors.dId;
                    /**
                     * 重点！！！把数组中的对象取出来用map
                     */
                    this.sectionData = res.data.data.map((item) => item.doctor);
                    this.clickTag = true;
                    console.log(res.data.data.map((item) => item.doctor));
                    //console.log(res.data.data[0].doctor);
                });
        },
        //获取当天及后7天的日期星期
        nowDay(num) {
            var nowDate = new Date();
            var currentHour = nowDate.getHours();
            var currentMinute = nowDate.getMinutes();

            // 判断当前时间是否已经过了17:30
            if (
                currentHour > 17 ||
                (currentHour === 17 && currentMinute > 30)
            ) {
                num++; // 次日
            }

            nowDate.setDate(nowDate.getDate() + num);
            var month = nowDate.getMonth() + 1;
            var date = nowDate.getDate();
            if (date < 10) {
                date = "0" + date;
            }
            if (month < 10) {
                month = "0" + month;
            }
            var time = month + "-" + date;
            this.monthDays.push(time);
        },
        //请求部门医生信息
        requestSection() {
            request
                .get("patient/findDoctorBySection", {
                    params: {
                        dSection: this.$route.query.sectionOpt,
                    },
                })
                .then((res) => {
                    if (res.data.status !== 200)
                        return this.$message.error("请求数据失败");
                    this.sectionData = res.data.data.doctors;
                    console.log(res.data.data.doctors);
                });
        },
    },
    created() {
        //获取当天的后7天
        for (var i = 0; i < 7; i++) {
            this.nowDay(i);
        }
        //按科室请求医生信息
        this.requestSection();
        // 解码token
        this.orderForm.pName = this.tokenDecode(getToken()).pName;
        this.orderForm.pCard = this.tokenDecode(getToken()).pCard;
        this.orderForm.pId = this.tokenDecode(getToken()).pId;
        //console.log(this.orderForm.pId)
    },
};
</script>
<style scoped lang="scss">
/* 容器样式 */
.container {
    width: 400px;
    max-width: 500px;
    margin: 0 auto;
}

/* 上面两个 div 的样式 */
.top-row {
    display: flex;
    /* 修改间距 */
    gap: 1px;
}

.top-row div {
    flex: 1;
    height: 200px;
    margin: 1px;
    gap: 1px;
}

/* 下面 div 的样式 */
.bottom-div {
    height: 100px;
    margin: 5px;
}

.doctor-info-container {
    display: flex;
    align-items: center;
    padding: 20px;
}

.doctor-image {
    width: 100px;
    height: 200px;
    object-fit: cover;
    border-radius: 50%;
}

.doctor-info-list {
    list-style-type: none;
    padding: 0;
}

.doctor-info-list li {
    margin-bottom: 10px;
    font-size: 16px;
}

.doctor-info-list strong {
    color: #333;
}

.doctor-card {
    width: 200px;
    text-align: center;
    padding: 20px;
    border: 1px solid #e4e7ed;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    transition: all 0.3s ease;
}

.doctor-card:hover {
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    transform: translateY(-5px);
}

.doctor-image {
    width: 150px;
    height: 150px;
    object-fit: cover;
    border-radius: 50%;
    margin-bottom: 10px;
}

.doctor-name {
    font-size: 18px;
    font-weight: 600;
    color: #333;
}

.el-col {
    padding: 5px;
}

.dateUl li {
    display: inline;
    //margin: 5px;
    padding: 1px;
}

.dateUl {
    margin: 10px;
}

.el-breadcrumb {
    margin: 8px;
}

.head {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.el-form {
    margin-top: 0;
}
</style>