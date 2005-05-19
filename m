From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: [jori@mail.cs.uta.fi: Linux kernel 2.5.73 and /proc/bus/i2c]
Message-Id: <20030624161520.GA3786@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030624123835.GA4792@frodo.local>
In-Reply-To: <20030624123835.GA4792@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jun 24, 2003 at 02:38:35PM +0200, Frodo Looijaard wrote:
> ----- Forwarded message from Jori Mantysalo <jori@mail.cs.uta.fi> -----
> 
> From: Jori Mantysalo <jori@mail.cs.uta.fi>
> To: frodol@dds.nl
> Subject: Linux kernel 2.5.73 and /proc/bus/i2c
> X-Spam-Status: No, hits=2.7 required=5.0 tests=EXCUSE_3 version=2.20
> X-Spam-Level: **
> 
> I downloaded, compiled and installed kernel version 2.5.73. But where is
> /proc/bus/i2c ? There doesn't seem to be any configure switch to enable it
> - is it going to be removed from kernel?

It is gone.  Look for the sensor data in /sys instead.  And no, the
lmsensors library has not been updated to reflect this change yet.

I think I need to go add some wording to the 2.6 kernel documentation
about this...

thanks,

greg k-h
