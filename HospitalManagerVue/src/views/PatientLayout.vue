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
      <!-- 左边滚动图片区域 -->
      <div class="left">
        <el-carousel :interval="3000" arrow="always" indicator-position="outside">
          <el-carousel-item v-for="(image, index) in carouselImages" :key="index">
            <img :src="image.src" alt="carousel image" style="width: 100%; height: 100%; object-fit: cover;"
              @click="showDialog(index)" />

          </el-carousel-item>
        </el-carousel>
      </div>
      <!-- 右边科室位置信息区域 -->
      <!-- 右边科室位置信息区域 -->
      <!-- 右边科室位置信息区域 -->
      <div class="right">
        <h2 class="title">医院科室楼层及门牌号信息</h2>
        <el-scrollbar ref="scrollbarRef" style="height: 300px;">
          <el-table :data="departmentList" style="width: 1500px ;color:blue">
            <el-table-column prop="departmentName" label="科室名称"></el-table-column>
            <el-table-column prop="floor" label="楼层"></el-table-column>
            <el-table-column prop="roomNumber" label="门牌号"></el-table-column>
          </el-table>
        </el-scrollbar>
      </div>
    </div>

    <el-dialog :visible.sync="dialogVisible" width="50%">

      <!-- 显示对话框中的图片和描述 -->
      <img :src="currentImage.src" alt="dialog image" class="dialog-image" />
      <div v-if="currentImage.index === 0">
        <div class="dialog-content">
          <h3>医者仁爱 大爱无疆</h3>
          <p>在生命的长河中，有这样一群人，他们身着白衣，宛如天使，用爱与责任守护着每一个生命。他们，就是医者。</p>
          <p>
            医者的仁爱，是面对患者时那温柔的眼神，是耐心倾听病情的专注，是为患者制定治疗方案时的殚精竭虑。无论严寒酷暑，无论白昼黑夜，只要患者有需求，他们总是第一时间出现在病床前。他们不辞辛劳，不怕危险，在病魔肆虐的战场，与死神展开殊死搏斗。
          </p>
          <p>
            新冠疫情爆发时，无数医者逆行而上，奔赴抗疫一线。他们不顾个人安危，日夜奋战在病房，用自己的身躯为患者筑起一道生命防线。他们用精湛的医术，从死神手中夺回一个个鲜活的生命；他们用无私的奉献，诠释着医者的使命与担当。
          </p>
          <p>医者仁爱，大爱无疆。他们的付出，让生命得以延续，让希望重新燃起。他们是生命的守护者，是人间的天使。让我们向所有的医者致敬，感恩他们的付出与奉献！</p>
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
          <h4>（一）个人防护</h4>
          <p>1. <strong>佩戴口罩</strong>：在人员密集的公共场所、乘坐公共交通工具时，应正确佩戴口罩。口罩可以有效阻挡飞沫传播，选择符合标准的医用外科口罩或 N95 口罩，并注意及时更换。</p>
          <p>2. <strong>勤洗手</strong>：使用肥皂或洗手液，按照七步洗手法认真洗手，尤其是在接触公共物品后、咳嗽或打喷嚏后、饭前便后等。洗手时间不少于 20 秒，确保手部各个部位都能得到清洁。</p>
          <p>3. <strong>保持社交距离</strong>：与他人保持至少 1
            米以上的社交距离，避免近距离接触，减少飞沫传播的风险。尽量避免前往人员密集的场所，如果必须前往，要注意观察周围环境，避免与有呼吸道症状的人员密切接触。</p>
          <h4>（二）环境管理</h4>
          <p>1. <strong>通风换气</strong>：每天定时开窗通风，保持室内空气新鲜。在冬春季节，可选择在中午气温较高时通风；夏秋季节则可以增加通风次数和时间。一般每次通风时间不少于 30 分钟。</p>
          <p>2. <strong>清洁消毒</strong>：定期对居住和工作环境进行清洁消毒，尤其是经常接触的物品表面，如门把手、桌椅、电器开关等。可以使用含氯消毒剂或 75%酒精进行擦拭消毒。</p>
          <h4>（三）增强免疫力</h4>
          <p>1. <strong>合理饮食</strong>：保证营养均衡，多吃富含维生素、蛋白质和矿物质的食物，如新鲜的蔬菜水果、瘦肉、鱼类、蛋类、奶制品等。避免食用过多辛辣、油腻、刺激性食物，减少对呼吸道黏膜的刺激。
          </p>
          <p>2. <strong>适量运动</strong>：根据个人情况选择适合的运动方式，如散步、慢跑、太极拳、瑜伽等。每周至少进行 3 - 5 次运动，每次运动 30 分钟以上，有助于增强体质，提高免疫力。</p>
          <p>3. <strong>充足睡眠</strong>：保持规律的作息时间，每天保证 7 - 8 小时的睡眠时间。良好的睡眠可以使身体得到充分的休息和恢复，有助于维持免疫系统的正常功能。</p>
          <h4>（四）及时就医</h4>
          <p>如果出现发热、咳嗽、咽痛等呼吸道症状，应及时就医，并告知医生自己的旅行史和接触史。在就医过程中，要佩戴好口罩，避免乘坐公共交通工具，尽量减少与他人的接触，防止疾病传播。</p>
          <h3>五、总结</h3>
          <p>季节呼吸道传染病的防控需要我们每个人从自身做起，采取科学有效的防控措施。通过加强个人防护、改善环境条件、增强免疫力等多方面的努力，我们可以有效降低感染呼吸道传染病的风险，度过一个健康、舒适的季节。</p>
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
      <HospitalIntroduction></HospitalIntroduction>
    </div>



  </div>
</template>
<script>

import request from "@/utils/request.js";
import { toLoad } from "@/utils/initialize.js";
import HospitalIntroduction from './hospitalDetail.vue';
export default {
  components: {
    // 注册组件
    HospitalIntroduction
  },
  name: "PatientLayout",
  data() {
    return {
      dialogVisible: false,
      activePath: "",
      carouselImages: [
        {
          index: 0,
          src: require('@/assets/宣传1.webp'),
          desc: '这是第一张图片的详细描述。'
        },
        {
          index: 1,
          src: require('@/assets/宣传2.webp'),
          desc: '这是第二张图片的详细描述。'
        },
        {
          index: 2,
          src: require('@/assets/宣传3.webp'),
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
        '重要通知：医院本周六将进行系统维护，届时部分服务可能会受到影响，请各位患者提前做好安排。',
        '通知：下周一专家门诊时间有调整，具体时间请查看医院官网。',
        '紧急通知：因疫情防控需要，进入医院请务必佩戴好口罩，出示健康码和行程码。'
      ]
    };
  },
  mounted() {
    // 组件挂载后启动自动滚动
    this.startAutoScroll();
  },
  methods: {
    // 点击图片时触发的方法
    showDialog(index) {
      // 设置当前图片信息
      this.currentImage = this.carouselImages[index];
      // 显示对话框
      this.dialogVisible = true;
    },
    startAutoScroll() {
      // 获取 el-scrollbar 组件的 DOM 元素
      const scrollbar = this.$refs.scrollbarRef.$el.querySelector('.el-scrollbar__wrap');
      // 设置滚动间隔（毫秒）
      const interval = 20;
      // 设置每次滚动的距离
      const step = 1;
      // 开启定时器实现自动滚动
      this.scrollInterval = setInterval(() => {
        // 滚动到底部后重置滚动位置
        if (scrollbar.scrollTop + scrollbar.clientHeight >= scrollbar.scrollHeight) {
          scrollbar.scrollTop = 0;
        } else {
          // 正常滚动
          scrollbar.scrollTop += step;
        }
      }, interval);
    }
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
  width: 50%;
  height: 300px;
}

.right {
  margin-left: 10px;
  width: 50%;
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

.notice-text {
  color: red;
  /* 设置文字颜色为红色 */
  font-size: 16px;
  /* 设置文字大小 */
}
</style>