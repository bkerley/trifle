#
#  BrowserWindowController.rb
#  Trifle
#
#  Created by Bryce Kerley on 3/1/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

class BrowserWindowController < OSX::NSWindowController
	ib_outlet :addressBar, :webView, :statusBar
	ib_action :addressEntered
	
	def awakeFromNib()
		this_bundle = OSX::NSBundle::bundleForClass self
		home_page = this_bundle.pathForResource_ofType_ 'home', 'html'
		
		@webView.setApplicationNameForUserAgent_("Trifle/http://trifle.qlnk.net/")
		@webView.setFrameLoadDelegate_ self
		
		@webView.setMainFrameURL "file://#{home_page}"
	end
	
	def addressEntered(sender)
		user_address = sender.stringValue.to_s
		fixed_up_address = fixup_address user_address
		@webView.setMainFrameURL fixed_up_address
	end
	
	def webView_didReceiveTitle_forFrame(sender, title, frame)
		return unless frame == sender.mainFrame
		sender.window.setTitle title.to_s
	end
	
	def webView_didReceiveIcon_forFrame(sender, image, frame)
		
	end
	
	private
	def fixup_address(address)
		return address if address =~ /^https?/
		return "http://#{address}"
	end
end
