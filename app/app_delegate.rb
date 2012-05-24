class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    application.setStatusBarHidden(true, withAnimation:UIStatusBarAnimationSlide)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = MapViewController.alloc.init
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible()
    return true
  end
end
