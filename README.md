# CountDownView
The countdown view,Only need to pass in the start and end timestamps.

How To Use ？
/**
*   starTime:活动开始时间
*   endTime：活动结束时间
*   倒计时显示当前时间距开始或者结束的时间。
*//



  let view = CountDownView(view_X:"X坐标",view_Y:"Y坐标")
  view.setActiveTimePeriods(starTime:"开始时间",endTime:"结束时间")
  self.view.addSubviews(view)
  
