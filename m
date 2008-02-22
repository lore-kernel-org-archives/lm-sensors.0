From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 22 Feb 2008 21:26:16 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Skip "random" I/O port
Message-Id: <1203715576.6976.4.camel@pasglop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080218223317.2142dc16@hyperion.delvare>
In-Reply-To: <20080218223317.2142dc16@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Fri, 2008-02-22 at 08:44 +0100, Jean Delvare wrote:
> On Fri, 22 Feb 2008 18:21:23 +1100, Benjamin Herrenschmidt wrote:
> > 
> > On Fri, 2008-02-22 at 08:19 +0100, Jean Delvare wrote:
> > > 
> > > I was referring to the kernel patch Christian submitted earlier this
> > > week which prevents oopses or machine checks when older versions of
> > > sensors-detect access /dev/port in unexpected ways. My update to
> > > sensors-detect was meant as a complement of his patch, not a
> > > replacement.
> > 
> > But his patch can't recognize a potentially valid use of /proc/port
> > right ?
> 
> I don't know much about PPC so I can't comment on the implementation.
> All I'm saying is that, if it is possible at all, I believe that
> preventing invalid accesses from oopsing the machine is a good idea.

Preventing root from doing something stupid is not worth bothering.

I don't see how you can effectively prevent invalid accesses to
IO ports without also blocking potentially valid ones in that case,
unless the kernel happens to know exactly what is where (which isn't
necessarily the case as far as such IOs are concerned) and even
then, who can the kernel differenciate ?

For example, on some machines, I have seen firmwares putting PCI IO BARs
of device where usually legacy stuff is on x86. So while accesses to
this area via /proc would be legit by something that knows about that
device, something like sensors-detect would definitely do the wrong
thing by assuming those ports are hooked up to legacy devices.

Ben.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
