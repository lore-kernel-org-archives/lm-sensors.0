From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-Id: <QyFDHyIh.1105523081.6907040.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <200501112205.02322.pioppo@ferrara.linux.it>
References: <20050108103449.345def67.khali@linux-fr.org>
In-Reply-To: <20050108103449.345def67.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pioppo@ferrara.linux.it
Cc: LM Sensors <sensors@stimpy.netroedge.com>, Jonas Munsin <jmunsin@iki.fi>, djg@pdp8.net, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>


Hi Simone,

> > 2* I would then add a check to the it87 driver, which completely disables
> > the fan speed control interface if the initial configuration looks weird
> > (all fans supposedly stopped and polarity set to "active low"). This
> > should protect users of the driver who have a faulty BIOS.
>
> If the driver can perform a similar guess, couldn't it also activate a
> reverse polarity mode as well?  I think all systems boot with with
> full-speed fan, so any value you found at loading time should be the
> full-speed one, shouln't it?

I'm thinking about this. However, there are a couple things to keep in
mind:
1* The driver is not necessarily loaded at boot time. For example, one
might unload and reload the module. In this case, fans might have been
configured for less-then-full speed, and we have to handle this case
properly.
2* This is just a guess. If we are wrong, the user is in trouble. You
know what I mean ;) For this reason, it sounds better if the user has to
activate a module parameter by his/herself, because it means he/she is
aware that bad things might happen.
3* This is really a workaround for buggy BIOS. It would be better is
BIOSes were fixed instead. It is time that manufacturer improve the
quality of the BIOSes for the hardware monitoring parts. I have seen
brokenesses ain too many BIOSes to keep count of them. Silently working
around the bugs in the Linux driver is not going to help that.

That said, if no problems are reported after some time, we might consider
to apply the workaround by default. One thing at a time though.

> BTW:
>  I'm writing a report to giga-byte.

OK. Let us know how it goes. Feel free to direct them to me if you think
it can be of any help.

--
Jean Delvare
