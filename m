From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 03 Jun 2009 08:06:13 +0000
Subject: Re: [lm-sensors] Power Supply Monitoring
Message-Id: <20090603100613.31018c21@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090602164941.uz55en9rms0okkg0@blastoid.drak.net>
In-Reply-To: <20090602164941.uz55en9rms0okkg0@blastoid.drak.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2 Jun 2009 22:00:00 -0500 (CDT), Matt Roberds wrote:
> On Tue, 2 Jun 2009, Jacob Steinberger wrote:
> > I'm trying to do power supply monitoring to detect if we're having a
> > problem (loss of grid power, loss of UPS power, voltage issues, etc).
> 
> The voltage readings you get from lm-sensors are usually of the DC
> output of the computer power supply.  The readings also tend to have a
> relatively low update rate - maybe a few times a second max.  If your
> input AC power is really bad, you might be able to see it by looking at
> the output, but if the AC power only glitches out occasionally, you
> probably won't see it this way.

Actually this is only partly true. While the sysfs interface
rate-limits the readings, the chip itself is usually sampling the
voltage at a much higher rate, and alarms which are raised stick until
they are read. So you may not be able to see the voltage value at
glitch time, but you should definitely see an alarm for it the next
time you check it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
