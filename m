From: Ian Pilcher <arequipeno@gmail.com>
Date: Mon, 05 Oct 2009 23:51:27 +0000
Subject: [lm-sensors] MSI MS-7199 (Fuzzy CN700G)
Message-Id: <hae0pv$s0p$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Trying to interpret the readings here.  Would appreciate any help/
thoughts.

This is a fanless 1GHz VIA C7 board.  (I've set it to run 800MHz via the
BIOS.)  There are 5 different temperature readings available via ACPI
and lm_sensors:

* ACPI thermal 0
* c7temp temp1
* w83627ehf temp1 (thermistor)
* w83627ehf temp2 (diode)
* w83627ehf temp3 (thermistor)

The temperatures reported by ACPI, c7temp, and w83627ehf temp2 seem to
be closely related:

                      w83627ehf
    ACPI    c7temp      temp2
    ----    ------    ---------
     17       36         17.0
     24       43         24.0
     17       38         17.5
     25       45         25.5
     26       46         26.5
     41       60         41.0
     28       47         28.5
     40       58         40.0
     41       57         41.0
     49       68         49.5

I looks like ACPI and temp2 are reporting the same thing, except that
temp2 is reporting in 1/2 degree increments, and ACPI is rounding down
to the nearest whole degree.

The difference between c7temp and temp2/ACPI ranges from 16 to 21
degrees, but there's still a strong correlation.  Could this be the
difference between a diode built in to the processor and an external
sensor?

Getting more speculative, w83627ehf temp1 may correspond to what the
BIOS calls "System Temp":

           w83627ehf
           ---------
    temp1    temp2    temp3
    -----    -----    -----
     29.0     17.0     44.5
     30.0     24.0     45.5
     30.0     17.5     45.0
     29.0     25.5     46.0
     42.0     26.5     44.5
     44.0     41.0     46.0
     42.0     28.5     45.0
     44.0     40.0     46.5
     49.0     41.0     45.0
     50.0     49.5     46.0

Notice that temp1 is significantly higher than temp2 in the "idle" case,
and it also varies less.  Does it make sense for the "system" (north-
bridge?) to be hotter than the CPU in a system like this?

temp3 seems to be garbage.

Thoughts?  Thanks!

-- 
====================================
Ian Pilcher                                         arequipeno@gmail.com
====================================


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
