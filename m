From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Oct 2010 16:26:35 +0000
Subject: Re: [lm-sensors] Detection of W83L771W/G in lm90
Message-Id: <20101021182635.6a38d2c1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101014114626.7c4be041@endymion.delvare>
In-Reply-To: <20101014114626.7c4be041@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 14 Oct 2010 15:48:18 +0200, Alexander Stein wrote:
> On Thursday 14 October 2010, 15:39:50 Jean Delvare wrote:
> > Yes, I want to ignore it on purpose for simplicity. One reason being
> > that I have a doubt that the old W83L771W/G actually supports a higher
> > refresh rate than the new W83L771AWG/ASG does. I don't necessarily
> > trust the datasheet, as it is inconsistent: it says the default
> > register value is 08h, then later it claims that the default conversion
> > rate is 16 Hz, but 16 Hz corresponds to a value of 09h in the table.
> > Additionally, you'll notice that the W83L771W/G conversion rate table
> > is shifted by 1 compared to all the other compatible chips - which is
> > quite suspicious.
> > 
> > So I assume that the table is wrong in the datasheet. Only if someone
> > with a W83L771W/G at hand tests it and comes to the conclusion that the
> > table in the datasheet is correct, will I update the driver accordingly.
> 
> I surely can test something, but as I'm not into those sensors, I need an 
> advise what and how to test.

Thanks for the proposal, but in all honestly I don't think it's worth
our time, as there's no easy way to test. If someone complains about
the current behavior, I'll investigate, but for now I say we just leave
the code as is.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
