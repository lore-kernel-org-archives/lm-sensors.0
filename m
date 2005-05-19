From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: low fan speed = zero?
Message-Id: <20040129205052.5a601bca.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075385890.672.19.camel@pferd.babel>
In-Reply-To: <1075385890.672.19.camel@pferd.babel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'm a bit shy of mailing a developer, but there doesn't seem to be a
> public mailing list...

Welcome to the LM Sensors mailing-list. Yes, really :)

> I've got a temperature-controlled fan here. When the speed drops below
> an uncertain threshold, it is reported as 0 (zero).
> 
> Now, the reason I'm writing is that this threshold seems software
> related. For testing purposes, I replaced the NTC with a variable
> resistor.
> 
> The Windows software that came with my Mobo will report values as low
> as 1600rpm, the hardware Monitor in BIOS/CMOS setup starts ticking at
> about 2000rpm, lm_sensors and gkrellm will only give me a reading at
> 2400 and over -- a value that's unlikely to be reached even on the
> hottest summer's day.

Tell me the brand of your hardware and fan. I'd really appreciate it if
such a low fan speed was sufficent to keep my systems cold during
summer.

> Apparently, some software does a sanity check and won't report values
> it considers to be too low. Could you give me a hint where this may
> happen, iow point me to the right place if it is in the lm_sensors
> code?

What you are after is called fan divisor. Since you didn't tell us which
specific driver you are using, my comments will be generic.

First of all, I invite you to take a look at doc/fan-divisors. This will
give you a good overview of what fan divisors are for. Basically, it let
you control the accuracy vs. range tradeoff for fan speed measurements.
Since you are interested in low speed fans, you want a big divisor.

To change divisors, providing your chip and driver support it, edit
/etc/sensors.conf to fit your needs. Then run "sensors -s" to update the
chips internal registers so that it take the change into account.

Hopefully this should let you watch even low speeds.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
