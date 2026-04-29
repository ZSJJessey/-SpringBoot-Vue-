<template>
    <div style="width: 100%;margin-top: -10px">
        <el-card shadow="hover">
            <!-- 医生照片 -->
            <div class="doctor-photo">
                <!-- 这里可以替换为实际的图片地址 -->
                <img :src="getFullImageUrl(doctorData.d_avatarUrl)" style=" border-radius: 5px;">
            </div>
            <!-- 医生信息表格 -->
            <div class="doctor-info-table">
                <table>
                    <tr>
                        <td>姓名：</td>
                        <td>{{ doctorData.dName }}</td>
                    </tr>
                    <tr>
                        <td>账号：</td>
                        <td>{{ doctorData.dId }}</td>
                    </tr>
                    <tr>
                        <td>性别：</td>
                        <td>{{ doctorData.dGender }}</td>
                    </tr>
                    <tr>
                        <td>手机号：</td>
                        <td>{{ doctorData.dPhone }}</td>
                    </tr>
                    <tr>
                        <td>身份证号：</td>
                        <td>{{ doctorData.dCard }}</td>
                    </tr>

                    <tr>
                        <td>职位：</td>
                        <td>{{ doctorData.dPost }}</td>
                    </tr>
                    <tr>
                        <td>所属科室：</td>
                        <td>{{ doctorData.dSection }}</td>
                    </tr>
                    <tr>
                        <td>挂号价格：</td>
                        <td>{{ doctorData.dPrice }}</td>
                    </tr>
                    <tr>
                        <td>评分：</td>
                        <td>{{ doctorData.dAvgStar }}</td>
                    </tr>
                    <tr>
                        <td>简介：</td>
                        <td class="doctor-introduction">{{ doctorData.dIntroduction }}</td>
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
    name: "DoctorCard",
    data() {
        return {
            userId: "",
            doctorData: {},
        };
    },
    methods: {
        // 生成完整的图片 URL
        getFullImageUrl(imageName) {
            return `http://localhost:9000/uploads/${imageName}`;
        },
        // 请求医生信息
        requestDoctor() {
            request
                .get("admin/findDoctor", {
                    params: {
                        dId: this.userId,
                    },
                })
                .then((res) => {
                    if (res.data.status != 200)
                        return this.$message.error("获取数据失败");
                    this.doctorData = res.data.data;
                });
        },
        // token 解码
        tokenDecode(token) {
            if (token !== null) return jwtDecode(token);
        },
    },
    created() {
        // 解码 token 信息
        this.userId = this.tokenDecode(getToken()).dId;
        this.requestDoctor();
        console.log(this.userId);
    },
};
</script>

<style lang="scss" scoped>
.doctor-photo {
    text-align: center;

    img {
        width: 15%;
        height: 15%;
        border-radius: 50%;
        object-fit: cover;
        /* 保持图片比例，填充容器 */

        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
}

.doctor-info-table {
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

.doctor-introduction {
    white-space: normal;
    word-wrap: break-word;
    word-break: break-all;
}
</style>