From: Udo van den Heuvel <udovdh@xs4all.nl>
Date: Fri, 14 Dec 2007 15:01:09 +0000
Subject: Re: [lm-sensors] k8temp weirdness, it8716 questions
Message-Id: <47629AB5.8000808@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <475FFF23.2070800@xs4all.nl>
In-Reply-To: <475FFF23.2070800@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> This leaves temp1 and temp2 for the CPU and system temperatures, or
> vice-versa. Usually the CPU uses a thermal diode and the system a
> thermistor so it's easy to tell them apart, but in your case these are
> two thermistors. To find out which is which, just run a CPU-intensive
> task and check which temperature is rising faster - that will be the
> CPU sensor. And the other one is the system temperature sensor.

temp2 appears to be getting the hottest, so should be CPU.
Anyone able to confirm this for a Gigabyte M56S-S3 board?

> 
> If you come up with a good configuration file for that board, please
> submit it and we'll add it to our collection.
> 

Ok, current working config for M56S-S3 board:

chip "it8716-*"

# Voltages

    label  in0  "VCore"
    label  in1  "VDDR"
    label  in2  "+3.3V"    # VCC3
    label  in3  "+5V"      # VCC
    label  in4  "+12V"
#   label  in5  "unknown"  # need input on function
    ignore in6
    label  in7  "5VSB"     # VCCH
    label  in8  "VBat"

    compute in3  ((6.8/10)+1)*@ , @/((6.8/10)+1)
    compute in4  ((30/10)+1)*@  , @/((30/10)+1)
#   compute in5  (1+232/56)*@ - 4.096*232/56 , (@ + 4.096*232/56)/(1+232/56)
#   compute in6  (1+120/56)*@ - 4.096*120/56 , (@ + 4.096*120/56)/(1+120/56)
    compute in7  ((6.8/10)+1)*@ , @/((6.8/10)+1)

# Temperatures

# If you are lucky, the BIOS has set the proper sensor types for you.
# If your temperature readings are completely whacky you probably
# need to change the sensor types. Adujst and uncomment the
# appropriate lines below.
#
# 2 = thermistor; 3 = thermal diode; 0 = unused
   set sensor1  2
   set sensor2  2
   set sensor3  3

# If a given sensor isn't used, you will probably want to ignore it
# as well (see ignore statement right below).
# The CPU sensor can be any of temp1, temp2 or temp3 - it's motherboard
# dependent. Same for the motherboard temperature.

   label  temp2  "CPU Temp"
   label  temp1  "M/B Temp"
   ignore temp3

   set temp1_over  50
   set temp1_low   10
   set temp2_over  60
   set temp2_low   10

# Fans

# The CPU fan can be any of fan1, fan2 or fan3 - it's motherboard
# dependent. Same for the case fan.

   label  fan1 "CPU Fan"
   label  fan2 "Case Fan"


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
