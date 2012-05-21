From: James <bjlockie@lockie.ca>
Date: Mon, 21 May 2012 13:45:53 +0000
Subject: [lm-sensors] ASRock 970 Extreme3
Message-Id: <4FBA4711.3090609@lockie.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I use the nct6776-isa-0290
Adapter: ISA adapter

I have 3 fans:
1. The CPU fan (about 3300 RPM)
2. The rear case fan (about 1050 RPM)
3. The front case fan (about 1350 RPM)

Do the fans in Power Supplies typically get monitored?

I have 6 fan connectors:
1. Chassis fan connector (#12 on the motherboard)
2. Chassis fan connector (#15 on the motherboard)
3. Chassis fan connector (#2 on the motherboard)
1. CPU fan connector (#6 on the motherboard)
2. CPU fan connector (#5 on the motherboard)
1. Power fan connector (#10 on the motherboard)

Maybe someone can see a pattern.

1. I plugged the rear case fan in #12
fan1 was 1060 RPM (the rear case fan probably)
fan2 was 3300 RPM (the CPU  fan probably)
other fans reported 0 RPMs

2. I plugged the rear case fan in #2
all fans reported 0 RPM
other fans reported 0 RPMs

3. I plugged the rear case fan in #12 and the front case fan in #15.
fan1 was 1053 RPM (the rear case fan probably)
fan2 was 3316 (the CPU fan probably)
other fans reported 0 RPMs

4. I plugged the rear case fan in #10 and the front case fan in #12.
fan1 was 1384 (the front case fan probably)
other fans reported 0 RPMs

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
