From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 19 Nov 2011 08:50:56 +0000
Subject: Re: [lm-sensors] wrong output with fam15h_power
Message-Id: <20111119095056.3dea071c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321642023.1644.12.camel@tellur>
In-Reply-To: <1321642023.1644.12.camel@tellur>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phil,

On Fri, 18 Nov 2011 20:26:25 -0800, Phil Pokorny wrote:
> I know that power draw
> is increasing, because I see the temperatures rising (via k10temp
> hacked to read fam15h temps).

Which hack? The k10temp driver is supposed to already support fam15h
CPUs (both in kernel 3.0+ and the standalone driver.)

> (...)
> But this driver is clearly not reporting something that could be
> considered "instantaneous power draw"  It might be better to change
> the driver to report the TDP and come up with some other name for the
> "running avg" number directly because it appears to be a "head room"
> or margin and *not* an instant power measurement.  But it can also
> have big swings in value without corresponding changes in the power
> draw, so I'm not sure what we should call it.

In a sense this is continuing the long tradition of "monitoring AMD
CPUs is impossible because they return completely weird values half of
the time". We had this for K8 and fam10h temperatures already... That's
very sad.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
