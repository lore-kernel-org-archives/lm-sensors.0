From: haveblue@us.ibm.com (Dave Hansen)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: [PATCH] i2c-keywest.c: declare probe earlier
Message-Id: <1092186044.2813.66.camel@nighthawk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This is against 2.6.8-rc4-mm1, and is caused by the bk-pci.patch.

I got the following errors during a x86->ppc64 allyesconfig
cross-compile with gcc 3.3.3.  But, it should be a generic error. 

drivers/i2c/busses/i2c-keywest.c: In function `__check_probe':
drivers/i2c/busses/i2c-keywest.c:94: error: `probe' undeclared (first use in this function)
drivers/i2c/busses/i2c-keywest.c:94: error: (Each undeclared identifier is reported only once
drivers/i2c/busses/i2c-keywest.c:94: error: for each function it appears in.)
drivers/i2c/busses/i2c-keywest.c: At top level:
drivers/i2c/busses/i2c-keywest.c:94: error: `probe' undeclared here (not in a function)
drivers/i2c/busses/i2c-keywest.c:94: error: initializer element is not constant
drivers/i2c/busses/i2c-keywest.c:94: error: (near initialization for `__param_probe.arg')
drivers/i2c/busses/i2c-keywest.c:96: error: `probe' used prior to declaration

Attached patch makes it compile for me.  

-- Dave
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-wrongorder.patch
Type: text/x-patch
Size: 595 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040810/2c830c72/i2c-wrongorder.bin
