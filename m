From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: bmcsensors howto?
Message-Id: <20040922140256.GE8696@neu.physik.fu-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <e6c87c5df333406bb6fd34c1549fe20d@onlymooo.com>
In-Reply-To: <e6c87c5df333406bb6fd34c1549fe20d@onlymooo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 22, 2004 at 08:49:17AM -0400, Mark Studebaker wrote:
> If it's not in the RPM and you're running a 2.4 kernel then get our release 
> from our website.

It's part of the rpms:
# rpm -ql kernel-module-lm_sensors-2.4.22-1.2199.nptl_52.rhfc1.at-2.8.7-0_32.rhfc1.at|grep bmc
/lib/modules/2.4.22-1.2199.nptl_52.rhfc1.at/updates/drivers/i2c/chips/bmcsensors.o

but the original poster did mention kernel 2.6.

> We don't make the RPMs.
> If you're running 2.6 then wait until the port is finished and included in 
> the kernel.

Is it possible to build external kernel modules for 2.6 as it is for
2.4? I could then package it up like currently done for 2.4.

> Marc Williams wrote:
> >After viewing the posts in this forum for a few days, it sure seems like
> >this sort of "new user" question should go somewhere else but I didn't see
> >any other list.  Please advise if there's somewhere else this would be
> >better posted.
> >
> >While not a totally new lm_sensors user - I have successfully installed a
> >few sensors on other FC and Red Hat machines - I am not a developer nor am 
> >I
> >any sort of sensors guru and I am stumped with my latest attempt.  It seems
> >this motherboard has a dual i450 with a 440bx chipset.  I've got a fully
> >patched and up to date FC2 running on it quite nicely.  After I load up
> >ATRPM's latest version of lm_sensors and run sensors-detect, it tells me to
> >load, among other things, the bmcsensors module.  Only problem is that it
> >doesn't seem to exist.
> >
> >Googling around, I found a thread about someone's attempt to port an older
> >bmcsensors to work with newer kernels and sensors but I'm afraid I didn't
> >understand much of what was being discussed.  And in the chips chart on the
> >lm_sensors page I see that bmcsensors is in the process of being ported.
> >
> >Would it be possible for someone to spell out exactly what I need to do in
> >order to aquire and load this bmcsensors thing.  Or even if it's possible?
> >
> >Sorry for the nooby-ish type question.  Thanks for your time!
> >
> >
> >
> >

-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040922/4ad81bf5/attachment.bin
