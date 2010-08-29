From: Glen <journeay@gmail.com>
Date: Sun, 29 Aug 2010 12:58:19 +0000
Subject: Re: [lm-sensors] Config file for Gigabyte MA785GM-US2H
Message-Id: <1283086699.2947.49.camel@honcho>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-P/g7QQp7Bshjasacgjs4"
List-Id: <lm-sensors.vger.kernel.org>
References: <1281670026.2676.3.camel@honcho>
In-Reply-To: <1281670026.2676.3.camel@honcho>
To: lm-sensors@vger.kernel.org


--=-P/g7QQp7Bshjasacgjs4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Jean,

Sorry for the late response.  I based this off of a file called
sensors-Gigabyte-965P-DS3.conf taken from here:

http://khali.linux-fr.org/devel/lm-sensors/sensors-Gigabyte-965P-DS3.conf

I found the reference here:

http://www.lm-sensors.org/ticket/2273


Sorry about the date, and not correcting the comment about scaling,
although I have to admit, scaling in0 is dubious.  I did it to make the
lm-sensor readings match the BIOS readings, but the BIOS reading is
somewhat high for an Athlon II X2 245 which should be 0.85 to 1.425 V
from the specs I can find on the web.  Thanks for also pointing out the
errors in setting the temp limits, I did bang this one out rather
quickly.  Plus, I'm still not sure exactly sure what components the
temps are really reading.

I've attached an updated file.

Glen

On Thu, 2010-08-19 at 18:27 +0200, Jean Delvare wrote:
> Hi Glen,
> 
> On Thu, 12 Aug 2010 20:27:06 -0700, Glen wrote:
> > Here's a config file I worked up for the Gigabyte MA758GM-US2H.  It's
> > based off of one taken from your web site. This is NOT confirmed by
> > examination of the MB, just by observed readings.
> 
> Out of curiosity, which configuration file did you start from?
> 
> > # lm_sensors configuration file for the Gigabyte MA785GM-US2H motherboard
> > # 8-12-2010 G. Journeay <journeay@gmail.com>
> 
> Please follow ISO-8601 for dates, otherwise it's ambiguous. I read the
> above as December 8th, withe you certainly meant August 12th.
> 
> > ### Voltages
> > 
> >    label  in0  "Vcore"
> >    label  in1  "Vram"    # "DDR2" in BIOS
> >    label  in2  "+3.3V"
> >    label  in3  "+5V"     # Not in BIOS
> >    ignore in4
> >    ignore in5
> >    ignore in6
> >    label  in7  "+12V"
> >    label  in8  "Vbat"    # Not in BIOS
> > 
> >    # Vcore, Vram, +3.3V and Vbat are connected directly, so no compute
> >    # line is needed for these. For +5V the chip is configured to use
> >    # internal scaling. For +12V the default resistors seem to have been
> >    # used.
> >    compute  in0  @ * (  3/10+1), @ / (  3/10+1)
> 
> This is inconsistent. You just said that Vcore didn't need any scaling,
> yet you have a compute statement for Vcore. In all honestly, I would be
> very surprised if it were correct... Vcore is never scaled, it doesn't
> need to (it's way below the +4.08V limit.) How did you come up with it?
> 
> >    compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)
> >    compute  in7  @ * ( 45/10+1), @ / ( 45/10+1)
> 
> > ### Temperatures
> > 
> >    label  temp1  "CPU Temp"
> >    label  temp3  "NBr Temp"
> >    label  temp2  "MB Temp"
> 
> Would be more intuitive to leave them in order.
> 
> >    set temp1_min 0
> >    set temp1_max 60
> >    set temp2_min 0
> >    set temp3_max 50
> >    set temp3_min 0
> >    set temp3_max 50
> 
> You're setting temp3_max twice, and you're never setting temp2_max.
> 


--=-P/g7QQp7Bshjasacgjs4
Content-Disposition: attachment; filename="sensors-Gigabyte MA785GM-US2H.conf"
Content-Type: text/plain; name="sensors-Gigabyte MA785GM-US2H.conf"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

# lm_sensors configuration file for the Gigabyte MA785GM-US2H motherboard
# 2010-8-12 G. Journeay <journeay@gmail.com>
# Comments welcome!

chip "it8718-*"

### Voltages

   label  in0  "Vcore"
   label  in1  "Vram"    # "DDR2" in BIOS
   label  in2  "+3.3V"
   label  in3  "+5V"     # Not in BIOS
   ignore in4
   ignore in5
   ignore in6
   label  in7  "+12V"
   label  in8  "Vbat"    # Not in BIOS

   # Vram, +3.3V and Vbat are connected directly, so no compute
   # line is needed for these. For +5V the chip is configured to use
   # internal scaling. For Vcore and +12, compute values derived from 
   # comparison of BIOS values and raw readings from lm sensors.

   compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)
   compute  in7  @ * ( 45/10+1), @ / ( 45/10+1)

   # The BIOS won't set any limit for voltages.

   set in0_min 0.85
   set in0_max 1.425
   set in1_min 1.8 * 0.95
   set in1_max 1.8 * 1.05
   set in2_min 3.3 * 0.95
   set in2_max 3.3 * 1.05
   set in3_min   5 * 0.95
   set in3_max   5 * 1.05
   set in7_min  12 * 0.95
   set in7_max  12 * 1.05

### Temperatures

   label  temp1  "CPU Temp"
   label  temp3  "NBr Temp"
   label  temp2  "MB Temp"

   set temp1_min 0
   set temp1_max 60
   set temp2_min 0
   set temp2_max 50
   set temp3_min 0
   set temp3_max 50

### Fans

   label  fan1  "CPU Fan"
   label  fan2  "SYS Fan"
   ignore fan3
   label  fan4  "NB Fan"  

   # Adjust for your own fans
   set fan1_min 1000
   set fan4_min 1000

--=-P/g7QQp7Bshjasacgjs4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-P/g7QQp7Bshjasacgjs4--

