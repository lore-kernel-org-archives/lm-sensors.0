From: simon <simd@arcor.de>
Date: Wed, 28 May 2008 07:39:45 +0000
Subject: [lm-sensors] Reported fan speed oscillates 730 RPM -> 337500
Message-Id: <1211960385.4093.18.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
The following output shows periodic output from sensors for my CPU
cooler over a short period.

The value continually oscillates between a real value (around 720-750
RPM in idle) and out-of-range values 337500 RPM/675000 RPM. When the
machine is loaded, and the fan spins faster, the fan value stabilizes at
a normal value.

The fan 2 sensor has no problems.

Anyone have any ideas what's happening?

Configuration: 
lm-sensors v3.01 
Motherboard Gigabyte GA-MA78GM-SH2 
CPU Cooler: Thermaltake TMGA3 (3 wire)

Output from sensors over ~2 mins:
it8718-isa-0228

fan1:          726 RPM  (min =    0 RPM)
fan1:       675000 RPM  (min =    0 RPM)
fan1:       337500 RPM  (min =    0 RPM)
fan1:          738 RPM  (min =    0 RPM)
fan1:       675000 RPM  (min =    0 RPM)
fan1:          726 RPM  (min =    0 RPM)
fan1:       675000 RPM  (min =    0 RPM)
fan1:       337500 RPM  (min =    0 RPM)
fan1:       675000 RPM  (min =    0 RPM)
fan1:          725 RPM  (min =    0 RPM)
fan1:          725 RPM  (min =    0 RPM)

Many thanks for ideas!


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
