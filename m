From: Tim Boundy <gigaplex@gmail.com>
Date: Sat, 11 Feb 2012 15:30:20 +0000
Subject: [lm-sensors] Intel QST support in lm-sensors
Message-Id: <CABTLOnbwMtc2a1heEiJ3tFrUFY_2K-Gei=F3SB0W7NTZcv-DxA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've been reading through some old threads regarding support for Intel
QST in lm-sensors which have largely died out due to lack of
information from Intel or lack of functional kernel drivers etc. I've
just had a go at getting the Intel QST SDK up and running on my
machine and managed to get the sample StatTest application working.
The SDK was written against an old heci driver, but there's a new mei
driver in the mainline kernel (/dev/mei) which required a minor patch
to the Intel QST SDK (see https://github.com/gigaplex/Intel_QST_SDK).

Sample output:

tim@silverstone ~/Downloads/Intel_QST_SDK/src/Programs/StatTest/Unix $
sudo ./StatTest

Intel(R) Quiet System Technology Status Display Demo
Copyright (C) 2007-2008, Intel Corporation. All Rights Reserved.

The QST Subsystem is configured and operational

Current Lock Mask:

   Configuration:        Locked
   Health Thresholds:    Unlocked
   Manual Fan Control:   Unlocked
   SST Bus Resources:    Read-Only
   Chipset Resources:    Read-Only

Sensor Configuration/Status Summary:

   Temperature Sensor 1:

      Health:            Normal
      Usage:             Processor Temperature
      Reading:           58.21

      NonCrit:           66.000
      Crit:              68.000
      NonRecov:          70.000

   Temperature Sensor 2:

      Health:            Normal
      Usage:             Motherboard Temperature
      Reading:           45.25

      NonCrit:           80.000
      Crit:              85.000
      NonRecov:          90.000

   Temperature Sensor 3:

      Health:            Normal
      Usage:             Ambient Air Temperature
      Reading:           48.64

      NonCrit:           55.000
      Crit:              60.000
      NonRecov:          65.000

   Temperature Sensor 4:

      Health:            Normal
      Usage:             Motherboard Temperature
      Reading:           53.12

      NonCrit:           80.000
      Crit:              85.000
      NonRecov:          90.000

   Temperature Sensor 5:

      Health:            Normal
      Usage:             I/O Controller Hub Temperature
      Reading:           97.26

      NonCrit:           105.000
      Crit:              110.000
      NonRecov:          120.000

   Temperature Sensor 6:

      Health:            Normal
      Usage:             Memory Controller Hub Temperature
      Reading:           77.67

      NonCrit:           100.000
      Crit:              105.000
      NonRecov:          110.000

   Fan Speed Sensor 1:

      Health:            Normal
      Usage:             Processor Thermal Module Fan
      Reading:           1063

      NonCrit:           300.000
      Crit:              250.000
      NonRecov:          200.000

   Voltage Sensor 1:

      Health:            Normal
      Usage:             +12 Volts
      Reading:           12.138

      NonCrit Low:       11.400
      Crit Low:          11.100
      NonRecov Low:      10.800

      NonCrit High:      12.600
      Crit High:         12.900
      NonRecov High:     13.200

   Voltage Sensor 2:

      Health:            Normal
      Usage:             +5 Volts
      Reading:           5.130

      NonCrit Low:       4.750
      Crit Low:          4.625
      NonRecov Low:      4.500

      NonCrit High:      5.250
      Crit High:         5.375
      NonRecov High:     5.500

   Voltage Sensor 3:

      Health:            Normal
      Usage:             +3.3 Volts
      Reading:           3.307

      NonCrit Low:       3.135
      Crit Low:          3.053
      NonRecov Low:      2.970

      NonCrit High:      3.465
      Crit High:         3.548
      NonRecov High:     3.630

   Voltage Sensor 4:

      Health:            Normal
      Usage:             +1.5 Volts
      Reading:           1.274

      NonCrit Low:       1.100
      Crit Low:          1.050
      NonRecov Low:      1.000

      NonCrit High:      1.550
      Crit High:         1.600
      NonRecov High:     1.650

   Voltage Sensor 5:

      Health:            Normal
      Usage:             Processor Vcc
      Reading:           1.291

      NonCrit Low:       0.897
      Crit Low:          0.797
      NonRecov Low:      0.697

      NonCrit High:      1.497
      Crit High:         1.597
      NonRecov High:     1.697

Fan Speed Controller Configuration/Status Summary:

   Fan Speed Controller 1:

      Health:            Normal
      Usage:             Processor Fan Controller
      Control:           Manual
      Duty Cycle:        2.95

   Fan Speed Controller 2:

      Health:            Normal
      Usage:             Chassis Fan Controller
      Control:           Automatic
      Duty Cycle:        30.56


End of Report


My machine is using an Intel DG965MQ motherboard, running Arch Linux
with kernel 3.2.5. Perhaps now is a good time for a lm-sensors
developer to take another look at this?

Cheers,
Tim Boundy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
