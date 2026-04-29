<template>
    <div class="Echarts">
        <div id="orderPeople" class="chart-item"></div>
        <div id="orderSection" class="chart-item"></div>

    </div>
</template>
<script>
import request from "@/utils/request.js";
export default {
    name: "dataExpore",
    data() {
        return {
            sevenDate: [],
            sevenOrder: [],
        };
    },
    methods: {

        //挂号人数图表
        orderPeople() {
            var myChart = this.$echarts.init(document.getElementById("orderPeople"));
            request
                .get("order/orderSeven")
                .then((res) => {
                    if (res.data.status !== 200)
                        return this.$message.error("数据请求失败！");
                    var option = {
                        title: {
                            text: "近20天挂号人数折线图",
                            left: "5%",
                        },
                        xAxis: {
                            type: "category",
                            data: this.sevenDate,
                        },
                        yAxis: {
                            type: "value",
                        },
                        series: [
                            {
                                data: res.data.data,
                                type: "line",
                            },
                        ],
                    };
                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);
                })
                .catch((err) => {
                    console.error(err);
                });
        },
        //统计挂号科室人数
        orderSection() {
            var myChart = this.$echarts.init(document.getElementById("orderSection"));
            request.get("order/orderSection")
                .then(res => {
                    console.log(res.data.data.map((item) => item.countSection));
                    console.log(res.data.data.map((item) => item.doctor.dSection))
                    var option = {
                        title: {
                            text: '挂号科室人数统计',
                            left: 'center'
                        },
                        xAxis: {
                            type: 'category',
                            data: res.data.data.map((item) => item.doctor.dSection),
                            axisLabel: {//解决各个不显示问题
                                interval: 0,
                                rotate: 10,
                            }

                        },
                        yAxis: {
                            type: 'value'
                        },
                        series: [{
                            data: res.data.data.map((item) => item.countSection),
                            type: 'bar',
                            showBackground: true,
                            backgroundStyle: {
                                color: 'rgba(180, 180, 180, 0.2)'
                            }
                        }]
                    };
                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);




                })
                .catch(err => {
                    console.error(err);
                })
        }
    },
    mounted() {
        this.orderPeople();

        this.orderSection();



    },
    created() {
        //获取过去7天日期
        for (var i = 20; i > 0; i--) {
            this.sevenDate.push(this.pastSeven(i));
        }
    },
};
</script>

<style>
.Echarts {
    display: flex;
    /* 子元素之间的间距 */
    gap: 20px;
    /* 调整列间距 */
}

.chart-item {
    flex: 1;
    height: 100px;
    background-color: #f0f0f0;
    border: 1px solid #ccc;
}
</style>
