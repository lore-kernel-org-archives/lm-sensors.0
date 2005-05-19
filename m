From: ac9410@attbi.com (Albert Cranford)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: [PATCH] More i2c driver changes for 2.5.66
Message-Id: <3E8BD2D9.8050002@attbi.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1049328958830@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

I read the thread concerning the removal of proc.c & proc.h
but hope that this does not go to Linus until the interface
between i2c & sensors to application is somewhat defined.

At the moment we have a sysctl API used by sensors, video and
other i2c kernel applications that is working.
Our desire to switch the sensors to sysfs interface should not
break other applications.  At least until we have a model/api
to propose to these other drivers.

In my personal home systems I use it87 driver and have been
somewhat successful in switching to sysfs.  A big blocking
point is there is no application to read/set/monitor the
driver, so it is basically unverified.  I would hate to
put other i2c applications in the same boat.
Your thoughts?
Albert

Greg KH wrote:
> ChangeSet 1.977.29.8, 2003/04/02 11:45:21-08:00, greg@kroah.com
> 
> i2c: remove proc and sysctl code from i2c-proc as it is no longer used.
>
