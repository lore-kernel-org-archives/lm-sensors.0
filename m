From: mgreer@mvista.com (Mark A. Greer)
Date: Mon, 27 Feb 2006 17:09:23 +0000
Subject: [lm-sensors] [PATCH 1/1] i2c: m41txx driver for ST i2c RTC chips
Message-Id: <20060227170923.GA26136@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060217011359.GA16247@mag.az.mvista.com>
In-Reply-To: <20060217011359.GA16247@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Sun, Feb 26, 2006 at 12:47:18PM +0100, Rudolf Marek wrote:
> Hello,
> 
> Please note that you will have to fix some files in ./arch/powerpc/configs/ and ./arch/ppc/configs/
> too.( they mention CONFIG_SENSORS_M41T00) And of course /arch/ppc/platforms/katana.c
> I think it will need the platform stuff so it can connect to this platform driver.

Yes, but that's a separate patch that doesn't go to lm-sensors.  See

http://lists.lm-sensors.org/pipermail/lm-sensors/2005-December/014727.html

to get an idea what that patch would look like.

> I'm not very sure what will happen when some users dont have this chip in their platform?

Then they will either not have it selected and it won't be an issue or it
will silently do nothing and it won't be an issue.

> Ideally they should just force the driver to specific addr. As far I can judge this cannot
> be done (I looked to _probe function) Maybe there can be some workaround so they can force
> the parameters somehow? Please can you throw some light on this?
> We will need certainly a Documentation/i2c/chips/m41txx to document how this issue can be solved.

I presume you mean the i2c addr.  If that's correct, then that address is
passed into the driver via platform_data.  Look at
include/linux/m41txx.h then search for 'i2c_addr' in the driver. 

> I tried to review the driver and seems OK to me.

Thanks for taking the time to look at it.

Mark

