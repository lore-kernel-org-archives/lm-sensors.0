From: "J. Cheetham" <jamie@softham.co.uk>
Date: Sun, 07 Oct 2012 14:18:01 +0000
Subject: [lm-sensors] Conf file for ASUS F1A75-M motherboard
Message-Id: <50718F19.3020308@softham.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I thought this could be useful to people:


# ASUS F1A75-M motherboard with AMD APU (and Radeon Graphics)
# K. J. Cheetham, October 2012

chip "it8728-isa-*"

    # Voltages

    label in0 "Vcore"
    set in0_min 1.0
    set in0_max 1.5

    ignore in1 # Always 2.22 - don't know why

    label in2 "+12V"
    compute in2 @ * (77/12), @ / (77/12)
    set in2_min 12 * 0.95
    set in2_max 12 * 1.05

    label in3 "+5V1"
    compute in3 @ * (30/12), @ / (30/12)
    set in3_min 5 * 0.95
    set in3_max 5 * 1.05

    label in4 "+5V2"
    compute in4 @ * (30/12), @ / (30/12)
    set in4_min 5 * 0.95
    set in4_max 5 * 1.05

    ignore in5 # Always 2.22 - don't know why
    ignore in6 # Always 2.22 - don't know why

    label in7 "3VSB"
    set in7_min 3.3 * 0.95
    set in7_max 3.3 * 1.05

    label in8 "Vbat"

    # Temperatures

    label temp1 "CPU Temp"
    label temp2 "M/B Temp"
    ignore temp3 # Not used; always +127.0C

    # Fans

    label fan1 "CPU Fan"
    set fan1_min 600
    label fan2 "Chassis Fan"
    set fan2_min 600
    label fan3 "PSU Fan"
    set fan3_min 600
    ignore fan4 # Not used

    label intrusion0 "Intrusion"

chip "k10temp-pci-*"

   label temp1 "Core Temp"

chip "radeon-pci-*"

   label temp1 "GPU Temp"


-- 
K. J. Cheetham

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
