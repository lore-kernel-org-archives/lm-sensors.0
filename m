From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 03 Nov 2005 04:26:00 +0000
Subject: [lm-sensors] RE: vt8231.c
Message-Id: <20051103032550.GA8138@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant:

> Jean Delvare wrote:
> > Dividers work the way they are supposed to. You do not seem to
> > understand what that way is. I invite you to read the following document:
> >   http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/fan-divisors
> > 
> > Hopefully this will help you understand how it works.
> > 
> > If you use a 9 pulse/rev fan (didn't know these existed...) instead of
> > standard 2 pulse/rev, you should add the following line to your
> > configuration file:
> > 
> >   conpute fan1 @*2/9, @*9/2

* Grant Coady <gcoady@gmail.com> [2005-11-03 07:49:19 +1100]:
> Possibly:
> 
> 	compute fan1 @*8/9, @*9/8
> 
> since fan1_div = 8 is only one gave a result for fan1_min?

No, no, no... fan divisors are *not* related to sensors.conf compute formulas!

You must have read the document Jean mentioned... didn't you work on automagic
fan divisor algorithms for a while?

Who are you? And what have you done with Grant? ;)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

