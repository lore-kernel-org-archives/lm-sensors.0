From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Ticket 1319 - lm_sensors-2.8.0-cvs linux-2.4.20-smp-i386
Message-Id: <20030710110758.56feb15c.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710085158.42e68c95.zdavatz@ywesee.com>
In-Reply-To: <20030710085158.42e68c95.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 10 Jul 2003 10:46:23 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> You should have /usr/local/include/linux/i2c.h. That's where i2c (that
> you got from CVS) installs them. So, if you don't have them, either you
> did *not* run "make install" for i2c, or you tweaked the Makefile and
> did not tell us...

I done make install and my include dir is 

LINUX_INCLUDE_DIR := /usr/local/include/linux

I just done make install again and I find no i2c in LINUX_INCLUDE_DIR := /usr/local/include/linux

What I get there is:
i2c-algo-bit.h  i2c-algo-biths.h  i2c-algo-pcf.h  i2c-dev.h

Why whould that be?

Thanks for your Feedback.

Zeno
