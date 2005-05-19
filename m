From: abehn@gmx.net (Andreas Behnert)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: Soyo D6IBA2, success, valid sensors.conf, Feedback
Message-Id: <31501.1039299132@www45.gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you for your lm-sensors package, I'm using it since some time on
many boxes and finally found the time to put it on the fileserver:
Soyo D6IBA2
(ftp://ftp.soyo.de/support/d6/d6iba2/manuals/md6iba210.pdf),
Dual Slot1, w83781d, some non-winbond-standard wiring, complete
and working sensors.conf for this board and lm-sensors 2.6.5 follows:

~~~snip~~~
# Soyo SY-D6IBA2
# Intel BX, Dual Slot 1
#
# temp1 = system
# temp2 = CPU1
# temp3 = CPU2

chip "w83781d-*"

    label in0 "VCoreCPU1"
    label in1 "VCoreCPU2"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"
    label in5 "-12V"
    label in6 "-5V"
    label fan1 "Fan CPU1"
    label fan2 "Fan CPU2"
    label temp1 "Temp Syst"
    label temp2 "Temp CPU1"
    label temp3 "Temp CPU2"

# Winbond default declarations:

    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
    compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
    compute in5 -(210/60.4)*@  ,  -@/(210/60.4)
    compute in6 -(90.9/60.4)*@ ,  -@/(90.9/60.4)

# With a P3-450 Katmai (VCore 2,0V) "sensors" output shows a vid
# value of "+20.00V" on the SY-D6IBA2. A simple "cat
# /proc/sys/dev/sensors/w83781d-isa-0290/vid" correctly says "2.000"
# instead. Hmmm. Unfortunately I have no non-VCore-2.0-Slot1-CPU
# available for testing and because of this the next line works for me  :)

    compute vid @/10 , @*10

# Here, we assume the VID readings are valid, and we use a max. 5%
# deviation

    set in0_min vid*0.95
    set in0_max vid*1.05
    set in1_min vid*0.95
    set in1_max vid*1.05
    set in2_min 3.3 * 0.95
    set in2_max 3.3 * 1.05
    set in3_min 5.0 * 0.95
    set in3_max 5.0 * 1.05
    set in4_min 12 * 0.95
    set in4_max 12 * 1.05
    set in5_max -12 * 0.95
    set in5_min -12 * 1.05
    set in6_max -5 * 0.95
    set in6_min -5 * 1.05

# examples for w83781d temperature limits
    set temp1_over 45
    set temp1_hyst 127
    set temp2_over 65
    set temp2_hyst 65
    set temp3_over 65
    set temp3_hyst 65

# Fan Limits
    set fan1_min 2600
    set fan2_min 2600

# Fan3 (system/chassis) connector available but don't need it
    ignore fan3
~~~snip~~~
 
Works like a charm, except the mysterious vid value, but it's ok for me :)

Kind regards,

Andreas

-- 
To err is human; effective mayhem requires the root password :-)
--

+++ GMX - Mail, Messaging & more  http://www.gmx.net +++
NEU: Mit GMX ins Internet. Rund um die Uhr f?r 1 ct/ Min. surfen!
