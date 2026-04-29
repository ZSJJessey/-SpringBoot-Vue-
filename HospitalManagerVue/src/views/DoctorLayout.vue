<template>
    <div>
        <div>
            <!-- 使用 Element UI 的行布局 -->
            <el-row>
                <el-col :span="24">
                    <!-- 通知滚动区域 -->
                    <div class="notice-container">
                        <!-- 使用 marquee 标签实现横向滚动 -->
                        <marquee behavior="scroll" direction="left" scrollamount="5">
                            <span v-for="(notice, index) in noticeList" :key="index" class="notice-text">
                                {{ notice }}
                                <span v-if="index !== noticeList.length - 1"> | </span>
                            </span>
                        </marquee>
                    </div>
                </el-col>
            </el-row>
        </div>


        <div class="container">

            <div class="indexPeople" @click="gotoOrderToday('orderToday')">
                <div class="userImage">
                    <i class="iconfont icon-r-user2" style="font-size: 132px"></i>
                </div>

                <div class="userFont">
                    <div class="spanCure">
                        <span>就诊概况</span>
                    </div>
                    <div class="spanPeople">
                        <span>今天我的预约人数：{{ orderPeople }}</span>
                    </div>
                </div>
            </div>
            <!-- 左边滚动图片区域 -->
            <div class="right">
                <el-carousel :interval="3000" arrow="always" indicator-position="outside">
                    <el-carousel-item v-for="(image, index) in carouselImages" :key="index" style="text-align:center; ">
                        <img :src="image.src" alt="carousel image" style="width: 50%; height: 100%; object-fit: cover;"
                            @click="showDialog(index)" />

                    </el-carousel-item>
                </el-carousel>
            </div>
            <!-- 右边科室位置信息区域 -->
            <!-- 右边科室位置信息区域 -->

        </div>

        <el-dialog :visible.sync="dialogVisible" width="50%">

            <!-- 显示对话框中的图片和描述 -->
            <img :src="currentImage.src" alt="dialog image" class="dialog-image" />


            <div v-if="currentImage.index === 3">
                <div class="dialog-content">
                    <h1>医院工作会议介绍</h1>​
                    <h2>会议主题</h2>​
                    <p>“提升医疗服务质量，共筑医院发展新征程”</p>​
                    <h2>会议目的</h2>​
                    <p>总结医疗、科研、管理工作，剖析问题，明确方向，强化部门协作，提升服务水平，推动医院高质量发展。</p>​
                    <h2>会议主要内容</h2>​
                    <ul>​
                        <li>各科室汇报工作进展、成果及困难，如外科展示复杂手术案例，内科分享慢性病管理成效，提出人手短缺、设备老化等问题。</li>​
                        <li>针对问题讨论，人力部门建议优化招聘、合作高校解决人手问题；设备部门计划更新设备并争取资金。</li>​
                        <li>领导规划下一阶段工作，优化就诊流程、鼓励科研、完善绩效考核。</li>​
                    </ul>​
                    <h2>会议意义</h2>​
                    <p>搭建交流平台，促进信息共享，统一员工思想行动，解决实际问题，提升医院竞争力，保障患者就医体验。</p>
                </div>
            </div>

            <div v-if="currentImage.index === 2">
                <div class="dialog-content">
                    <h2>专业体检中心，守护您的健康</h2>
                    <p>我们的体检中心是专业的健康筛查机构。经验丰富的医疗团队，均来自知名医院，凭借扎实专业知识和丰富临床经验，为您细致检查。</p>
                    <p>引进国际先进设备，涵盖影像、检验等多领域，确保检查结果准确可靠。科学合理的体检流程，从预约到报告解读，全程高效有序。</p>
                    <p>详细体检报告不仅呈现数据，更有专业分析与建议。建立个人健康档案，为您定制专属健康管理方案，长期跟踪您的健康状况。</p>
                    <p>选择我们，就是选择专业、精准、贴心的健康保障。</p>
                </div>
            </div>
            <div v-if="currentImage.index === 1">
                <div class="dialog-content">


                    <h3>暖心一幕：锦旗背后的感恩之情</h3>
                    <p>近日，[医院名称]迎来了温馨而感人的一幕。一位康复出院的患者[患者姓名]及其家属满怀感激地来到医院，将一面绣有“[锦旗标语，如：妙手仁心除病痛，德艺双馨暖人心]”的锦旗送到了[科室名称]医护人员的手中，以此表达对医院精心治疗和悉心护理的高度认可与诚挚谢意。
                    </p>

                    <h1>曲折就医路，终遇良医解难题</h1>
                    <p>患者[患者姓名]此前饱受[疾病名称]的折磨，四处求医却效果不佳，身心承受着巨大的痛苦。在朋友的推荐下，他抱着最后一丝希望来到了[医院名称]。入院后，[科室名称]的[负责医生姓名]带领医疗团队迅速为患者进行了全面细致的检查，制定了个性化的治疗方案。在治疗过程中，医生们凭借精湛的医术和丰富的临床经验，精准把握病情变化，及时调整治疗策略；护士们则以热情周到的服务，给予患者无微不至的关怀，让患者在住院期间感受到了家的温暖。
                    </p>

                    <h2>患者心声：真心感谢医护人员的付出</h2>
                    <p>回忆起在医院的治疗经历，患者[患者姓名]感慨万千。他激动地说：“在我最绝望的时候，是[医院名称]的医护人员给了我希望。他们不仅治好了我的病，更给了我战胜病魔的信心。[负责医生姓名]医生总是耐心地解答我的每一个疑问，让我对自己的病情有了清晰的认识；护士们每天都会关心我的饮食和休息情况，就像家人一样照顾我。这份恩情，我一辈子都忘不了。”患者家属也对医护人员的辛勤付出表示了衷心的感谢，并表示这面锦旗只是一份小小的心意，远不足以表达他们内心的感激之情。
                    </p>

                    <h2>医院回应：坚守初心，继续为患者服务</h2>
                    <p>面对患者和家属的赞誉，[科室负责人姓名]表示：“这面锦旗不仅是对我们工作的肯定，更是一种鞭策和鼓励。救死扶伤是我们医护人员的职责所在，患者的康复和满意就是对我们最大的回报。我们将以此为动力，继续秉承‘以患者为中心’的服务理念，不断提升医疗技术水平和服务质量，为更多患者的健康保驾护航。”
                    </p>

                    <h2>锦旗传递正能量，医患和谐谱新篇</h2>
                </div>
            </div>

            <template #footer>
                <!-- 对话框底部的关闭按钮 -->
                <span class="dialog-footer">
                    <el-button @click="dialogVisible = false">关闭</el-button>
                </span>
            </template>
        </el-dialog>


        <div>
            <docotorExportVue></docotorExportVue>
        </div>



    </div>
</template>
<script>
import docotorExportVue from './docotorExport.vue';
import { setActivePath } from "@/utils/storage.js";
import request from "@/utils/request.js";
import jwtDecode from "jwt-decode";
import { getToken } from "@/utils/storage.js";
import { toLoad } from "@/utils/initialize.js";

export default {
    components: {
        // 注册组件
        docotorExportVue
    },
    name: "PatientLayout",
    data() {
        return {
            dialogVisible: false,
            userId: 1,
            orderPeople: 1,
            carouselImages: [
                {
                    index: 0,
                    src: require('@/assets/电话.jpeg'),
                    desc: '这是第一张图片的详细描述。'
                },
                {
                    index: 1,
                    src: require('@/assets/dcotor2.jpg'),
                    desc: '这是第二张图片的详细描述。'
                },
                {
                    index: 2,
                    src: require('@/assets/doctor4.jpg'),
                    desc: '这是第三张图片的详细描述。'
                },
                {
                    index: 3,
                    src: require('@/assets/doctor5.jpg'),
                    desc: '这是第三张图片的详细描述。'
                }
            ],
            // 当前点击的图片信息
            currentImage: {},
            departmentList: [
                { departmentName: '内科', floor: '2 楼', roomNumber: '201' },
                { departmentName: '外科', floor: '2 楼', roomNumber: '202' },
                { departmentName: '妇产科', floor: '3 楼', roomNumber: '301' },
                { departmentName: '儿科', floor: '3 楼', roomNumber: '302' },
                { departmentName: '眼科', floor: '4 楼', roomNumber: '401' },
                { departmentName: '口腔科', floor: '4 楼', roomNumber: '402' },
                { departmentName: '皮肤科', floor: '5 楼', roomNumber: '501' },
                { departmentName: '中医科', floor: '5 楼', roomNumber: '502' }
            ],
            noticeList: [
                '医院医生会议通知 各位医生为了进一步提升医疗服务质量，加强各科室之间的交流与协作，医院决定召开全体医生会议，现将有关事项通知如下 一、会议时间 具体日期] [上午/下午/晚上] [具体时间]>二、会议地点',
                '培训讲师 本次培训邀请了多位业内知名专家进行授课，他们具有丰富的临床经验和深厚的学术造诣。',
                '请各位医生务必按时参加培训，培训期间严格遵守课堂纪律。培训结束后将进行考核，考核结果将纳入个人绩效考核。'
            ]
        };
    },
    mounted() {
        // 组件挂载后启动自动滚动
        toLoad()
    },
    created() {
        this.userId = this.tokenDecode(getToken()).dId;
        this.requestPeople();
    },

    methods: {

        gotoOrderToday(path) {

            this.activePath = path;
            setActivePath(path);
            if (this.$route.path !== "/" + path) this.$router.push(path);
            console.log(path);
        },

        //token解码
        tokenDecode(token) {
            if (token !== null) return jwtDecode(token);
        },
        requestPeople() {
            request
                .get("order/orderPeopleByDid", {
                    params: {
                        dId: this.userId,
                    },
                })
                .then((res) => {
                    if (res.data.status !== 200)
                        return this.$message.error("数据请求失败");
                    this.orderPeople = res.data.data;
                });
        },
        // 点击图片时触发的方法
        showDialog(index) {
            // 设置当前图片信息
            this.currentImage = this.carouselImages[index];
            // 显示对话框
            this.dialogVisible = true;
        },

    },
    beforeDestroy() {
        // 组件销毁前清除定时器，避免内存泄漏
        if (this.scrollInterval) {
            clearInterval(this.scrollInterval);
        }
    }
};

</script>
<style lang="scss" scoped>
/* 对话框内容样式 */
.dialog-content {
    padding: 20px;
    line-height: 1.6;
}

.dialog-image {
    width: 100%;
    height: auto;
    border-radius: 8px;
    margin-bottom: 20px;
}

.dialog-introduction {
    line-height: 1.6;
}

.dialog-introduction h3 {
    color: #333;
    font-size: 20px;
    margin-bottom: 10px;
}

.dialog-introduction p {
    color: #666;
    font-size: 16px;
    margin-bottom: 15px;
}

.dialog-footer {
    text-align: right;
}

.container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px;
}

.left {
    width: 30%;
    height: 300px;
}

.right {
    margin-left: 10px;
    width: 70%;
}

h2 {
    margin-bottom: 10px;
}

.title {
    text-align: center;
    /* 标题文字居中 */
    margin-bottom: 10px;
    font-weight: bold;
    /* 标题文字加粗 */
    color: blue
}

.el-table .cell {
    font-size: 16px;
    font-weight: bold;
    /* 标题文字加粗 */
}

.el-table td {
    text-align: center;
    /* 表格内容文字居中 */
    font-weight: bold;
    /* 表格内容文字加粗 */
    color: #333;
    /* 表格内容文字颜色 */
}

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

.notice-container {
    background-color: #f0f0f0;
    /* 设置背景颜色 */
    padding: 10px;
    /* 添加内边距 */
    border-radius: 4px;
    /* 设置圆角 */
}

.indexPeople {
    height: 200px;
    width: 440px;
    background: #66b1ff;
    float: left;
    margin: 30px;
    border-radius: 10px;
}

.notice-text {
    color: red;
    /* 设置文字颜色为红色 */
    font-size: 16px;
    /* 设置文字大小 */
}
</style>