class MapViewController < UIViewController
  def loadView
    scroll_view = UIScrollView.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    scroll_view.delegate = self
    scroll_view.clipsToBounds = true
    scroll_view.scrollEnabled = true
    scroll_view.pagingEnabled = false
    scroll_view.maximumZoomScale = 4.0
    scroll_view.minimumZoomScale = 0.5
    scroll_view.bounces = true
    scroll_view.userInteractionEnabled = true
    scroll_view.setContentSize([map_image_view.frame.size.width, map_image_view.frame.size.height])
    scroll_view.backgroundColor = UIColor.whiteColor
    
    scroll_view.addSubview(map_image_view)
    
    self.view = scroll_view
    
    manager = OSCManager.alloc.init
    manager.setDelegate(self)
    @osc = manager.createNewOutputToAddress('10.0.1.7', atPort:12000)
  end
  
  def map_image_view
    @map_image_view ||= begin
      image_view = UIImageView.alloc.init
      image_view.image = UIImage.imageNamed("map-small.jpg")
      image_view.frame = CGRectMake(0, 0, image_view.image.size.width, image_view.image.size.height)
      image_view.userInteractionEnabled = true
      image_view
    end
  end
  
  def scrollViewDidScroll(scrollView)
    msg = OSCMessage.createWithAddress('/position')
    msg.addFloat((scrollView.contentOffset.x + scrollView.frame.size.width/2) / scrollView.contentSize.width)
    msg.addFloat((scrollView.contentOffset.y + scrollView.frame.size.width/2) / scrollView.contentSize.height)
    @osc.sendThisMessage(msg)
    true
  end
end