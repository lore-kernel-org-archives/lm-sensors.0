From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 08 Dec 2012 12:30:06 +0000
Subject: Re: [lm-sensors] Driver for Bulldozer
Message-Id: <20121208133006.3dd628d6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAMcsHH20xPDkTq7+9KyxDodnNYKB+UNS3_T=Exfq=BfP+kaxjw@mail.gmail.com>
In-Reply-To: <CAMcsHH20xPDkTq7+9KyxDodnNYKB+UNS3_T=Exfq=BfP+kaxjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 8 Dec 2012 05:00:05 -0500, Vahid Keykhaey wrote:
> Recently, I was working with core i7 2600 and I used your nct driver for
> it.

I suppose you refer to Guenter Roeck's nct6775 driver. It is
essentially unrelated to your CPU, as it is a driver for the hardware
monitoring features of the Super-I/O chip on your motherboard.

> I changed my desktop, and I am using Bulldozer 8120 processor, but
> Lm-Sensors does not detect my thermal sensors. I was looking for Fam15h
> linux driver but I could not find it.
> I am asking for a help to eliminate my problem.

The AMD Family 15h CPU itself is handled by two drivers, k10temp for
the temperature and fam15h_power for the power. You'll need a recent
enough kernel (can't tell exactly which as unfortunately the wiki
hosting the project documentation is down at the moment.) For k10temp
you can always use the standalone driver if needed:
  http://khali.linux-fr.org/devel/misc/k10temp/
Instructions at:
  http://khali.linux-fr.org/devel/misc/INSTALL
We don't have a standalone fam15h_power driver, but I could make one if
needed.

But for the rest of the system monitoring (voltages, system
temperature, fan speed and possibly fan control) what you need is a
driver for your Super-I/O chip (or more rarely these days, for a
dedicated monitoring chip on the SMBus.) It is possible that support is
lacking for that chip if your motherboard is very recent. At any rate,
there's nothing we can do without additional information from you.
First thing we need is the complete output of a recent version of
sensors-detect:
  http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
