From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: [PATCH][2.6]
Message-Id: <20040505231353.GA30862@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <409923F7.7050101@convergence.de>
In-Reply-To: <409923F7.7050101@convergence.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Hunold <hunold@convergence.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Jean Delvare <khali@linux-fr.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>, sensors@stimpy.netroedge.com

On Wed, May 05, 2004 at 07:27:19PM +0200, Michael Hunold wrote:
> The attached patch does the first step:
> - add .class member to struct i2c_device
> - remove unused .flags member from struct i2c_adapter
> - rename I2C_ADAP_CLASS_xxx to I2C_CLASS_xxx (to be used both for 
> drivers and adapters)
> - add new I2C_CLASS_ALL and I2C_CLASS_SOUND classes
> - follow these changes in the existing drivers with copy & paste
> 
> I think these things are unquestionable and don't make any functional 
> changes to the code, so this should be applied to 2.6 now.
> 
> From that point on, we can discuss how to proceed.
> 
> Comments?

Looks good, I've applied this to my trees, and it will show up in the
next -mm release.

thanks,

greg k-h
