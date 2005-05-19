From: cminyard@mvista.com (Corey Minyard)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: [PATCH] I2C Part 1 - Remove some redundancy from the i2c-core.c file
Message-Id: <42418B36.5030407@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>, Sensors <sensors@stimpy.netroedge.com>

This is a series of patches to add a non-blocking interface to the I2C 
driver.  Hopefully it is broken into small enough functional changes.  
I'm not posting the whole series right now, just the first few.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c_remove_redundant_check.diff
Type: text/x-patch
Size: 3065 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050323/a15af38d/i2c_remove_redundant_check.bin
