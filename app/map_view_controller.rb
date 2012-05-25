class MapViewController < UIViewController
  def loadView
    initOSC()
    
    split_view = UIView.alloc.initWithFrame(UIScreen.mainScreen.applicationFrame)
    split_view.backgroundColor = UIColor.whiteColor
    split_view.addSubview(map_scroll_view)
    split_view.addSubview(info_panel_view)
    
    self.view = split_view
  end
  
  def initOSC
    manager = OSCManager.alloc.init
    manager.setDelegate(self)
    @osc = manager.createNewOutputToAddress('10.0.1.7', atPort:12000)
  end
  
  def map_scroll_view
    @map_scroll_view ||= begin
      map_scroll_view = TiledScrollView.alloc.initWithFrame([[0,0],[768,768]])
      map_scroll_view.delegate = self
      map_scroll_view.clipsToBounds = true
      map_scroll_view.scrollEnabled = true
      map_scroll_view.pagingEnabled = false
      map_scroll_view.maximumZoomScale = 2.0
      map_scroll_view.minimumZoomScale = 0.5
      map_scroll_view.bounces = true
      map_scroll_view.userInteractionEnabled = true
      map_scroll_view.setContentSize([map_image_view.frame.size.width, map_image_view.frame.size.height])
      map_scroll_view.backgroundColor = UIColor.whiteColor
      map_scroll_view.setZoomScale(1.0)
      map_scroll_view.addSubview(map_image_view)
      map_scroll_view
    end
  end
  
  def map_image_view
    @map_image_view ||= begin
      image_view = UIImageView.alloc.init
      image_view.image = UIImage.imageNamed('map-small.jpg')
      image_view.frame = CGRectMake(0, 0, image_view.image.size.width, image_view.image.size.height)
      image_view.userInteractionEnabled = true
      image_view
    end
  end
  
  def info_panel_view
    @info_panel_view ||= begin
      info_panel_view = UIScrollView.alloc.initWithFrame([[768,0],[256,768]])
      info_panel_view.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed('noise.png'))
      info_panel_view.layer.masksToBounds = false
      info_panel_view.layer.shadowOffset = [-3,0]
      info_panel_view.layer.shadowRadius = 3
      info_panel_view.layer.shadowOpacity = 0.2
      @text_view = UITextView.alloc.initWithFrame([[10,10],[236,748]])
      @text_view.editable = false
      @text_view.font = UIFont.systemFontOfSize(14.0)
      @text_view.textColor = UIColor.colorWithRed(0, green:0, blue:0, alpha: 0.6)
      @text_view.backgroundColor = UIColor.clearColor
      info_panel_view.addSubview(@text_view)
      info_panel_view
    end
  end
  
  def scrollViewDidScroll(scrollView)
    msg = OSCMessage.createWithAddress('/position')
    msg.addFloat((scrollView.contentOffset.x + scrollView.frame.size.width/2) / scrollView.contentSize.width)
    msg.addFloat((scrollView.contentOffset.y + scrollView.frame.size.width/2) / scrollView.contentSize.height)
    @osc.sendThisMessage(msg)
    
    if scrollView.contentOffset.x > 400
      @text_view.text = 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
    else
      @text_view.text = 'Die Reiher der Insel Diomedia ähneln in Gestalt und Größe dem Bläßhuhn, sind schwanenweiß und haben harte und lange Schnäbel. Von Apulien aus fliegen sie zur Insel Diomedia und halten sich an den Klippen und Felsen auf. Sie machen Unterschiede zwischen Einheimischen und Neuankömmlingen. Wenn es ein Grieche ist, akzeptieren sie ihn schneller und behandeln ihn gut; ist es ein Fremder, so gehen sie mit Schnabelhieben auf ihn los und verwunden ihn und stoßen dabei klagende Rufe aus, die entweder ihrer eigenen Verwandlung oder dem Tod ihres Königs gelten. Denn so wurde Diomedes von den Illyrern umgebracht.'
    end
    
    true
  end
  
  def viewForZoomingInScrollView(scrollView)
    return map_image_view
  end
  
  def shouldAutorotateToInterfaceOrientation(orientation)
    return [UIInterfaceOrientationLandscapeLeft, UIInterfaceOrientationLandscapeRight].include?(orientation)
  end
end