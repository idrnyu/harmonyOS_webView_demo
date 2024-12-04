// @Entry
// @Component
// struct Index {
//   @State message: string = 'Hello World 123';
//
//   build() {
//     RelativeContainer() {
//       Text(this.message)
//         .id('HelloWorld')
//         .fontSize(50)
//         .fontWeight(FontWeight.Bold)
//         .alignRules({
//           center: { anchor: '__container__', align: VerticalAlign.Center },
//           middle: { anchor: '__container__', align: HorizontalAlign.Center }
//         })
//     }
//     .height('100%')
//     .width('100%')
//   }
// }


// 需要开启 requestPermissions     ohos.permission.INTERNET  网络权限
import webview from '@ohos.web.webview';

class bridgeClass {
  constructor() {
  }
  getAccessToken(): string {
    // 返回给web端的内容
    return 'ArkTS Hello World!';
  }
}

@Entry
@Component
struct WebTest {

  // Web控制器
  private webController: WebviewController = new webview.WebviewController();

  // 声明需要注册的对象
  // @State bridgeObj: bridgeClass = new bridgeClass();

  build() {
    Column({ space: 10 }) {

      Text("报告详情")
        .fontSize(25)
        .fontColor("#acacbc")
        .backgroundColor(Color.Pink)

      Web({
        src: "http://192.168.12.137:10086/", // 需要加载的网址
        controller: this.webController
      })
        // 将对象注入到web端
        .javaScriptProxy({
          object: new bridgeClass(),
          name: "bridge", // 注入window下的名称
          methodList: ["getAccessToken"], // window.bridge 下注入的方法列表
          controller: this.webController
        })
        // 允许web拥有存储权限
        .domStorageAccess(true)
        .width("100%")
        .height("100%")
    }
    .width('100%')
    .height("100%")
    // .padding(10)
  }
}