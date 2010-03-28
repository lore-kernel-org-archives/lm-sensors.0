From: Reimundo Heluani <rheluani@gmail.com>
Date: Sun, 28 Mar 2010 16:19:42 +0000
Subject: [lm-sensors] w83627ef  acpi conflicts
Message-Id: <1269793182.7864.5.camel@campari>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello list, I am trying to diagnose a loud fan on an ASUS p5q3 deluxe.
The chip recognized by sensors-detect is 

* ISA bus, address 0x290
    Chip `Winbond W83667HG Super IO Sensors' (confidence: 9)

But on loading the driver I get

[1556449.413770] w83627ehf: Found W83667HG chip at 0x290
[1556449.413803] ACPI: I/O resource w83627ehf [0x295-0x296] conflicts
with ACPI region HWRE [0x290-0x299]
[1556449.413806] ACPI: If an ACPI driver is available for this device,
you should use it instead of the native driver

I am completely clueless and have no clue how to proceed.

I am running 

$ uname -a
Linux campari 2.6.32-gentoo-r3 #1 SMP PREEMPT Sat Feb 6 16:39:11 PST
2010 x86_64 Intel(R) Core(TM)2 Extreme CPU Q6850 @ 3.00GHz GenuineIntel
GNU/Linux

I couldn't find much info except an old thread in this list about this
mobo.

Cheers,

R.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
