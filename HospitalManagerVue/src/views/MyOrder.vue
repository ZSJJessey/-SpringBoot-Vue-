<template>
    <div>

        <el-row :gutter="20" class="el-row" type="flex">
            <el-col :span="8" v-for="(item, index) in orderData" :key="index" class="el-col">
                <el-card class="el-card" :key="index" onclick="">
                  


                    <div slot="header" class="clearfix">
                        <span>挂号单号：</span> <span>{{ item.oId }}</span>
                    </div>
                    <div>

                        <div class="text item">
                            <div class="item_tag">
                                <span>医生姓名：</span>
                            </div>
                            <div class="item_desr">
                                {{ item.dName }}
                            </div>
                        </div>
                        <div class="text item">
                            <div class="item_tag">
                                <span>科室 ：</span>
                            </div>
                            <div class="item_desr">
                                <span>
                                    {{ item.dSection }}
                                </span>
                            </div>
                        </div>
                        <div class="text item">
                            <div class="item_tag">
                                <span>挂号时间：</span>
                            </div>
                            <div class="item_desr">
                                {{ item.oStart }}
                            </div>
                        </div>
                        <div class="text item">
                            <div class="item_tag">
                                <span>挂号状态：</span>
                            </div>
                            <div class="item_desr">

                                <el-tag type="success" v-if="
                                    item.oState === 1 &&
                                    item.oPriceState === 1
                                ">已完成</el-tag>
                                <el-tag type="danger" v-if="
                                    item.oState === 0 && item.oState === 0
                                ">未完成</el-tag>

                            </div>
                        </div>
                    </div>
                    <div class="text item">
                        <div class="item_tag">
                            <span>缴费状态</span>
                        </div>
                        <div class="item_desr">
                            <el-tag type="success" v-if="item.oPriceState === 1">已缴费</el-tag>
                            <!-- <el-tag type="danger" v-if="scope.row.oPriceState === 0 && scope.row.oState === 1">未缴费</el-tag> -->
                            <el-button type="warning" icon="iconfont icon-r-mark1" style="font-size: 14px" v-if="
                                item.oPriceState === 0
                            " @click="priceClick(item.oId, item.dId)">
                                点击缴费</el-button>
                        </div>
                    </div>
                    <div class="text item">
                        <div class="item_tag">
                            <span>报告单</span>
                        </div>
                        <div class="item_desr">
                            <el-button type="success" icon="iconfont icon-r-find" style="font-size: 14px"
                                @click="seeReport(item.oId)" v-if="
                                    item.oState === 1 &&
                                    item.oPriceState === 1
                                "> 查看</el-button>
                        </div>
                    </div>

                </el-card>
            </el-col>
        </el-row>







        <!-- 评价对话框 -->
        <el-dialog title="用户评价" :visible.sync="starVisible">
            <div>
                <h3>
                    请对工号：{{ dId }}&nbsp;医生：{{ dName }}&nbsp;进行评价
                </h3>
            </div>
            <div>
                <el-rate v-model="star" show-text> </el-rate>
            </div>
            <div slot="footer" class="dialog-footer">
                <el-button @click="starVisible = false" style="font-size: 18px;"><i class="iconfont icon-r-left"
                        style="font-size: 20px;"></i> 取 消</el-button>
                <el-button type="primary" @click="starClick" style="font-size: 18px;"><i class="iconfont icon-r-yes"
                        style="font-size: 20px;"></i> 确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>
<script>
import request from "@/utils/request.js";
import jwtDecode from "jwt-decode";
import { getToken } from "@/utils/storage.js";
export default {
    name: "MyOrder",
    data() {
        return {
            userId: 1,
            orderData: [],
            star: 5,
            starVisible: false,
            dId: 1,
            dName: "",
        };
    },
    methods: {
        //评价点击确认
        starClick() {
            console.log(this.star);
            console.log(this.dId);
            request
                .get("doctor/updateStar", {
                    params: {
                        dId: this.dId,
                        dStar: this.star,
                    },
                })
                .then((res) => {
                    if (res.data.status !== 200)
                        return this.$message.error("评价失败");
                    this.$message.success("谢谢您的评价");
                    this.starVisible = false;
                });
        },
        //查看报告单
        seeReport(id) {
            window.location.href =
                "http://localhost:9000/patient/pdf?oId=" + id;
        },
        //点击缴费按钮
        priceClick(oId, dId) {
            request
                .get("order/updatePrice", {
                    params: {
                        oId: oId,
                    },
                })
                .then((res) => {
                    if (res.data.status !== 200) {
                        this.$message.error("请求数据失败");
                        return;
                    }
                    this.$message.success("单号 " + oId + " 缴费成功！");
                    request
                        .get("admin/findDoctor", {
                            params: {
                                dId: dId,
                            },
                        })
                        .then((res) => {
                            if (res.data.status !== 200)
                                return this.$message.error("请求数据失败");
                            this.dId = res.data.data.dId;
                            this.dName = res.data.data.dName;
                        });
                    this.starVisible = true;
                    this.requestOrder();
                });
        },
        //请求挂号信息
        requestOrder() {
            request
                .get("patient/findOrderByPid", {
                    params: {
                        pId: this.userId,
                    },
                })
                .then((res) => {
                    if (res.data.status !== 200)
                        this.$message.error("请求数据失败");
                    this.orderData = res.data.data;
                    this.orderData.dSection = res.data.data.map(item => item.doctor.dSection);
                    //console.log(res.data.data.map(item => item.doctor.dSection));
                    console.log(this.orderData.oId);
                    console.log(this.orderData.pName);
                    console.log(res);
                });
        },
        //token解码
        tokenDecode(token) {
            if (token !== null) return jwtDecode(token);
        },
    },
    created() {
        // 解码token
        //this.orderData.pName = this.tokenDecode(getToken()).pName;
        //this.orderData.pCard = this.tokenDecode(getToken()).pCard;
        this.userId = this.tokenDecode(getToken()).pId;
        console.log(this.orderData.pName);
        //this.orderData.pName = "dasda"
        this.requestOrder();
    },
};
</script>
<style lang="scss" scoped>
.el-dialog div {
    text-align: center;
    margin-bottom: 8px;
}

.all {
    margin-top: -30px;
    word-break: break-all;
    height: 100%;
}

.mid {
    margin-top: 25%;
    height: 50%;
}

.mid_item {
    justify-content: center;
    align-items: center;
}

.item {
    margin-bottom: 10px;
}

.item_tag {
    float: left;
    text-align: end;
}

.item_desr {
    margin-left: 40%;
    min-height: 30px;
    text-align: left;
}

.text {
    width: 100%;
    font-size: 14px;
    font-family: "Microsoft YaHei";
    text-align: end;
    color: black,

}

.clearfix:before,
.clearfix:after {
    display: table;
    content: "";
}

.clearfix:after {
    clear: both
}

.el-card {
    min-width: 100%;
    height: 100%;
    margin-right: 20px;
    /*transition: all .5s;*/
}

.el-card:hover {
    margin-top: -5px;
}

.el-row {
    margin-bottom: 20px;
    display: flex;
    flex-wrap: wrap
}

.el-col {
    border-radius: 4px;
    align-items: stretch;
    margin-bottom: 40px;
}
</style>