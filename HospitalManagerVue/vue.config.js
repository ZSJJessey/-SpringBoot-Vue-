/*
 * @Description: 
 * @Author: Rabbiter
 * @Date: 2023-01-14 20:02:29
 */
module.exports = {
    lintOnSave: false, // 关闭eslint校验
    devServer: {
        host: "0.0.0.0",
        port: 9282,
        https: false

    }
}
//设置代理解决跨域问题