From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 25 Oct 2010 11:25:58 +0000
Subject: Re: [lm-sensors] Discrepancy between reported readings from
Message-Id: <20101025112558.GB16863@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
In-Reply-To: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 25, 2010 at 03:16:02AM -0400, Jean Delvare wrote:
> Hi Arun,
> 
> On Sun, 24 Oct 2010 21:40:38 -0400, Arun Raghavan wrote:
> > Thanks again for the prompt response. One more question regarding
> > coretemp: any idea how I can probe the sensor in my own source code?
> > I'm hoping to be able to probe a few times a second, while the
> > lm-sensors usage guide says max. probing frequency should be at most
> > 0.3-0.5 Hz.
> 
> Out of curiosity, which "usage guide" are you referring to?
> 
> > I'm trying to measure thermal response and hence
> > transients. Temperature rises rather too rapidly for this once every
> > 2-3 seconds restriction; there's no intermediate reading between idle
> > temperature (~28C) and loaded (~55C). Even when I overclock to
> > deliberately induce more dissipation, I don't get an intermediate
> > reading between the same base temperature and 70C!
> 
> There's no reason why overclocking would help. Overclocking will
> generate more heat, but the time it takes to generate it won't change.
> 
> > Please let me know if the 2-3s resolution is a limitation of the
> > sensors API or the kernel module itself. Any tips on how I might be
> > able to measure with greater frequency (apart from hooking up an
> > external probe and thermometer)?
> 
> There's no limitation at the sensors API level. Each kernel driver has
> its own cache lifetime depending on various things, including the
> number of registers to read, how fast or slow register access is, and
> the driver design.
> 
> In the case of the coretemp driver, the 1 second lifetime is pretty
> arbitrary, as there are only a few registers to read (one per core) and
> register access is very fast (CPU MSRs). Fenghua, Guenter, do you think
> it would make sense to shorten the cache lifetime to 0.5 or even 0.25
> second?
> 
Might be even less - eg 100ms or even 50ms - if the temperature can rise
significantly in a very short period of time, as suggested above.
Plus of course if the sensor updates its readings that fast.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
