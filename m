From: Paul Crawford <psc@sat.dundee.ac.uk>
Date: Wed, 20 Jun 2012 20:29:50 +0000
Subject: [lm-sensors] Configuration for EL620-C motherboard
Message-Id: <4FE232BE.7060409@sat.dundee.ac.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060009060602020000000704"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060009060602020000000704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached is the sensors configuration file for the DFI EL620-C 
industrial motherboard (it has ISA slots which we need), details of 
which are here:

http://www.dfi.com/products/ProductDetails.jsp?productId=7136&mainCategoryId=1&subCategoryId=66

We were impressed that our query about the sensors chip was answered 
quickly and comprehensively!

Hopefully the figures used are all correct, but if not we would 
appreciate such feedback.

Regards, Paul
-- 
Dr. Paul S. Crawford
Satellite Station
Dundee University
Small's Wynd, Dundee,
DD1 4HN, U.K.
The University of Dundee is a Scottish Registered Charity, No. SC015096

--------------060009060602020000000704
Content-Type: text/plain; charset=UTF-8;
 name="sensors.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sensors.conf"

# lm_sensors configuration file for DFI Itox EL620-C industrial motherboard
# 2012-06-20, Paul Crawford <psc@sat.dundee.ac.uk>
# Based on feedback from DFI and the schematic sheet 15 of 24, revision A1, 28 October 2011

# Winbond W83627DHG configuration for EL620-C
chip "w83627dhg-*"

    label in0 "VCore"
    label in1 "+5V"
    label in2 "AVCC"
    label in3 "+3.3V"
    label in4 "+1.1V"
    label in5 "Vmemory"
    label in6 "+12V"
    label in7 "Vstandby"
    label in8 "VBAT"
    
# +12V and +5V use dividers from schematic
    compute in1 @*(1+(30.1/10)),  @/(1+(30.1/10))
    compute in6 @*(1+(60.4/10)),  @/(1+(60.4/10))

# We need to set voltage limits. Note you may need to adapt in0 depending on your CPU
    set in0_min   0.9
    set in0_max   1.7

    set in1_min   5.0*0.95
    set in1_max   5.0*1.05

    set in2_min   3.3*0.95
    set in2_max   3.3*1.05

    set in3_min   3.3*0.95
    set in3_max   3.3*1.05

    set in4_min   1.1*0.95
    set in4_max   1.1*1.05

# DDR3 voltage ranges?
    set in5_min   1.30
    set in5_max   1.65

# Original ATX spec was +/-10% on +12V, but recent ATX12V version 2.2 spec is 5% (still 10% on unmonitored -12V)
    set in6_min   12.0*0.95
    set in6_max   12.0*1.05

    set in7_min   3.3*0.95
    set in7_max   3.3*1.05

# Battery voltage, assume CR2032 Lithium-Manganese Dioxide Battery.
# This actually seems not to be needed as hard-coded?
    set in8_min   2.7
    set in8_max   3.3

# Fans
   label fan1		"System fan"
   label fan2		"CPU Fan"
   label fan3		"2nd fan"
   ignore fan4
   ignore fan5
   
# Fan minimums, disable fan1 & fan2 as a case fan is not always connected
  set fan1_min    0
  set fan2_min    500
  set fan3_min    0  

# Temperatures. Can we assume temp2 limit for CPU is set by BIOS?

   label temp1     "Board temp #1"
   label temp2     "CPU Temp"
   label temp3     "Board temp #2"

   set temp1_max       65
   set temp1_max_hyst  55

   set temp3_max       65
   set temp3_max_hyst  55

# Not sure what this is, always reported 0.000 and the VID0-VID7 pins are not connected on schematic.
   ignore cpu0_vid
	
# From the Intel CPU itself? Seems not to need any special configuration.
#chip "coretemp-*"


--------------060009060602020000000704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060009060602020000000704--
