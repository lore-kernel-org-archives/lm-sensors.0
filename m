From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 31 May 2008 21:18:32 +0000
Subject: Re: [lm-sensors] Reported fan speed oscillates 730 RPM -> 337500
Message-Id: <20080531231832.7cd06f07@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1211960385.4093.18.camel@localhost.localdomain>
In-Reply-To: <1211960385.4093.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Simon,

On Wed, 28 May 2008 09:39:45 +0200, simon wrote:
> The following output shows periodic output from sensors for my CPU
> cooler over a short period.
> 
> The value continually oscillates between a real value (around 720-750
> RPM in idle) and out-of-range values 337500 RPM/675000 RPM. When the
> machine is loaded, and the fan spins faster, the fan value stabilizes at
> a normal value.
> 
> The fan 2 sensor has no problems.

What's the usual speed value of fan2? Does its speed also change
according to the temperature? The problem typically only shows for fans
those speed is controlled and only for low speeds.

> Anyone have any ideas what's happening?
> 
> Configuration: 
> lm-sensors v3.01 
> Motherboard Gigabyte GA-MA78GM-SH2 
> CPU Cooler: Thermaltake TMGA3 (3 wire)
> 
> Output from sensors over ~2 mins:
> it8718-isa-0228
> 
> fan1:          726 RPM  (min =    0 RPM)
> fan1:       675000 RPM  (min =    0 RPM)
> fan1:       337500 RPM  (min =    0 RPM)
> fan1:          738 RPM  (min =    0 RPM)
> fan1:       675000 RPM  (min =    0 RPM)
> fan1:          726 RPM  (min =    0 RPM)
> fan1:       675000 RPM  (min =    0 RPM)
> fan1:       337500 RPM  (min =    0 RPM)
> fan1:       675000 RPM  (min =    0 RPM)
> fan1:          725 RPM  (min =    0 RPM)
> fan1:          725 RPM  (min =    0 RPM)
> 
> Many thanks for ideas!

This happens frequently when you control the speed of a 3-wire fan and
the speed drops below a given limit. The speed is measured using a
signal that comes from the fan, and when you control the fan, that
signal gets weaker (think of it as proportional to the speed of the
fan).

So apparently your fan is exactly at the limit below which the signal
is too weak for reliable speed monitoring, which results in these fancy
readings (which really mean that the IT8718F chip fails to sense the
speed signal). If you can change the settings of the fan speed control
so that the idle speed is slightly higher, the problem should go away.
If the fan self-regulates then there's unfortunately not much you can
do.

As a summary, 3-wire fans cannot always be controlled and monitored at
the same time reliably. That's why we start seeing 4-wire fans, which
do not have this problem.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
