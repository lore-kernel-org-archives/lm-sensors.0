From: dmitriy <dkaliberda@ukr.net>
Date: Sat, 06 Nov 2010 16:44:27 +0000
Subject: [lm-sensors] lm_sensors configuration file for the Gigabyte
Message-Id: <1289061867.17977.3.camel@dmitriy-desktop.ererw.dfg>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8796582194243450257=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============8796582194243450257==
Content-Type: multipart/alternative; boundary="=-vEXB8++DE0tQuBZVBIhL"


--=-vEXB8++DE0tQuBZVBIhL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

# lm_sensors configuration file for the Gigabyte GA-880GM-UD2H
motherboard
# 2010-11-6 D. Kaliberda <dkaliberda.ua@gmail.com>
# Comments welcome!

chip "k10temp-*"

label temp1 "AM10 Core"

chip "it8720-*"

### Voltages

   label  in0  "Vcore"
   label  in1  "Vram"    # "DDR2" in BIOS
   label  in2  "+3.3V"
   label  in3  "+5V"     # Not in BIOS
   label  in4  "+12V"
   ignore  in5  
   ignore  in6   
   label  in7  "+5V_SNB"	
   label  in8  "Vbat"    # Not in BIOS
   ignore cpu0_vid

   # Vcore, Vram, +3.3V and Vbat are connected directly, so no compute
   # line is needed for these. For +5V the chip is configured to use
   # internal scaling. For +12V, compute values derived from 
   # comparison of BIOS values and raw readings from lm sensors.

   compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)
   compute  in4  @ * (100/33.3+1), @ / (100/33.3+1)
   compute  in5 -@ * (240/41), -@ / (240/41)
   compute  in6 -@ * (100/81), -@ / (100/81)
   compute  in7  @ * ( 36/22+0), @ / ( 36/22+0)

   # The BIOS won't set any limit for voltages.

   set in0_min 0.8
   set in0_max 1.5
   set in1_min 1.6 * 0.95
   set in1_max 1.6 * 1.05
   set in2_min 3.3 * 0.95
   set in2_max 3.3 * 1.05
   set in3_min   5 * 0.95
   set in3_max   5 * 1.05
   set in4_min  12 * 0.95
   set in4_max  12 * 1.05
  
### Temperatures
	
   label  temp1  "CPU Temp"
   label  temp2  "MB Temp"
   label  temp3  "NBr Temp"

   set temp1_min 10
   set temp1_max 60
   set temp2_min 10
   set temp2_max 50
   set temp3_min 10
   set temp3_max 50

### Fans
   label  fan1  "CPU Fan"
   label  fan2  "SYS Fan"
   ignore  fan3
   ignore  fan4   

   # Adjust for your own fans
   set fan1_min 1000
   set fan2_min 1000
   

--=-vEXB8++DE0tQuBZVBIhL
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.28.3">
</HEAD>
<BODY>
# lm_sensors configuration file for the Gigabyte GA-880GM-UD2H motherboard<BR>
# 2010-11-6 D. Kaliberda &lt;<A HREF="mailto:dkaliberda.ua@gmail.com">dkaliberda.ua@gmail.com</A>&gt;<BR>
# Comments welcome!<BR>
<BR>
chip &quot;k10temp-*&quot;<BR>
<BR>
label temp1 &quot;AM10 Core&quot;<BR>
<BR>
chip &quot;it8720-*&quot;<BR>
<BR>
### Voltages<BR>
<BR>
&nbsp;&nbsp; label&nbsp; in0&nbsp; &quot;Vcore&quot;<BR>
&nbsp;&nbsp; label&nbsp; in1&nbsp; &quot;Vram&quot;&nbsp;&nbsp;&nbsp; # &quot;DDR2&quot; in BIOS<BR>
&nbsp;&nbsp; label&nbsp; in2&nbsp; &quot;+3.3V&quot;<BR>
&nbsp;&nbsp; label&nbsp; in3&nbsp; &quot;+5V&quot;&nbsp;&nbsp;&nbsp;&nbsp; # Not in BIOS<BR>
&nbsp;&nbsp; label&nbsp; in4&nbsp; &quot;+12V&quot;<BR>
&nbsp;&nbsp; ignore&nbsp; in5&nbsp; <BR>
&nbsp;&nbsp; ignore&nbsp; in6&nbsp;&nbsp; <BR>
&nbsp;&nbsp; label&nbsp; in7&nbsp; &quot;+5V_SNB&quot;	<BR>
&nbsp;&nbsp; label&nbsp; in8&nbsp; &quot;Vbat&quot;&nbsp;&nbsp;&nbsp; # Not in BIOS<BR>
&nbsp;&nbsp; ignore cpu0_vid<BR>
<BR>
&nbsp;&nbsp; # Vcore, Vram, +3.3V and Vbat are connected directly, so no compute<BR>
&nbsp;&nbsp; # line is needed for these. For +5V the chip is configured to use<BR>
&nbsp;&nbsp; # internal scaling. For +12V, compute values derived from <BR>
&nbsp;&nbsp; # comparison of BIOS values and raw readings from lm sensors.<BR>
<BR>
&nbsp;&nbsp; compute&nbsp; in3&nbsp; @ * (6.8/10+1), @ / (6.8/10+1)<BR>
&nbsp;&nbsp; compute&nbsp; in4&nbsp; @ * (100/33.3+1), @ / (100/33.3+1)<BR>
&nbsp;&nbsp; compute&nbsp; in5 -@ * (240/41), -@ / (240/41)<BR>
&nbsp;&nbsp; compute&nbsp; in6 -@ * (100/81), -@ / (100/81)<BR>
&nbsp;&nbsp; compute&nbsp; in7&nbsp; @ * ( 36/22+0), @ / ( 36/22+0)<BR>
<BR>
&nbsp;&nbsp; # The BIOS won't set any limit for voltages.<BR>
<BR>
&nbsp;&nbsp; set in0_min 0.8<BR>
&nbsp;&nbsp; set in0_max 1.5<BR>
&nbsp;&nbsp; set in1_min 1.6 * 0.95<BR>
&nbsp;&nbsp; set in1_max 1.6 * 1.05<BR>
&nbsp;&nbsp; set in2_min 3.3 * 0.95<BR>
&nbsp;&nbsp; set in2_max 3.3 * 1.05<BR>
&nbsp;&nbsp; set in3_min&nbsp;&nbsp; 5 * 0.95<BR>
&nbsp;&nbsp; set in3_max&nbsp;&nbsp; 5 * 1.05<BR>
&nbsp;&nbsp; set in4_min&nbsp; 12 * 0.95<BR>
&nbsp;&nbsp; set in4_max&nbsp; 12 * 1.05<BR>
&nbsp; <BR>
### Temperatures<BR>
	<BR>
&nbsp;&nbsp; label&nbsp; temp1&nbsp; &quot;CPU Temp&quot;<BR>
&nbsp;&nbsp; label&nbsp; temp2&nbsp; &quot;MB Temp&quot;<BR>
&nbsp;&nbsp; label&nbsp; temp3&nbsp; &quot;NBr Temp&quot;<BR>
<BR>
&nbsp;&nbsp; set temp1_min 10<BR>
&nbsp;&nbsp; set temp1_max 60<BR>
&nbsp;&nbsp; set temp2_min 10<BR>
&nbsp;&nbsp; set temp2_max 50<BR>
&nbsp;&nbsp; set temp3_min 10<BR>
&nbsp;&nbsp; set temp3_max 50<BR>
<BR>
### Fans<BR>
&nbsp;&nbsp; label&nbsp; fan1&nbsp; &quot;CPU Fan&quot;<BR>
&nbsp;&nbsp; label&nbsp; fan2&nbsp; &quot;SYS Fan&quot;<BR>
&nbsp;&nbsp; ignore&nbsp; fan3<BR>
&nbsp;&nbsp; ignore&nbsp; fan4&nbsp;&nbsp; <BR>
<BR>
&nbsp;&nbsp; # Adjust for your own fans<BR>
&nbsp;&nbsp; set fan1_min 1000<BR>
&nbsp;&nbsp; set fan2_min 1000<BR>
&nbsp;&nbsp; 
</BODY>
</HTML>

--=-vEXB8++DE0tQuBZVBIhL--



--===============8796582194243450257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8796582194243450257==--

