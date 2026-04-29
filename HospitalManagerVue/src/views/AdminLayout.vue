<template>
    <div >
       <DataExpore></DataExpore>
        <div>
            <!-- <div class="indexImage">
        <img src="@/assets/hospital.jpeg" class="layoutImage"/>
        <span>今天预约挂号总人数：{{orderPeople}}</span>
      </div> -->


        


        </div>
    </div>
</template>
<script>
import request from "@/utils/request.js";
import { toLoad } from "@/utils/initialize.js";

import DataExpore from "./DataExpore.vue";

export default {

components:{
    DataExpore
},


    name: "AdminLayout",
    data() {
        return {
            orderPeople: 1,
            bedPeople: 1,
            src: '/static/timeclock.html'
        };
    },
    methods: {


        requestPeople() {
            request
                .get("order/orderPeople")
                .then((res) => {
                    if (res.data.status !== 200)
                        return this.$message.error("数据请求失败");
                    this.orderPeople = res.data.data;
                })
                .catch((err) => {
                    console.error(err);
                });
        },
        requestBed() {
            request
                .get("bed/bedPeople")
                .then((res) => {
                    if (res.data.status !== 200)
                        return this.$message.error("数据请求失败");
                    this.bedPeople = res.data.data;
                })
                .catch((err) => {
                    console.error(err);
                });
        },
    },
    created() {
        this.requestPeople();
        this.requestBed();
    },
    mounted() {
        toLoad()
    }
};
</script>
<style lang="scss" scoped>
.userFont {
    height: 150px;
    width: 250px;
    float: right;
    color: white;

    .spanCure {
        font-size: 15px;
        margin-top: 60px;
        margin-bottom: 15px;
    }

    .spanPeople {
        font-size: 18px;
    }
}

.userImage {
    height: 150px;
    width: 150px;
    font-size: 130px;
    color: white;
    position: relative;
    left: 40px;
    top: 10px;
    float: left;
}

.indexPeople {
    height: 200px;
    width: 440px;
    background: #66b1ff;
    float: left;
    margin: 30px;
    border-radius: 10px;
}
</style>