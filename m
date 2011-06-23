From: Alexander Stein <alexander.stein@systec-electronic.com>
Date: Thu, 23 Jun 2011 15:14:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: LM95245 driver
Message-Id: <201106231714.19713.alexander.stein@systec-electronic.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1308649953-2774-1-git-send-email-alexander.stein@systec-electronic.com> <201106231114.52841.alexander.stein@systec-electronic.com> <20110623144755.GE28311@ericsson.com>
In-Reply-To: <20110623144755.GE28311@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thursday 23 June 2011 16:47:55 Guenter Roeck wrote:
> > Another point is the optional offset register (not implemented, see
> > below). I could not found much about it, but I guess this is immediately
> > added to the remote temperature register.
> 
> You could set it to some value and see what happens.

I might look into that, when I implement the offset feature.

> > > Other comments:
> > > 
> > > For the interval attribute, idea would be to write the value into the
> > > conversion rate register. Your code does not match the interval with
> > > the rate programmed into the chip (which is the idea), nor does it
> > > update the rate if the interval is changed.
> > 
> > Well, I noticed that. But I went the way lm95241 does. I'm also unsure
> > which interval to choose, if user specify a unsupported interval. Choose
> > the next small or the next greater one? Maybe you can give me a hint
> > here.
> 
> Two bad or wrong implementations don't make it a good one. If the value can
> be configured into the lm95241, the code should do it.
> 
> The lm90 driver tries to find the closest match, which would be one way to
> go and is what I usually do. Another possibility would be to select the
> next larger valid interval.

I think the closest match might be the best. As there is fixed set of 
possibilities, what do think about printing the possiblities upon read and 
marking the used one by an asterisk?

> Another thing I noticed: You are re-configuring the chip during
> initialization. This is even though the chip may already have been
> configured through ROMMON and/or BIOS, and specifically overrides the
> external sensor type. That is not a good idea; even though it may make
> sense in your application, it may screw up chip configuration for other
> users of the chip.
>
> If your BIOS/Firmware does not configure the chip, and you really have to
> do it in the driver, one option would be to provide configuration data
> through optional platform data.

Ehm, where do I add platform data on x86? It gets detected by device probing. 
For boards like arm, sure no problem there.

Reagrds,
Alexander

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
