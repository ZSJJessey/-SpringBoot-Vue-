<template>
    <div>
        <el-card>
            <!-- 搜索栏 -->
            <el-row type="flex">
                <el-col :span="6">
                    <el-input v-model="query" placeholder="请输入患者id查询">
                        <el-button
                            slot="append"
                            style="font-size: 18px;"
                            @click="requestOrders"
                        ><i class="iconfont icon-r-find" style="font-size: 22px;"></i> 查询</el-button>
                    </el-input>
                </el-col>
            </el-row>


            <el-row :gutter="20" class="el-row" type="flex">
            <el-col :span="8" v-for="(item, index) in orderData" :key="index" class="el-col">
                <el-card class="el-card" :key="index" onclick="">
                    <div slot="header" class="clearfix">
                        <span>挂号单号：</span> <span>{{ item.oId }}</span>
                    </div>
                    <div>

                        <div class="text item">
                            <div class="item_tag">
                                <span>患者姓名</span>
                            </div>
                            <div class="item_desr">
                                {{ item.pName }}
                            </div>
                        </div>
                        <div class="text item">
                            <div class="item_tag">
                                <span>挂号时间</span>
                            </div>
                            <div class="item_desr">
                                <span>
                                    {{ item.oStart }}
                                </span>
                            </div>
                        </div>
                        <div class="text item">
                            <div class="item_tag">
                                <span>病因</span>
                            </div>
                            <div class="item_desr">
                                {{ item.oRecord }}
                            </div>
                        </div>
                        <div class="text item">
                            <div class="item_tag">
                                <span>药物</span>
                            </div>
                            <div class="item_desr">
                                {{ item.oDrug }}
                            </div>
                        </div>
                        <div class="text item">
                            <div class="item_tag">
                                <span>检查项目：</span>
                            </div>
                            <div class="item_desr">
                                {{ item.oCheck }}
                            </div>
                        </div>
                        <div class="text item">
                            <div class="item_tag">
                                <span>挂号状态：</span>
                            </div>
                            <div class="item_desr">

                                <span type="success" v-if="
                                    item.oState === 1 &&
                                    item.oPriceState === 1
                                ">已完成</span>
                                <span style="color: red;" v-if="
                                    item.oState === 0 && item.oPriceState === 0
                                ">未完成</span>

                            </div>
                        </div>
                    </div>
                    <div class="text item">
                        <div class="item_tag">
                            <span>缴费状态</span>
                        </div>
                        <div class="item_desr">
                            <span
                            type="success"
                            v-if=" item.oState === 1 && item.oPriceState === 1"
                            >已缴费</span
                        >
                        <!-- <el-tag type="danger" v-if="scope.row.oPriceState === 0 && scope.row.oState === 1">未缴费</el-tag> -->
                        <span
                            style="color: red;"
                        
                            v-if=" item.oState === 0 && item.oPriceState === 0" 
                            >未缴费</span
                        >
                        </div>
                    </div>
                    <el-button
                            type="warning"
                            style="font-size: 18px"
                            @click="dealClick(item, item.pId)"
                            v-if="
                            item.oState === 1 &&
                            item.oPriceState === 1"
                            ><i class="iconfont icon-r-yes" style="font-size: 22px;"></i> 追诊</el-button
                        >

                </el-card>
            </el-col>
        </el-row>



          

            <!-- 分页 -->
            <el-pagination
                @size-change="handleSizeChange"
                @current-change="handleCurrentChange"
                background
                layout="total, sizes, prev, pager, next, jumper"
                :current-page="pageNumber"
                :page-size="size"
                :page-sizes="[1, 2, 4, 8, 16]"
                :total="total"
            >
            </el-pagination>
        </el-card>
    </div>
</template>
<script>
import request from "@/utils/request.js";
import jwtDecode from "jwt-decode";
import { toLoad } from "@/utils/initialize.js";
import { getToken } from "@/utils/storage.js";
export default {
    name: "DoctorOrder",
    data() {
        return {
            userId: 1,
            orderData: [],
            pageNumber: 1,
            size: 8,
            query: "",
            total: 3,
        };
    },
    methods: {
        //点击追诊按钮
        dealClick(oId, pId) {
            this.$router.push({
                path: "/dealOrderAgain",
                query: {
                    oId: oId,
                    pId: pId,
                },
            });
        },
        //页面大小改变时触发
        handleSizeChange(size) {
            console.log(size);
            this.size = size;
            this.requestOrders();
        },
        //   页码改变时触发
        handleCurrentChange(num) {
            console.log(num);
            this.pageNumber = num;
            this.requestOrders();
        },

        //请求挂号信息
        requestOrders() {
            request
                .get("order/findOrderByDid", {
                    params: {
                        dId: this.userId,
                        pageNumber: this.pageNumber,
                        size: this.size,
                        query: this.query,
                    },
                })
                .then((res) => {
                    toLoad()
                    if (res.data.status !== 200)
                        this.$message.error("请求数据失败");
                    this.orderData = res.data.data.orders;
                    this.total = res.data.data.total;

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
        this.userId = this.tokenDecode(getToken()).dId;
        console.log(this.orderData.pName);
        //this.orderData.pName = "dasda"
        this.requestOrders();
    },
};
</script>
<style lang="scss" scoped>
.el-table {
    margin-top: 20px;
    margin-bottom: 20px;
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

</style>