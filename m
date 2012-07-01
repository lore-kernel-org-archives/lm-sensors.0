From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 01 Jul 2012 04:53:45 +0000
Subject: Re: [lm-sensors] CPU fan with full speed
Message-Id: <20120701045345.GA22909@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <jsm40t$qk8$1@dough.gmane.org>
In-Reply-To: <jsm40t$qk8$1@dough.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jul 01, 2012 at 04:46:11AM +0100, Michael Zintakis wrote:
> 
> >No ... those are separate drivers, and different sensors. Also, the coretemp
> >reading is not really that exact. Especially at low temperatures it can be quite
> >a bit off, as far as I remember by 10 degrees C or more. It is more accurate at
> >very high temperatures.
> I see, interesting - for some reason I always thought the Intel
> censors are more accurate (judging by their measurements, because
> when I place a load on that machine, both Intel CPU readings jump,
> but the f71882fg driver barely moves a degree or two and stays in
> line with the rest of the sensors, which doesn't really makes sense
> - when the CPU is under load its temperature should rise rapidly).
> 
> >Also, keep in mind that you have a different chip. pwm3_auto_channels_pwm
> >means something completely different on the f71882fg. For that chip, it is
> >not a bit map, but the temperature sensor index. 1..4 in pwmX_auto_channels_pwm
> >reflects temp[1..4]_input.
> I am totally confused now! :-\
> 
> The driver has only 3 temperature readings: temp[1..3]_input,
> corresponding to CPU (single censor, even though I've got 2 cores)
> and 2 motherboard readings (one on the PC board extension card and
> another one on the main board itself).
> 
> So, I have the following values by default:
> 
> pwm1_auto_channels_pwm = 1 (1 binary - fan1)
> pwm2_auto_channels_pwm = 2 (10 binary - fan2)
> pwm3_auto_channels_pwm = 4 (100 binary - fan3)
> 
Guess you mean pwm[1-3]_auto_channels_temp.

> Makes perfect sense since I do not have a 4th temperature reading
> anywhere on the system, unless you take into account the coretemp
> driver, which is in a different subdirectory: hwmon0 and not hwmon1
> as the f71882fg driver is.
> 
You are right - sorry for that. I looked into the driver. The chip
understands [1, 2, 3], but the driver maps those values into a bit map,
where only one bit can be true at any given time.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
