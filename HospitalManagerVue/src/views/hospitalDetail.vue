<template>
    <div>
      <el-card class="hospital-card">
        <template #header>
          <span class="card-header-title">医院介绍</span>
        </template>
        <div v-if="!isExpanded">
          <p class="brief-intro">我们的医院是一座医疗界的璀璨明珠，集医疗、教学、科研、预防、保健等多功能于一体。凭借先进的医疗设备、精湛的医术和贴心的服务，多年来赢得了广大患者的高度赞誉与信赖。</p>
          <el-button @click="toggleExpand" size="mini" type="primary">查看更多</el-button>
        </div>
        <div v-if="isExpanded">
          <el-tabs v-model="activeTab" class="hospital-tabs">
            <el-tab-pane label="基本信息" name="info">
              <p>我院是一所具有深厚历史底蕴和卓越医疗水平的三级甲等综合性医院。医院占地面积达 [X] 平方米，绿树成荫、环境优美，为患者营造了舒适的就医环境。建筑面积 [X] 平方米，拥有现代化的门诊大楼、住院部、医技楼等设施，布局合理、功能齐全。</p>
              <p>医院编制床位 [X] 张，每间病房都配备了齐全的生活设施和先进的医疗设备，充分保障患者的治疗和生活需求。在医疗设备方面，我们紧跟国际前沿，斥巨资引进了一系列高端设备，如 3.0T 磁共振成像系统（MRI），能够提供高分辨率的影像，助力疾病的精准诊断；直线加速器则为肿瘤患者提供了先进的放疗手段；此外，还有全自动生化分析仪、数字化乳腺钼靶机等，为临床诊断和治疗提供了强有力的支持。</p>
            </el-tab-pane>
            <el-tab-pane label="科室介绍" name="departments">
              <p>医院科室设置完备，涵盖了临床、医技等多个领域，为患者提供全方位的医疗服务。</p>
              <p><strong>内科系统</strong>：包括心血管内科、呼吸内科、消化内科、神经内科等多个专科。心血管内科在冠心病、心律失常、心力衰竭等疾病的诊治方面具有丰富的经验，开展了冠状动脉造影、支架植入等先进技术；呼吸内科擅长治疗慢性阻塞性肺疾病、哮喘、肺癌等疾病，拥有先进的呼吸内镜诊疗技术；消化内科在胃肠疾病、肝病的诊断和治疗上成绩斐然，开展了无痛胃肠镜检查、内镜下治疗等项目。</p>
              <p><strong>外科系统</strong>：有普通外科、骨科、神经外科、泌尿外科等。普通外科在肝胆胰脾、胃肠肿瘤等疾病的手术治疗方面技术精湛；骨科开展了关节置换、脊柱手术、创伤骨折治疗等多项高难度手术；神经外科在颅脑肿瘤、脑血管疾病的治疗上具有领先水平；泌尿外科在前列腺疾病、泌尿系统结石、肿瘤等疾病的诊治方面经验丰富。</p>
              <p><strong>其他科室</strong>：妇产科为孕产妇提供了从孕期保健、分娩到产后康复的一站式服务；儿科在儿童常见疾病、疑难病症的诊治方面有着独特的优势；眼科开展了白内障超声乳化、青光眼手术、近视矫正等项目；口腔科提供牙齿正畸、修复、种植等全方位的口腔治疗服务；皮肤科在皮肤疾病的诊断和治疗上经验丰富，开展了激光美容等特色项目；中医科则以中医特色疗法治疗各种疾病，如针灸、推拿、中药调理等。</p>
            </el-tab-pane>
            <el-tab-pane label="专家团队" name="experts">
              <p>医院汇聚了一大批国内知名的专家和学者，他们是医院发展的核心力量，为患者的健康保驾护航。</p>
              <p><strong>心血管内科专家 [专家姓名 1]</strong>：从事心血管疾病临床诊治工作 [X] 年，在冠心病、心律失常等疾病的诊治方面有着深厚的造诣。他多次参与国内外学术交流活动，将国际先进的治疗理念引入临床实践，成功救治了众多危重症患者。</p>
              <p><strong>骨科专家 [专家姓名 2]</strong>：擅长各类骨科疾病的诊断和治疗，尤其在关节置换和脊柱手术方面经验丰富。他带领团队开展了多项新技术、新项目，为众多患者解除了病痛，恢复了正常生活。</p>
              <p><strong>妇产科专家 [专家姓名 3]</strong>：在妇产科领域拥有丰富的临床经验，熟练掌握各种妇产科手术技术。她致力于孕产妇保健和新生儿救治工作，为无数家庭带来了新生命的喜悦。</p>
              <p>此外，医院还有各个科室的众多专家，他们以精湛的医术、高尚的医德，赢得了患者的广泛赞誉和尊重。</p>
            </el-tab-pane>
          </el-tabs>
          <el-button @click="toggleExpand" size="mini" type="primary">收起</el-button>
        </div>
      </el-card>
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        isExpanded: false,
        activeTab: 'info'
      };
    },
    methods: {
      toggleExpand() {
        this.isExpanded = !this.isExpanded;
      }
    }
  };
  </script>
  
  <style scoped>
  .hospital-card {
    /* 浅灰色背景 */
    background-color: #f0f0f0; 
    border: 1px solid #e0e0e0;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 20px;
  }
  
  .card-header-title {
    /* 加深加粗文字 */
    color: #222; 
    font-size: 24px;
    font-weight: 700; 
    text-align: center;
  }
  
  .brief-intro {
    color: #222;
    margin-bottom: 15px;
    font-size: 16px;
    font-weight: 600; 
  }
  
  .hospital-tabs {
    margin-top: 20px;
  }
  
  .el-button {
    background-color: #007BFF;
    color: white;
    border: none;
    border-radius: 4px;
  }
  
  .el-button:hover {
    background-color: #0056b3;
  }
  
  p {
    color: #222;
    line-height: 1.8;
    margin-bottom: 15px;
    font-weight: 600; 
  }
  
  strong {
    color: #222;
    font-weight: 700; 
  }
  
  .el-tabs__item {
    color: #222;
    font-weight: 600; 
  }
  
  .el-tabs__item.is-active {
    color: #222;
    font-weight: 700; 
  }
  
  .el-tabs__active-bar {
    background-color: #222;
  }
  </style>