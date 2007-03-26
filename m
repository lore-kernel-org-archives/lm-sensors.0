From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 26 Mar 2007 11:39:47 +0000
Subject: [lm-sensors] [PATCH] lm-sensors: add dme1737 support
Message-Id: <20070326133947.bc9121bf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703232147q3a74701ci4bedf256201ee587@mail.gmail.com>
In-Reply-To: <191fb4ca0703232147q3a74701ci4bedf256201ee587@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Sun, 25 Mar 2007 11:43:39 -0700, Juerg Haefliger wrote:
> > >       { "pwm2", "pwm2", 0, "fan2_pwm" },
> > >       { "pwm3", "pwm3", 0, "fan3_pwm" },
> > >       { "pwm4", "pwm4", 0, "fan4_pwm" },
> > > +     { "pwm5", "pwm5", 0, "fan5_pwm" },
> > > +     { "pwm6", "pwm6", 0, "fan6_pwm" },
> > >       { "pwm1_enable", "pwm1_enable", 0, "fan1_pwm_enable" },
> > >       { "pwm2_enable", "pwm2_enable", 0, "fan2_pwm_enable" },
> > >       { "pwm3_enable", "pwm3_enable", 0, "fan3_pwm_enable" },
> > >       { "pwm4_enable", "pwm4_enable", 0, "fan4_pwm_enable" },
> > > +     { "pwm5_enable", "pwm5_enable", 0, "fan5_pwm_enable" },
> > > +     { "pwm6_enable", "pwm6_enable", 0, "fan6_pwm_enable" },
> > >       { NULL, NULL }
> > >  };
> > >
> >
> > You shouldn't need this, the alternative names were only in use for a
> > short range of early 2.6 kernels, and your driver will never be
> > backported to these kernels.
> 
> If I don't have these lines I get 'Can't get pmw5 data' and 'Can't get
> pwm6 data' errors. Isn't this the right fix?

Ah, you're right, there was a bug in libsensors in the way the pwm
symbol names were translated. I fixed it diffrently in SVN, so that it
will work for pwm7, pwm8 etc. too:
http://www.lm-sensors.org/changeset?new=lm-sensors%2Ftrunk%2Flib%2Fproc.c%404354&old=lm-sensors%2Ftrunk%2Flib%2Fproc.c%404287
Please confirm it works for you.

Thanks,
-- 
Jean Delvare

