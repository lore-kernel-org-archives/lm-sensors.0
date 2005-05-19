From: miguel.valero@axxessit.no (miguel.valero@axxessit.no)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: MPC8260 I2C
Message-Id: <OFE0A40B56.8334E6F8-ONC1256F4E.002B5EF3@axxessit.no>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tom Rini <trini@kernel.crashing.org>
Cc: sensors@stimpy.netroedge.com, linuxppc-embedded@ozlabs.org

Tom,
thanks for your answer.
Yes, I am interested on having the MPC826x CPM i2c algorithm in the 
kernel.

Find the i2c-8260 patch enclosed.
I took Denx's 2.4.x based implementation and ported it to 2.6.7 and later 
to 2.6.9.

In addition, I have patched the i2c-dev.h as recommended by the lmsensors 
project in order to allow user space to perform ioctrl on the i2c device.

Regards.
Miguel

PS. I also have a patch for linux-2.6.7, if someone out there is 
interested








Tom Rini <trini@kernel.crashing.org>
15.11.04 19:49

 
        To:     miguel.valero@axxessit.no
        cc: 
        Subject:        Re: MPC8260 I2C


On Thu, Nov 11, 2004 at 05:20:11PM +0100, miguel.valero@axxessit.no wrote:

> Tom,
> you remember you asked me to see if I could rewrite the mpc8260 i2c 
driver 
> in an "i2c-mpc like" manner, by making use either of ocp or of 
> platform_devices setup.
> 
> I do not really know what you mean with "platform_devices setup", but I 
> have taken a look to the ocp stuff, and I realised that it is too riksy 
> for me to do the porting. I would most likely break the thing and spend 
a 
> lot of time debugging.

OK.

> The question is whether the community would accept the current 
> implementation with a specific bus driver, called PM826, and a specific 
> i2c algorithm, called i2c-algo-8260.
> 
> In the patch I have made, these 8260 bus and algo options are 
configurable 
> in drivers/i2c/busses/Kconfig and drivers/i2c/algos/Kconfig.

Probably, but the OCP or platform_device work is something that needs to
get at some point.  I'll take a look, if you're willing to push the
driver with upstream I2C folks.

[snip]
> My question to you is then: shall I send you (and the linuxppc-embedded 
> list) the patch ? Maybe someone else, more experienced than me in kernel 

> kacking, can do the rewritting faster at less risk, if it is considered 
> necessary ?

The I2C list is at sensors@stimpy.netroedge.com, and should probably be
CC'd as well.

Thanks again.

-- 
Tom Rini
http://gate.crashing.org/~trini/


-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-2.6.9-i2c-8260.patch
Type: application/octet-stream
Size: 45225 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041116/fca75078/linux-2.6.9-i2c-8260.obj
