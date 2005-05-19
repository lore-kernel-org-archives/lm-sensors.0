From: kevin@labsysgrp.com (Kevin P. Fleming)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Patch for lm_sensors-2.6.3 Makefile to support user specified CFLAGS and CPPFLAGS
Message-Id: <007d01c1ed3c$b2c0b940$6caaa8c0@KPFW2K>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The attached patch allows the user to add CFLAGS and CPPFLAGS entries (via
the environment or the make command line) and have them actually get used
compiling the lm_sensors objects... I used this because I wanted to try
other optimization settings without massaging the Makefile every time.
Enjoy!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-Makefile.patch
Type: application/octet-stream
Size: 3781 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020426/43924d2e/lm_sensors-Makefile.obj
