From: david_knierim@earthlink.net (David Knierim)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: lm93 support
Message-Id: <41DD58E2.4010003@earthlink.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <41DBED37.7020109@earthlink.net>
In-Reply-To: <41DBED37.7020109@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
    I've looked into this a bit more and generated a simple patch to 
sensors-detect.   I've also included a simple patch to lm93.c to 
increase the wait between retries if there is a timeout.

Thank you,
    David

David Knierim wrote:
> I was just looking around the sensors web site and noticed that the lm93 
> is not on the list of supported chips on the web page:
> 
> http://www2.lm-sensors.nu/~lm78/supported.html
> 
> It's only supported on kernel version 2.4, but it does work very well.
> 
> I compiled up lm_sensors 2.9.0 and i2c 2.9.1 and ran sensors-detect. The 
> entry for the lm93 looked like this:
> Probing for 'National Semiconductor LM93' ... Success!
>     (confidence 5, driver 'to-be-written')
> 
> Thanks once again for looking into this,
> David
> 
> 

-------------- next part --------------
--- lm_sensors-2.8.8.CVS_20041015/kernel/chips/lm93.c.orig	2004-10-27 10:39:55.000000000 -0400
+++ lm_sensors-2.8.8.CVS_20041015/kernel/chips/lm93.c	2004-10-27 10:57:10.000000000 -0400
@@ -376,7 +376,7 @@
 		} else {
 			printk(KERN_WARNING "lm93.o: read byte data failed, "
 				"address 0x%02x.\n", reg);
-			mdelay(i);
+			mdelay(i + 3);
 		}
 
 	}
@@ -411,7 +411,7 @@
 		} else {
 			printk(KERN_WARNING "lm93.o: read word data failed, "
 				"address 0x%02x.\n", reg);
-			mdelay(i);
+			mdelay(i + 3);
 		}
 
 	}
@@ -454,7 +454,7 @@
 			printk(KERN_WARNING "lm93.o: block read data failed, "
 				"command 0x%02x.\n", 
 				lm93_block_read_cmds[fbn].cmd);
-			mdelay(1);
+			mdelay(i + 3);
 		}
 	}
 
-------------- next part --------------
--- lm_sensors-2.9.0/prog/detect/sensors-detect.orig	2005-01-05 18:22:57.000000000 -0500
+++ lm_sensors-2.9.0/prog/detect/sensors-detect	2005-01-05 18:23:27.000000000 -0500
@@ -972,7 +972,7 @@
      },
      {
        name => "National Semiconductor LM93",
-       driver => "to-be-written",
+       driver => "lm93",
        i2c_addrs => [0x2c..0x2e],
        i2c_detect => sub { lm93_detect @_ },
      },
