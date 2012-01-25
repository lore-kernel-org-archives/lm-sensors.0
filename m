From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 25 Jan 2012 10:31:39 +0000
Subject: Re: [lm-sensors] [PATCH 79/79] hwmon: (it87) Fix vrm value range
Message-Id: <20120125103139.GC12670@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327373398-997-80-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1327373398-997-80-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 25, 2012 at 05:17:24AM -0500, Jean Delvare wrote:
> On Tue, 24 Jan 2012 07:11:27 -0800, Guenter Roeck wrote:
> > On Tue, Jan 24, 2012 at 03:50:12AM -0500, Jean Delvare wrote:
> > > We could improve this of course, but is it worth it? As documented in
> > > Documentation/hwmon/sysfs-interface, changing the vrm value manually
> > > should no longer be needed. libsensors does even ignore this attribute
> > > completely. And newer hardware tends to no longer use the VID pins at
> > > all. Actually hwmon-vid is in a pretty bad shape at the moment at least
> > > for all Intel CPUs after Conroe (2007, yeah!) for which we set the VRM
> > > to 82 i.e. Pentium II/III. And nobody complained yet as far as I know!
> >
> > If it is like me, I always thought it was a chip problem that it displays
> > a voltage of 0. There is no warning, so my take is that people simply don't
> > realize that the CPU model is not recognized.
> 
> There are 3 different problems here.
> 
> Problem #1 is the bug in hwmon-vid which causes all unknown Intel
> family 6 processors to use VRM 8.2, even though this is wrong on any
> post-2007 CPU.

Working on fixing that. Looks like all the recent CPUs use VRD 11.0 or 11.1.
There seem to be some supporting VRD 12.0, (the SandyBridge chips using the
larger socket) but I did not find cpuid values for those.

> Problem #2 is that unknown VRM for a recent CPU will only be notified
> to the kernel log, which regular users don't read. Then you indeed get
> a cpu0_vid value of 0. That's apparently what you were seeing on your
> system. It would certainly be better to _not_ expose the VID value at
> all if we don't know how to decode it.
> 
Actually, I have problem #1 on one board, and problem #3 on the other
(the one with SandyBridge). vid reads 0xff on that board. On the other board,
vid erroneously reports a voltage of 2.048V. I never thought about that
until you brought it up.

Thanks,
Guenter

> Problem #3 is that most boards no longer have the VID pins routed to
> the hardware monitoring chip, because the same information can be
> retrieved from MSR and board makers don't want to route 6 to 8 extra
> wires from the CPU to the Super-I/O without a good reason. In general
> the VID pins can be used for other functions too. But there is not
> always an easy way to figure that out, so on most recent systems,
> cpu0_vrm will return a bogus value. We can probably fix some of these
> cases but not all.
> 
> I expect future Super-I/O chips to drop the VID input feature
> altogether, which will make the situation better, hopefully.
> 
> > > So I'm really not sure if it is worth spending time on. It might make
> > > more sense to turn all these vrm attributes read-only (and ultimately
> > > kill them altogether.) If we really want to let the user force the vrm
> > > value if automatic detection failed, it would probably be better done
> > > as a module parameter to hwmon-vid. It is certainly less flexible, but
> > > at least we don't have to repeat it in every hwmon driver.
> >
> > After looking into it a bit more, I think we should move the vrm attributes
> > to hwmon-vid (and fix hwmon-vid).
> 
> Agreed.
> 
> -- 
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
