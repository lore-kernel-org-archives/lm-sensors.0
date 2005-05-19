From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: [PATCH][I2C] Marvell mv64xxx i2c driver
Message-Id: <3s6eEus2.1107510325.6106480.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <4202BBF9.3020104@mvista.com>
References: <41F6F1D5.90601@mvista.com>
In-Reply-To: <41F6F1D5.90601@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mgreer@mvista.com, adobriyan@mail.ru
Cc: Greg KH <greg@kroah.com>, LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>


Hi Mark, Alexey,

> > >+					/* 0x170000 - USB		*/
> > >+					/* 0x180000 - Virtual buses	*/
> > >+#define I2C_ALGO_MV64XXX 0x190000       /* Marvell mv64xxx i2c ctlr	*/
> > 
> > While I searched for typos and you're fixing them, au1550 owned 0x170000.
> > 2.6.11-rc3 says:
> > 
> > 	#define I2C_ALGO_AU1550 0x170000 /* Au1550 PSC algorithm */
> > 
> > So, I'd remove first two comments.
>
> I added the comments b/c of this email from Jean Delvare,
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0501.3/0977.html.  The
> relevant part being:
>
> "0x170000 is reserved within the legacy i2c project for an USB algorithm,
> and 0x180000 for virtual busses. Could you please use 0x190000 instead,
> so as to avoid future collisions?"
>
> It looks like I2C_ALGO_AU1550 was just added so my guess is Jean is
> correct and I2C_ALGO_AU1550 should be made 0x1a0000 (or I move mine back
> one).  Would someone confirm that 0x170000 is used by legacy i2c stuffs?
> I don't really know where to look.  If so, I can easily make a patch
> moving it back.

I am as surprised as you are to see this here. I2C_ALGO_AU1550 should
really be made a different value. There is also a problem with
I2C_ALGO_PCA and I2C_ALGO_SIBYTE having the same value, which was
already reported to Greg some days ago if memory serves. I think I will
send a patch against 2.6.10-rc3 to Linus this evening, which fixes the
broken algo IDs. That way Mark can keep the algorithm ID he is using
right now, and each algorithm will get its own, unique ID, as should be.

You can see the i2c-id.h list from the legacy i2c project here:
  http://www2.lm-sensors.nu/~lm78/cvs/i2c/kernel/i2c-id.h
I am indeed trying to keep it in sync with the one in Linux 2.6 (and with
the one in Linux 2.4 at times), in the hope it'll avoid confusion and
increase portability.

Thanks,
--
Jean Delvare
