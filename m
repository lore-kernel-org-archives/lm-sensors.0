From: fhj52rags@yahoo.com (Ric)
Date: Sat, 26 Aug 2006 22:07:07 +0000
Subject: [lm-sensors] Using ... SMSC EMC6W201
Message-Id: <20060826220707.34694.qmail@web37409.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060613202602.560.qmail@web81611.mail.mud.yahoo.com>
In-Reply-To: <20060613202602.560.qmail@web81611.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:
Thanks! 
Yep, that is pretty much what I thought was true except for the part
about not being able to assist. It (fscscy.c) appears to have almost
all the correct functions: 6 fans, PWM control, temperatures, voltages
and only needing better code(for 2.6) and a few adjustments.  I, being
really new at this, needed _some_ guideline, even an old and dead one.
Of course, I'll take your advice.  Thanks for providing it. :)

Thank you for the 8712F info too.  Yes , it is 2 not 3 additonal fan
registers(payback 2me for posting at nap time...).  Even if lm_sensors
users do not complain about not having the 2 other fans, I am 99%
certain that no user would be upset by being able to monitor the other
two.  It would be an advantage, ithink.
For what it might be worth as a gauge, SpeedFan(for MS OS) author
started working on adding those two a few months back and there are
quite a few users who have expressed interest. Relative to other
speedfan issues, it is quite a long list.
If needed, this is the new-er datasheet:
IT8712F Preliminary Specification V0.8.2 ITE TECH. INC.
http://www.ite.com.tw/product_info/file/pc/IT8712F_V0.8.2.pdf

Regards, Ric
========
--- Jean Delvare <khali at linux-fr.org> wrote:

> Hi Ric,
> 
> > On the subject of using an existing driver, quite a while back I
> looked
> > hard for options to use. All fell short but the fscscy.c driver for
> the
> > Fujitsu-Siemens Scylla chip looked promising. Alas there was no
> kernel
> > module for it so I could not test it. ( I never found out why
> fscscy.o
> > is MIA... ) The /usr/share/doc/packages/sensors/chips/fscscy does
> > exist.
> 
> This is an old driver, for an old and rare chip. Nobody took the time
> to port the driver to Linux 2.6, which is why you can't find it. The
> chip drivers documentation in the lm_sensors package is for the Linux
> 2.4 drivers and should not be installed on a Linux 2.6-based system.
> 
> I would be very surprised if a Scylla chip was used in a recent
> system.
> And I very much doubt any other chip would be even slightly
> compatible
> with it. So my advice would be: forget about fscscy, it's not going
> to
> help you.
> 
> > The point of this being that there are 3 more fans that the IT8712F
> can
> > monitor, according to the datasheet, but it appears that the 8712F
> > driver does not have those other 3 fans. If so, is there anybody
> > working on upgrading that driver? 
> 
> The latest revisions of the IT8712F can support 5 fans instead of 3.
> This is 2 more fans, not 3. Our driver doesn't support them for now,
> but it could be added if enough users show interest.
> 
> -- 
> Jean Delvare
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

