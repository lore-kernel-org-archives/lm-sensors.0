From: x0nishan@ti.com (Menon, Nishanth)
Date: Tue, 21 Jun 2005 21:31:27 +0000
Subject: [lm-sensors] I2C 2.9.1 driver support for High Speed I2C (draft
Message-Id: <520AB2AD990DC04082102F77CA1726385B8AA0@dlee03.ent.ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <520AB2AD990DC04082102F77CA1726385B8994@dlee03.ent.ti.com>
In-Reply-To: <520AB2AD990DC04082102F77CA1726385B8994@dlee03.ent.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thanks for pointing it out. I understand and accept your comment. I had
used the lmsensor 2.9.1 as a readily available reference point. In fact,
if we look at the functions and structures that would be affected by the
suggested change in the 2.6 kernel i2c driver, I see that there is no
functional change (in the said functions and structures) between the 2.4
and the 2.6 versions that would affect HSI2C implementation. In short,
the suggested implementation is valid even for 2.6 kernel. This was one
of the design criteria I had placed while looking out for a solution.
So, if any custom kernel base wanted to extend the Linux2.4 i2c driver,
it could do so, at the same time, the feature set could be readily
available for the 2.6 kernel too. 

I would love to hear comments for the over all plan (of-course, keeping
the 2.6 kernel in picture) before I even think about sending out a patch
for the same.

Regards,
Nishanth Menon

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Tuesday, June 21, 2005 2:07 PM
> To: Menon, Nishanth
> Cc: Woodruff, Richard; LM Sensors
> Subject: Re: [lm-sensors] I2C 2.9.1 driver support for High Speed I2C
> (draft design)
> 
> Hi Nishanth,
> 
> > In continuance of the discussion about HSI2C support
> > (http://archives.andrew.net.au/lm-sensors/msg31155.html ), I would
> > like to present for discussion a strategy to incorporate HSI2C
support
> > to the current I2C driver (ver 2.9.1).
> > (...)
> > 5.       Should be simple enough to carry forward into various
kernel
> > versions.
> 
> No. Whatever you plan, this must be based on the Linux 2.6 i2c
> subsystem. i2c-CVS (for Linux 2.4) is in maintenance state, we are not
> adding any new feature in there.
> 
> --
> Jean Delvare
