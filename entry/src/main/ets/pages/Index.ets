let AlignRus:Record<string,Record<string,string|VerticalAlign|HorizontalAlign>> = {
  'top': { 'anchor': '__container__', 'align': VerticalAlign.Top },
  'left': { 'anchor': '__container__', 'align': HorizontalAlign.Start }
}
let AlignRue:Record<string,Record<string,string|VerticalAlign|HorizontalAlign>> = {
  'bottom': { 'anchor': '__container__', 'align': VerticalAlign.Bottom },
  'right': { 'anchor': '__container__', 'align': HorizontalAlign.End }
}

@Entry
@Component
struct Index {
  @State message: string = 'Hello World'
  @State currentIndex:number = 0
  @State currentInnerIndex:number = 0

  @Builder tabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
  }

  @Builder tabInnerBuilder(title: string, targetIndex: number) {
    Row() {
      Button(title, { type: ButtonType.Normal, stateEffect: true })
        .width(100)
        .height(40)
        .borderRadius(8)
        .fontColor(this.currentInnerIndex === targetIndex ? '#fff' : '#6B6B6B')
        .backgroundColor(this.currentInnerIndex === targetIndex ? '#689932' : '')
    }
    .padding(10)
    .borderRadius({
      topLeft: targetIndex ? 0 : 12,
      topRight: targetIndex ? 12 : 0,
      bottomLeft: targetIndex ? 0 : 12,
      bottomRight: targetIndex ? 12 : 0
    })
    .backgroundColor('#fff')
  }

  build() {
    Row() {
      Column() {
        Tabs({ barPosition: BarPosition.End }) {
          TabContent() {
            Column(){
              Tabs({ barPosition: BarPosition.Start }) {
                TabContent() {
                  Column(){
                    Text('Today====')
                    RelativeContainer() {
                      Text('2024/07/10 周三')
                        .width('50%')
                        .height(40)
                        .backgroundColor('#ffc3f6aa')
                        .alignRules(AlignRus)
                        .offset({
                          x:-10,
                          y:0
                        })
                        .id("date")
                      Button('button')
                        .width('30%')
                        .height('30%')
                        .backgroundColor('#ff8ff3eb')
                        .fontColor('#000')
                        .alignRules(AlignRue)
                        .offset({
                          x:-20,
                          y:0
                        })
                        .id("add")
                    }.width('88%').height('60%').backgroundColor('#fff880')
                  }
                  .width('100%')
                  .height('100%')
                }
                .tabBar(this.tabInnerBuilder('Today', 0))
                TabContent() {
                  Column(){
                    Text('Week====')
                  }
                  .width('100%')
                  .height('100%')
                }
                .tabBar(this.tabInnerBuilder('Week', 1))
              }
              .margin({
                top: '7%'
              })
              .barWidth(200)
              .onChange((index: number) => {
                this.currentInnerIndex = index
              })
            }
            .width('100%')
            .height('100%')
            .backgroundColor('#fff8e0')
          }
          .tabBar(this.tabBuilder('待办', 0, $r('app.media.todo_selected'), $r('app.media.todo')))
          TabContent() {
            Column(){
              Text('番茄钟内容')
            }
            .width('100%')
            .height('100%')
            .backgroundColor(Color.Red)
          }
          .tabBar(this.tabBuilder('番茄钟', 1, $r('app.media.tomato_selected'), $r('app.media.tomato')))
          TabContent() {
            Column(){
              Text('我的内容')
            }
            .width('100%')
            .height('100%')
            .backgroundColor('#1698CE')
          }
          .tabBar(this.tabBuilder('我的', 2, $r('app.media.my_selected'), $r('app.media.my')))
        }
        .onChange((index: number) => {
          this.currentIndex = index
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}