From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: [PATCH: 2.6.11-rc5] i2c chips: ds1337 RTC driver
Message-Id: <20050302165943.GA2393@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42235171.80500@katalix.com> <20050301075413.GC3791@kroah.com> <4224C0D4.2060303@katalix.com>
In-Reply-To: <4224C0D4.2060303@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Chapman <jchapman@katalix.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 07:21:56PM +0000, James Chapman wrote:
> Revised ds1337 chip driver patch.
> 
> Signed-off-by: James Chapman <jchapman@katalix.com>
> 
> - change all driver log messages to use dev_dbg() or dev_err()
> - remove debug module parameter

Hm, doesn't seem to apply at all:

drivers/i2c/chips/Kconfig 1.78: 418 lines
patching file drivers/i2c/chips/Kconfig
drivers/i2c/chips/Makefile 1.61: 46 lines
patching file drivers/i2c/chips/Makefile
patching file drivers/i2c/chips/ds1337.c
patch: **** malformed patch at line 420: 


Care to respin it again?

thanks,

greg k-h
