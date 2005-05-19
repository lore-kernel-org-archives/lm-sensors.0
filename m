From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: Kernel 2.6.0 and i2c-viapro posible Bug
Message-Id: <20040110124156.3b127c86.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401091955.55007.ivanovich@menta.net>
In-Reply-To: <200401091955.55007.ivanovich@menta.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ivanovich <ivanovich@menta.net>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com, Nicolas Nilles <nnilles@skycop.net>

> > I thinks that thgere is  probably a bug in I2c-viapro module,
> > cuz when i load i2c-viapro after loading w82781d, my computer  just
> > put very slow..., i try loading as modules in the kernel or built
> > in, in both cases i have the same problem.
> 
> I have this very same board CUV4X_E and the same problem too (present
> in 2.6.0 and before)
> The workaround i found is to not initialize the chip "modprobe w83781d
> init=0"
> 
> And answering some of your questions, yes, the slowdown is global, not
> only disk and it doesn't gets better if you unload the modules.
> 
> It's fixed in 2.6.1? going to download+compile and see if it works. 

Could be fixed, because limits initialization has been removed from the
w83781d driver. But since there is still some intialization stuff done,
the problem may still be there. Please try and report. The "init=0"
parameter is still there, so your workaround should still work.

If the problem is still present, I'd like you to do more tests. Edit the
driver (drivers/i2c/chips/w83781d.c), look for the "w83781d_init_client"
function. You'll find three blocks that are under a "init" conditional.
I'd like you to disable each of them individually ("if (0) {" should do
the trick) and see each time if the slowdown still occurs, so as to give
us a hint on which command causes the slowdown.

Also, at the moment a slowdown occurs and if you have ACPI support
enabled, could you please check the throttling level (and the frequency,
if that applies to your CPU)? I suspect that the motherboard is
hardwired so as to enable throttling on overheat detection. A faulty
init of the w83781d could trigger such an alarm and enable throttling,
resulting in the slowdown you notice. Well, that's just a wild guess,
but still worth verifying IMHO.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
