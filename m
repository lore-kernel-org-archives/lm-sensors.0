From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] I2C: Fix some gcc 4.0 compile failures and warnings
Message-Id: <20050304230242.GA2408@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11099685961021@kroah.com> <4228E74F.9070706@pacbell.net>
In-Reply-To: <4228E74F.9070706@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mickey Stein <yekkim@pacbell.net>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com

On Fri, Mar 04, 2005 at 02:55:11PM -0800, Mickey Stein wrote:
> I was just scanning this email and it looks like you possibly grabbed 
> the first of my patches with a typo because this last little bit I 
> corrected in a prior email to you.   It  got into the  *mm* tree  ok.  
> So I'm not sure where this took a wrong turn again.

You missed the follow-on patch that fixed this up :)

thanks,

greg k-h
