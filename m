From: derek.cheung@sympatico.ca (Derek Cheung)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: [PATCH] kernel 2.6.11.6 -  I2C adaptor for ColdFire 5282 CPU
Message-Id: <001d01c5408f$18238850$1501a8c0@Mainframe>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20050411200318.GA25550@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Greg KH' <greg@kroah.com>, "'Randy.Dunlap'" <rddunlap@osdl.org>, 'Andrew Morton' <akpm@osdl.org>
Cc: Linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

OK, hope this patch can satisfy everyone :-)

The following is the diffstat of the enclosed patch file:

 drivers/i2c/busses/Kconfig       |   10 
 drivers/i2c/busses/Makefile      |    1 
 drivers/i2c/busses/i2c-mcf5282.c |  414
+++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-mcf5282.h |   46 ++++
 include/asm-m68knommu/m528xsim.h |   42 +++
 5 files changed, 513 insertions(+)

I did:

a) remove all trailing spaces in the files
b) re-align the switch statement
c) change a return statement
d) change some white space intents to TABs
e) insert a break for the I2C_SMBUS_PROC_CALL, thanks for spotting it
f) fix the mcf5282lite wording in Kconfig

I did not:

g) use the ioremap. This is because Coldfire is a CPU without MMU and
there is no difference between virtual and physical memory. In fact, the
ioremap routine in the m68knommu is simply a stub routine that returns
the input address argument for compatibility reason. Also, all other
Coldfire CPU include files such as the m5307sim.h uses the volatile
declaration method. 
So, I hope this is acceptable to the Linux kernel maintainers

Please let me know if there is any question.

Regards
Derek


-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: April 11, 2005 4:03 PM
To: Derek Cheung
Cc: 'Randy.Dunlap'; 'Andrew Morton'; Linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel 2.6.11.6 - I2C adaptor for ColdFire 5282 CPU

On Sun, Apr 10, 2005 at 12:47:42PM -0400, Derek Cheung wrote:
> Enclosed please find the updated patch that incorporates changes for
all
> the comments I received.

You did not cc: the sensors mailing list, nor fix all of the coding
style issues.

> The volatile declaration in the m528xsim.h is needed because the
> declaration refers to the ColdFire 5282 register mapping.

Shouldn't you be calling ioremap, and not directly accessing a specific
register location through a pointer?  That's how all other arches do
this.

thanks,

greg k-h
-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux_patch_submit3
Type: application/octet-stream
Size: 18572 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050413/37f5b0fa/linux_patch_submit3.obj
