From: Jared Raddigan <jraddigan@kfh.org>
Date: Tue, 13 Sep 2011 20:39:22 +0000
Subject: [lm-sensors] Specific Configurations SuperMicro X7SPE-HF
Message-Id: <CAK=+6WL+6fvmrtaR-myqyjDmmEF3wFfvXzgtVs5F_i0MYmw+0g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is a configuration script that I believe should be accurate to
the X7SPE-HF http://www.supermicro.com/products/motherboard/ATOM/ICH9/X7SPE.cfm?typ=H&IPMI=Y
when compared to the IPMI displays. I pruned a little and did a few
small changes for things like voltage.

File origially take from SuperMicro X7SP8 LM-sensors wiki and modified

chip "w83627dhg-*"

        label in0 "Vcore"
        label in1 "Vichcore"
        label in2 "+3.3VCC"
        ignore in3

        label in4 "Vdimm"
        label in5 "+5V"
                compute in5 @*4, @/4
        label in6 "+12V"
                compute in6 @*6.62, @/6.62
                set in6_min 12 * 0.90
                set in6_max 12 * 1.10
        label in7 "3VSB"
        label in8 "Vbat"

        ignore fan1
        label fan2 "CPU Fan"
        ignore fan3
        label fan4 "Case Fan"
        ignore fan5

        label temp1 "System Temp"
        label temp2 "CPU Temp"
        ignore temp3

        ignore cpu0_vid



Jared Raddigan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
