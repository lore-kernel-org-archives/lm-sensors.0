From: =?ISO-8859-1?Q?Leo_Kr=FCger?= <mail@leokrueger.de>
Date: Sat, 28 Aug 2010 23:16:17 +0000
Subject: [lm-sensors] small changes in configuration file for MSI IM-945GSE-A
Message-Id: <37bbc84b5fac675db98cc0276a74e55e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I own a MSI IM-945GSE-A motherboard and used the sample configuration file
from http://lm-sensors.org/wiki/Configurations/MSI/IM-945GSE-A,
which showed me around 14V for the 12V output.
Since this would be far above specification limits, I measured the actual
values at the ATX power connector. In addition to the 12V output, the 5V
and the 5Vsb line differed a little.
Below is my updated configuration file. Note that I just changed 3 lines,
the compute lines for in4, in5 and in6.
It would be nice if you could update the sample file in your wiki.
Let me know if any additional steps are necessary.

Regards,
Leo

# lm_sensors configuration file for the MSI IM-945GSE-A motherboard
# Atom N270, Dual Gigabit Intel 82574L controllers, VGA, DVI
# 2009-07-01 Thomas Ettwein
# 2010-08-29 Leo Krueger

chip "f71882fg-*"

# Temperature
     label temp1       "CPU"
     label temp2       "Systemboard"
     ignore temp3

# Fans
      ignore fan1 # no connector on board
      label fan2 "FAN"
      ignore fan3 # no connector on board
      ignore fan4 # no connector on board


# Voltage
     label in0         "3.3V"
     label in1         "Vcore"
     label in2         "Vdimm"
     label in3         "Vchip"
     label in4         "+5V"
     label in5         "12V"
     label in6         "5VSB"
     label in7         "3VSB"
     label in8         "Battery"

# never change the in0, in7 and in8 compute, these are hardwired in the
chip!
# in4, in5, in6 were changed to match manually measured values
     compute in0       (@ * 2), (@ / 2)
     compute in2       (@ * 2), (@ / 2)
     compute in3       (@ * 2), (@ / 2)
     compute in4       (@ * 5.23), (@ / 5.23)
     compute in5       (@ * 10.86), (@ / 10.86)
     compute in6       (@ * 5.62), (@ / 5.62)
     compute in7       (@ * 2), (@ / 2)
     compute in8       (@ * 2), (@ / 2)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
