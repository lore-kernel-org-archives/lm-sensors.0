From: "Dominik Egert" <dominik.egert@gmx.de>
Date: Thu, 27 Feb 2014 11:26:46 +0000
Subject: [lm-sensors] sensors.conf for Gigabyte B75-D3V
Message-Id: <005901cf33ae$ccc48130$664d8390$@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

 

after playing around for a day or so, i've come up with a new config file
for the Gigabyte B75-D3V Mainboard.

The chip in use is the it8728, and sensor input is differently wired to
other Gigabyte mainboards. 

 

I wasn't able to ignore the sensors from pkg-*

Also the acpitz-* dies not give reasonable values, they don't change at all.

 

BTW: It would be nice to have a Webpage/DB to contribute configurations
utilizing a webform.

 

Greetings

 

 

Here it is, with most reasonable values:

 

# libsensors configuration file

# -----------------------------

#

#  For the Gigabyte B75-D3V Rev: 1.2

#

#

#

 

                ######################################

                # VOLTAGES                           #

                # These figures are from estimations #

                # based on values provided in BIOS.  #

                # This means that some of them may   #

                # be mixed up.                       #

                ######################################

 

 

##############################################

chip "it8728-isa-0a30"

 

# Fans

 

                label      fan1                      "CPU-Fan"

                                               set
fan1_min 1000

                                               

                label      fan2                      "System Fan 1"

                                               set
fan2_min 450

                                               

                label      fan3                      "System Fan 2"

                                               set
fan3_min 450

 

                label      fan4                      "System Fan 3"

                                               set
fan4_min 450

 

                ignore   fan5                      #"Chassis Fan"

                                               set
fan5_min 450

 

 

# Temperatures

 

                label      temp1                  "CPU Chip Temperature"

                                               set
temp1_min 10

                                               set
temp1_max 60

                                               

                ignore   temp2                  #"Unknown"

                                               set
temp2_min 10

                                               set
temp2_max 60

 

                label      temp3                  "System Temperature"

                                               set
temp3_min 10

                                               set
temp3_max 55

 

 

# Voltages                                         

                               

                label      in1                         "+3.3V"

                                               set
in1_min 3.135

                                               set
in1_max 3.465

 
compute in1 1.635*@,@/1.635

 

                label      in3                         "+5V"

                                               set
in3_min 4.750

                                               set
in3_max 5.250

 
compute in3 2.5*@,@/2.5

 

                label      in2                         "+12V"

                                               set
in2_min 11.40

                                               set
in2_max 12.60

 
compute in2 6.0*@,@/6.0

 

                label      in7                                         "3.3
VSB"

                                               set
in7_min 3.15

                                               set
in7_max 3.45

 

                label      in4                         "Vaxg IGD"

                                               set
in4_min 0.80

                                               set
in4_max 1.00

 

                label      in5                                         "CPU
Vcore"

                                               set
in5_min 0.75

                                               set
in5_max 1.15

                

                label      in6                                         "Dram
Voltage"

                                               set
in6_min 1.45

                                               set
in6_max 1.55

 

                label      in0                         "Vtt"

                                               set
in0_min 1.02

                                               set
in0_max 1.08

 

                label      in8
"Vbat"

                                               set
in0_min 2.70

                                               set
in0_max 3.30

 

 

# Other sensor readings

                label      intrusion0           "Chassis Open"

 

 

 

 

 

##############################################

chip "coretemp-*"

 

                label      temp1                  "CPU Chip Temperature"

                label      temp2                  "CPU Core 1 Temperature"

                label      temp3                  "CPU Core 2 Temperature"

 

 

                                               

##############################################

chip "pkg-*"

 

                label      temp1                  "ACPI Thermal CPU"

 

 

##############################################

chip "acpitz-virtual-0"

 

                label      temp1                  "ACPI Thermal Zone 0
Temp1"

                label      temp2                  "ACPI Thermal Zone 0
Temp2"

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
