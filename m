From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 Feb 2011 18:39:51 +0000
Subject: Re: [lm-sensors] W83795G Supermicro H8DGU-F
Message-Id: <20110225193951.05ca1cea@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <77E104072DACA94993E7A23504E0C29F0559E9@ROCMXUS22.cs.myharris.net>
In-Reply-To: <77E104072DACA94993E7A23504E0C29F0559E9@ROCMXUS22.cs.myharris.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 25 Feb 2011 18:31:42 +0000, Ubelhart, Ray wrote:
> Hello Jean,
> 
> I am using your driver on a new Supermicro motherboard and it populates the hwmon sysfs attributes following load.  However for some reason even though I am using your information for the w83795 device in sensors.conf,  I cannot get the sensor data to appear when I execute "sensors", see information included below.   Do you have any idea what I need?  I am using CentOS 5.5 x86_64 and the lm_sensors version which is part of this distribution.
> 
> Thank you
> Ray Ubelhart
> Harris Corporation
> ray.ubelhart@harris.com<mailto:ray.ubelhart@harris.com>
> 
> 
> [root@localhost device]# pwd
> /sys/class/hwmon/hwmon0/device
> [root@localhost device]# ls
> beep_enable  fan7_min      in13_min    in5_min           temp1_input       temp5_max_hyst
> bus          fan8_alarm    in14_alarm  in6_alarm         temp1_max         temp5_source_sel
> driver       fan8_beep     in14_beep   in6_beep          temp1_max_hyst    temp5_type
> fan1_alarm   fan8_input    in14_input  in6_input         temp1_source_sel  temp6_alarm
> fan1_beep    fan8_min      in14_max    in6_max           temp1_type        temp6_beep
> fan1_input   hwmon:hwmon0  in14_min    in6_min           temp2_alarm       temp6_crit
> fan1_min     in0_alarm     in1_alarm   in7_alarm         temp2_beep        temp6_crit_hyst
> fan2_alarm   in0_beep      in1_beep    in7_beep          temp2_crit        temp6_input
> fan2_beep    in0_input     in1_input   in7_input         temp2_crit_hyst   temp6_max
> fan2_input   in0_max       in1_max     in7_max           temp2_input       temp6_max_hyst
> fan2_min     in0_min       in1_min     in7_min           temp2_max         temp6_source_sel
> fan3_alarm   in10_alarm    in2_alarm   in8_alarm         temp2_max_hyst    temp6_type
> fan3_beep    in10_beep     in2_beep    in8_beep          temp2_source_sel  temp7_alarm
> fan3_input   in10_input    in2_input   in8_input         temp2_type        temp7_beep
> fan3_min     in10_max      in2_max     in8_max           temp3_alarm       temp7_crit
> fan4_alarm   in10_min      in2_min     in8_min           temp3_beep        temp7_crit_hyst
> fan4_beep    in11_alarm    in3_alarm   in9_alarm         temp3_crit        temp7_input
> fan4_input   in11_beep     in3_beep    in9_beep          temp3_crit_hyst   temp7_max
> fan4_min     in11_input    in3_input   in9_input         temp3_input       temp7_max_hyst
> fan5_alarm   in11_max      in3_max     in9_max           temp3_max         temp7_type
> fan5_beep    in11_min      in3_min     in9_min           temp3_max_hyst    temp8_alarm
> fan5_input   in12_alarm    in4_alarm   intrusion0_alarm  temp3_source_sel  temp8_beep
> fan5_min     in12_beep     in4_beep    intrusion0_beep   temp3_type        temp8_crit
> fan6_alarm   in12_input    in4_input   name              temp4_source_sel  temp8_crit_hyst
> fan6_beep    in12_max      in4_max     power             temp5_alarm       temp8_input
> fan6_input   in12_min      in4_min     subsystem         temp5_beep        temp8_max
> fan6_min     in13_alarm    in5_alarm   temp1_alarm       temp5_crit        temp8_max_hyst
> fan7_alarm   in13_beep     in5_beep    temp1_beep        temp5_crit_hyst   temp8_type
> fan7_beep    in13_input    in5_input   temp1_crit        temp5_input       uevent
> fan7_input   in13_max      in5_max     temp1_crit_hyst   temp5_max
> [root@localhost device]# sensors
> w83795g-i2c-0-2f
> Adapter: SMBus PIIX4 adapter at 0b00
> 
> [root@localhost device]# uname -r
> 2.6.18-194.el5
> [root@localhost device]# uname -a
> Linux localhost.localdomain 2.6.18-194.el5 #1 SMP Fri Apr 2 14:58:14 EDT 2010 x86_64 x86_64 x86_64 GNU/Linux
> [root@localhost device]# cat fan1_input
> 7758
> [root@localhost device]# cat in0_input
> 988
> [root@localhost device]# cat temp1_input
> 34500
> [root@localhost device]# rpm -q lm_sensors
> lm_sensors-2.10.7-9.el5

You need lm-sensors >= 3.0.0. lm-sensors 2.10.x is obsolete and lacks
support for every recent kernel driver.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
