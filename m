From: spstarr@sh0n.net (Shawn Starr)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: lm_sensors - CVS and 2.5.60 (which tag?)
Message-Id: <200302110036.09647.spstarr@sh0n.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

What is the correct tag for lm_sensors2? head is fine? the mkpatch perl script 
is broken because of the changes of later 2.5 kernel builds.

Also, when I do manually add my sensor chip the i2c initializes but the kernel 
panics on i2c_register of the w83781d (during the w83781d 's init) ;-(

I'm sure if I hack on the code I could get it to work tomorrow.

Shawn.
