#
#  BrowserWindowController.rb
#  Trifle
#
#  Created by Bryce Kerley on 3/1/09.
#  Copyright (c) 2009 __MyCompanyName__. All rights reserved.
#

require 'osx/cocoa'

class BrowserWindowController < OSX::NSWindowController
	ib_outlet :addressBar, :webView
	ib_action :addressEntered
	
	def awakeFromNib()
		@webView.setApplicationNameForUserAgent_("Trifle/http://trifle.qlnk.net/")
	end
	
	def addressEntered(sender)
		user_address = sender.stringValue.to_s
		fixed_up_address = fixup_address user_address
		@webView.setMainFrameURL fixed_up_address
	end
	
	private
	def fixup_address(address)
		return address if address =~ /^https?/
		return "http://#{address}"
	end
end
