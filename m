From: Valentijn Scholten <valentijnscholten@hotmail.com>
Date: Thu, 23 Jun 2011 21:26:28 +0000
Subject: Re: [lm-sensors] Intel(r) Quiet System Technology (QST) SDK Is Now
Message-Id: <loom.20110623T232310-485@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <D9E26691B3D231438C54820E5AB9FA656B976FEC@azsmsx501.amr.corp.intel.com>
In-Reply-To: <D9E26691B3D231438C54820E5AB9FA656B976FEC@azsmsx501.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Pearson, Scott <scott.pearson <at> intel.com> writes:

>  eration chipset. Thus, in theory, to support (for example) the Series 5 
chipset, all you should need to do is
> add support for the appropriate ids and you are done. If you look in the 
driver source at file heci.h, you
> will see a list of definitions for the ids that are supported. In file 
heci_main.c, you will see these
> definitions used to form a search list. Simply expand the definitions and list 
to include the id(s) for the
> missing generation(s) and you should be good to go. The ids can typically be 
found in the particular
> chipset's Specification Update document...
I found an interesting post on the intel forums containing some intel patch info 
the get the heci driver working with the newer chipsets.

I just compiled the heci driver and can confirm it works with Intel QST SDK on a 
DH55TC motherboard. Running Debian Squeeze = kernel 2.6.32.
On 2.6.36+kernels the driver doesn't compile due to some ioctl changes.

Output:


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
      Reading:           30.60

      NonCrit:           95.000
      Crit:              97.000
      NonRecov:          99.000

   Temperature Sensor 3:

      Health:            Normal
      Usage:             Peripheral Controller Hub (PCH) Temperature
      Reading:           59.00

      NonCrit:           110.000
      Crit:              114.000
      NonRecov:          117.000

   Temperature Sensor 4:

      Health:            Normal
      Usage:             Voltage Regulator Temperature
      Reading:           43.00

      NonCrit:           113.000
      Crit:              117.000
      NonRecov:          121.000


   Temperature Sensor 5:

      Health:            Normal
      Usage:             Memory DIMM Temperature
      Reading:           34.00

      NonCrit:           113.000
      Crit:              117.000
      NonRecov:          121.000

   Fan Speed Sensor 1:

      Health:            Normal
      Usage:             Processor Fan
      Reading:           644

      NonCrit:           300.000
      Crit:              250.000
      NonRecov:          200.000

   Voltage Sensor 1:

      Health:            Normal
      Usage:             +12 Volts
      Reading:           12.172

      NonCrit Low:       11.400
      Crit Low:          11.100
      NonRecov Low:      10.800

      NonCrit High:      12.600
      Crit High:         12.900
      NonRecov High:     13.200

   Voltage Sensor 2:


      Health:            Normal
      Usage:             +5 Volts
      Reading:           4.937

      NonCrit Low:       4.750
      Crit Low:          4.625
      NonRecov Low:      4.500

      NonCrit High:      5.250
      Crit High:         5.375
      NonRecov High:     5.500

   Voltage Sensor 3:

      Health:            Normal
      Usage:             +3.3 Volts
      Reading:           3.286

      NonCrit Low:       3.135
      Crit Low:          3.053
      NonRecov Low:      2.970

      NonCrit High:      3.465
      Crit High:         3.548
      NonRecov High:     3.630

   Voltage Sensor 4:

      Health:            Normal
      Usage:             +1.5 Volts
      Reading:           1.533

      NonCrit Low:       1.425
      Crit Low:          1.415
      NonRecov Low:      1.400

      NonCrit High:      1.575
      Crit High:         1.585
      NonRecov High:     1.600


   Voltage Sensor 5:

      Health:            Normal
      Usage:             Processor Vcc
      Reading:           0.932

      NonCrit Low:       0.463
      Crit Low:          0.363
      NonRecov Low:      0.263

      NonCrit High:      1.863
      Crit High:         1.963
      NonRecov High:     2.063

Fan Speed Controller Configuration/Status Summary:

   Fan Speed Controller 1:

      Health:            Normal
      Usage:             Processor Fan Controller
      Control:           Automatic
      Duty Cycle:        20.00

   Fan Speed Controller 2:

      Health:            Normal
      Usage:             Chassis Inlet Fan Controller
      Control:           Automatic
      Duty Cycle:        30.00

   Fan Speed Controller 3:

      Health:            Normal
      Usage:             Chassis Outlet Fan Controller
      Control:           Automatic
      Duty Cycle:        30.00

Good news.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
