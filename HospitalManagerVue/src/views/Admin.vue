<template>
  <el-container>
    <!-- 头部 -->
    <el-header>
      <div class="words">
        <span @click="menuClick('adminLayout')">
          <i class="iconfont icon-r-love" style="font-size: 26px">
            医院管理系统</i>
        </span>
      </div>
      <div class="words">
        <span>欢迎您，<b>{{ userName }}</b>&nbsp;管理员&nbsp;</span>
        <el-badge :value="msgCount" :max="99" class="item">
          <div style="font-size:30px;background-color:transparent">
            <i class="el-icon-message" @click="openMessage"></i>
          </div>
        </el-badge>

        <el-button @click="logout" type="warning" round>
          <i class="iconfont icon-r-user3" style="font-size: 15px;">&nbsp;退出&nbsp;</i>
        </el-button>
      </div>
    </el-header>
    <el-container>
      <!-- 侧边栏 -->
      <el-aside width="200px">
        <!-- 导航菜单 -->
        <el-menu background-color="#02203d" text-color="white" active-text-color="white" :default-active="activePath">
          <el-menu-item index="adminLayout" @click="menuClick('adminLayout')" style="font-size: 20px">
            <i class="iconfont icon-r-home" style="font-size: 26px">
            </i>
            首页
          </el-menu-item>
          <el-menu-item index="doctorList" @click="menuClick('doctorList')" style="font-size: 20px">
            <i class="iconfont icon-r-user1" style="font-size: 26px">
            </i>
            医生信息管理
          </el-menu-item>
          <el-menu-item index="patientList" @click="menuClick('patientList')" style="font-size: 20px">
            <i class="iconfont icon-r-user2" style="font-size: 26px">
            </i>
            患者信息管理
          </el-menu-item>
          <el-menu-item index="orderList" @click="menuClick('orderList')" style="font-size: 20px">
            <i class="iconfont icon-r-paper" style="font-size: 26px">
            </i>
            挂号信息管理
          </el-menu-item>
          <el-menu-item index="drugList" @click="menuClick('drugList')" style="font-size: 20px">
            <i class="iconfont icon-r-love" style="font-size: 26px">
            </i>
            药物信息管理
          </el-menu-item>
          <el-menu-item index="checkList" @click="menuClick('checkList')" style="font-size: 20px">
            <i class="iconfont icon-r-edit" style="font-size: 26px">
            </i>
            检查项目管理
          </el-menu-item>
          <el-menu-item index="bedList" @click="menuClick('bedList')" style="font-size: 20px">
            <i class="iconfont icon-r-list" style="font-size: 26px">
            </i>
            病床信息管理
          </el-menu-item>
          <el-menu-item index="arrangeIndex" @click="menuClick('arrangeIndex')" style="font-size: 20px">
            <i class="iconfont icon-r-shield" style="font-size: 26px">
            </i>
            排班信息管理
          </el-menu-item>

        </el-menu>
      </el-aside>
      <el-main>
        <!-- 子路由入口 -->
        <router-view>
          <div>你好吗</div>
        </router-view>
      </el-main>
    </el-container>
  </el-container>
</template>
<script>
import jwtDecode from "jwt-decode";
import { toLoad } from "@/utils/initialize.js";
import request from "@/utils/request.js";
import {
  getToken,
  clearToken,
  getActivePath,
  setActivePath,
} from "@/utils/storage.js";
import { EventBus } from '../eventBus.js';
export default {
  name: "Admin",
  data() {
    return {
      userName: "",
      activePath: "",
      msgCount: 0,
      messageList: [],
      newMessage: ''
    };
  },
  methods: {

    openMessage() {
      if (this.msgCount > 0) {

        var message = "<table border=1 cellspacing='0' style='border: 1px solid #C1DAD7;'><thead><th style='background: #CAE8EA no-repeat;text-align: center;'>序号</th><th style='background: #CAE8EA no-repeat;text-align: center;'>消息内容</th><th style='background: #CAE8EA no-repeat;text-align: center;'>时间</th></tr> </thead><tbody>"

        for (let index = 0; index < this.messageList.length; index++) {
          const element = this.messageList[index];
          message += "<tr><td style='text-align: center'>" + (index + 1) + "</td><td style='text-align: center'>" + element.message + "</td><td style='text-align: center'>" + element.send_time + "</td></tr>"
        }
        message = message + '</tbody></table>'

        this.$alert(`<div style="width:1000px; height:100%">` + message + `</div>`, {
          dangerouslyUseHTMLString: true,
          customClass: 'msgbox'
        });

        this.updateMessage();
      }
    },

    updateMessage() {
      request
        .get("admin/updateMessage", {
          params: {
            hasRead: 1
          }
        })
        .then((res) => {
          if (res.data.status != 200)
            return this.$message.error("获取数据失败");
          else {
            this.messageList = res.data.data
            this.msgCount = res.data.data.length;
          }

        });
    },
    getMessages() {
      request
        .get("admin/getMessages")
        .then((res) => {
          if (res.data.status != 200)
            return this.$message.error("获取数据失败");
          else {
            this.messageList = res.data.data
            this.msgCount = res.data.data.length;
          }

        });

    },
    //token解码
    tokenDecode(token) {
      if (token !== null) return jwtDecode(token);
    },
    //导航栏点击事件
    menuClick(path) {
      this.activePath = path;
      setActivePath(path);
      if (this.$route.path !== "/" + path) this.$router.push(path);
      console.log(path);
    },
    //退出登录
    logout() {
      this.$confirm("此操作将退出登录, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          clearToken();
          this.$message({
            type: "success",
            message: "退出登录成功!",
          });
          this.$router.push("login");
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消",
          });
        });
    },
  },
  mounted() {
    // 设置定时任务
    // this.intervalId = setInterval(() => {
    //   // 这里是你想要定期执行的代码
    //   this.getMessages()
    // }, 1000); // 
    toLoad();

  },
  created() {
    EventBus.$on('message-from-a', (message) => {
      console.log(message);
    });
    this.getMessages()
    //  获取激活路径
    this.activePath = getActivePath();
    // 解码token
    this.userName = this.tokenDecode(getToken()).aName;

  },
  // 注意在组件销毁时移除事件监听，避免内存泄漏
  beforeDestroy() {
    clearInterval(this.intervalId);
    EventBus.$off('message-from-a');
  }
};
</script>
<style lang="scss">
.title {
  cursor: pointer;
}

.el-header {
  background-color: #02203d;
  display: flex;
  justify-content: space-between;
  align-items: center;

  .words {
    text-align: center;

    span {
      color: white;
    }
  }

  border-bottom: 1px solid lightgrey;
}

.custom-alert-width {
  width: 500px;
  /* 你想要的宽度 */
}

.el-container {
  height: 100%;
  background-color: "#66b1ff";
}

.el-aside {
  height: 100%;
  background-color: #02203d;
  border-right: 1px solid lightgrey;
}

.el-menu {
  border: 0;
}

.item {
  margin-top: 10px;
  margin-right: 40px;
}




.msgbox {
  width: 500px;
  overflow-y: auto;
  position: fixed;


}

.custom-button {
  background-color: #409eff;
  /* 按钮背景色 */
  border-color: #409eff;
  /* 按钮边框色 */
  color: white;
  /* 按钮文字颜色 */
}
</style>
