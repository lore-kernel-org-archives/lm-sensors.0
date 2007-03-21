From: curt@curtronics.com (Curt Blank)
Date: Wed, 21 Mar 2007 18:26:17 +0000
Subject: [lm-sensors] MSI K9N4 SLI-F setting fan divisor
Message-Id: <Pine.LNX.4.63.0703211322200.2958@www.curtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Motherboard: MSI K9N4 SLI-F
Chipset: nVidia nForce 500 SLI
SuSE Linux 10.1
Kernel: 2.6.16.27-0.9
Driver: w83627ehf

How do I set the fan divisor? I have this in my sensors.conf file:

   set fan3_div    8
   set fan4_div    8
   set fan5_div    8

in the proper place. I get this when I do a sensors -s:

Error: Line 2476: Failed to set feature
Error: Line 2477: Failed to set feature
Error: Line 2478: Failed to set feature
w83627dhg-isa-0a10: At least one "set" statement failed

Those 3 "Error: Line"s are those 3 set div commands.

The set fanN_min statements work.

-Curt Blank


