From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: I2C on 2.6
Message-Id: <20040209212221.GA11993@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
In-Reply-To: <20040206032153.63685.qmail@web14917.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 05, 2004 at 07:21:53PM -0800, Jon Smirl wrote:
> On kernel 2.6 I2C creates /sys/class/i2c-adapter. This directory contains all of
> my I2C busses. Now when I modprobe i2c-dev in it makes /sys/class/i2c-dev which
> also contains all of my I2C buses with the addition of a 'dev' file. Udev then
> picks up on this 'dev' file and makes the devices. Do we really need two I2C
> /sys/class entries? Could these be combined?

Those are two completly separate things.  So no, they can't be combined
very easily :)

thanks,

greg k-h
