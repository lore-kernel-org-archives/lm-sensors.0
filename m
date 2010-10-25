From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 25 Oct 2010 02:39:24 +0000
Subject: Re: [lm-sensors] Discrepancy between reported readings from
Message-Id: <20101025023924.GA16230@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
In-Reply-To: <AANLkTik8hx=ej8V7ti_=izz0u+daOxxy5PmBjX0ZQv8W@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Oct 24, 2010 at 09:40:38PM -0400, Arun Raghavan wrote:
> Thanks again for the prompt response. One more question regarding
> coretemp: any idea how I can probe the sensor in my own source code?
> I'm hoping to be able to probe a few times a second, while the
> lm-sensors usage guide says max. probing frequency should be at most
> 0.3-0.5 Hz. I'm trying to measure thermal response and hence
> transients. Temperature rises rather too rapidly for this once every
> 2-3 seconds restriction; there's no intermediate reading between idle
> temperature (~28C) and loaded (~55C). Even when I overclock to
> deliberately induce more dissipation, I don't get an intermediate
> reading between the same base temperature and 70C!
> Please let me know if the 2-3s resolution is a limitation of the
> sensors API or the kernel module itself. Any tips on how I might be
> able to measure with greater frequency (apart from hooking up an
> external probe and thermometer)?
> 
Please don't top-post.

Technically, you can keep reading the sysfs attribute file in a continuous 
loop without delay. However, the coretemp driver updates its readings only
once per second.  You can poll faster, of course, but it won't help much.

Just wondering - did you _try_ probing it faster than the guide says ?
If no, why not ? After all, it is a usage guide, not a law.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
