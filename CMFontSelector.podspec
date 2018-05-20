Pod::Spec.new do |s|
  s.name             =  'CMFontSelector'
  s.version          =  '1.0.0'
  s.license      = {
    :type => 'Private',
    :text => <<-LICENSE
                Copyright (c) 2018 Davion Knight. All rights reserved.
    LICENSE
  }
  s.summary          =  'Font selector view controller.'
  s.homepage		 =  'https://github.com/dkdavionknight/CMFontSelector'
  s.author           =  { 'Davion Knight' => 'dkdavionknight@gmail.com' }
  s.source           =  { :git => 'https://github.com/dkdavionknight/CMFontSelector.git', :tag => s.version }
  s.platform         =  :ios
  s.source_files     =  'CMFontSelector/*.{h,m}'
  s.resources        =  'CMFontSelector/*.xib'
  s.requires_arc     =  true
end