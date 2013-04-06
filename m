From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 06 Apr 2013 07:21:32 +0000
Subject: [lm-sensors] sensor configuration file for Supermicro C7H61
Message-Id: <20130406072132.GA28618@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


chip "nct6776-isa-0a30"

    label in0 "Vcore"
    label in1 "12V"
    label in2 "AVCC"
    label in3 "+3.3V"
    label in4 "VDIMM"
    label in5 "5VCC"
    label in6 "VTT_CPU"
    label in7 "3VSB"
    label in8 "Vbat"

    compute in1   @*6.6, @/6.6
    compute in5   @*4, @/4

    # min/max values are set by the BIOS

    ignore fan1
    label fan2 "System FAN4"
    label fan3 "CPU Fan"
    label fan4 "System FAN2"
    label fan5 "System FAN3"


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
