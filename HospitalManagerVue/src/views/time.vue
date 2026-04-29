<template>
    <!--圆圈-->
    <div class="notice_border">
        <div class="notice_position notice_name_class" v-for="item in [3, 6, 9, 12]">{{ item }}</div>
        <!--最中心的点-->
        <div class="notice_node" />
        <!--时针-->
        <div class="notice_hour_class" ref="hour_time" />
        <!--分针-->
        <div class="notice_minutes_class" ref="second_time" />
        <!--刻度线-->
        <div class="scale_class" :ref="`scale_${index}`" v-for="(item, index) in 60" :key="index" />
    </div>
</template>
<script>
import moment from "moment";

export default {
    data() {
        return {
            notice_time: '',//时间
        }
    },
    props: {
        // 获取传入时间
        props_time: {
            type: [String, Number],
        }
    },
    watch: {
        props_time(newVal, oldVal) {
            this.notice_time = newVal;
            this.get_notice_time();
        }, deep: true
    },
    methods: {
        get_notice_time() {
            //let notice_time = this.notice_time;//时间格式
            let notice_time = '12:00';//时间格式
            for (let i = 0; i < 60; i++) {
                let scale_class = this.$refs[`scale_${i}`];  // 获取每个元素
                scale_class[0].style.transform = `rotate(${i * 6}deg)`;  // 修改样式
            }

            let hour_time = this.$refs.hour_time;//时针
            let second_time = this.$refs.second_time;//分针
            if (notice_time != 0) {//防止时间为空
                let hour = moment(notice_time.split(':')[0], 'HH').format('H');//时针
                let minute = moment(notice_time.split(':')[1], 'mm').format('m');//分针
                hour_time.style.transform = `rotate(${hour * 30 + minute * 0.5}deg)`;//时针一次转30°
                second_time.style.transform = `rotate(${minute * 6}deg)`;//分针一次转6°
            }
        }
    }
}
</script>
<style scoped lang="less">
.notice_border {
    width: 58%;
    height: 57%;
    border-radius: 100%;
    border: 5px solid #3673E3;
    position: relative;
}


.notice_position {
    position: absolute;
    color: skyblue;
    font-weight: bolder;
}

.notice_name_class:nth-child(1) {
    right: 7%;
    top: 41%;
}

.notice_name_class:nth-child(2) {
    right: 44%;
    bottom: 4%;
}

.notice_name_class:nth-child(3) {
    left: 8%;
    top: 41%;
}

.notice_name_class:nth-child(4) {
    left: 42%;
    top: 4%;
}

.notice_node {
    position: absolute;
    width: 10%;
    height: 10%;
    border-radius: 100%;
    background-color: #3673E3;
    left: 45%;
    top: 45%;
    z-index: 2;
}

.notice_hour_class {
    position: absolute;
    width: 5%;
    height: 20%;
    background-color: red;
    left: 47.5%;
    top: 30%;
    border-radius: 5px 5px 0 0;
    z-index: 1;
    transform-origin: bottom;
    //transform: rotate(90deg);
}

.notice_minutes_class {
    position: absolute;
    width: 5%;
    height: 33%;
    background-color: #3673E3;
    left: 47.5%;
    top: 18%;
    border-radius: 5px 5px 0 0;
    transform-origin: bottom;
}

.scale_class {
    position: absolute;
    width: 1%;
    height: 7%;
    background-color: #3673E3;
    top: 0;
    left: 50%;
    transform-origin: center 60px;
}

.scale_class:nth-of-type(5n-2) {
    width: 2.5%;
    height: 10%;
}
</style>