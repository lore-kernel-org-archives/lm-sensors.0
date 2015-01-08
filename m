From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 08 Jan 2015 20:29:19 +0000
Subject: [lm-sensors] hwmon strangeness, no fan control on w83627dhg
Message-Id: <20150108202919.GA25118@amd>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

hwmon is quite incosistent on my machine: in hwmon0 case, temperature
files are in directly in hwmon0 subdirectory, but in hwmon1 case, they
are in hwmon1/device/ . Is that expected? Why is it so?

root@amd:/sys/class/hwmon# ls hwmon0/
device			   subsystem	  temp2_input  temp3_crit
temp3_label
name	temp2_crit	  temp2_label  temp3_crit_alarm  temp3_max
power	temp2_crit_alarm  temp2_max    temp3_input	  uevent
root@amd:/sys/class/hwmon# ls hwmon1/
device/    power/     subsystem/ uevent
root@amd:/sys/class/hwmon# ls hwmon1/device
cpu0_vid		    in0_alarm  in6_alarm	       pwm2
 pwm4_stop_output
 driver		 in0_input  in6_input	       pwm2_enable
 pwm4_stop_time
 driver_override  in0_max    in6_max	       pwm2_max_output
 pwm4_target
 fan1_alarm	 in0_min    in6_min	       pwm2_mode
 pwm4_tolerance
 fan1_div	 in1_alarm  in7_alarm	       pwm2_start_output
 subsystem
 fan1_input	 in1_input  in7_input	       pwm2_step_output
 temp1_alarm
 fan1_min	 in1_max    in7_max	       pwm2_stop_output
 temp1_input
 fan2_alarm	 in1_min    in7_min	       pwm2_stop_time
 temp1_max
 fan2_div	 in2_alarm  in8_alarm	       pwm2_target
 temp1_max_hyst
 fan2_input	 in2_input  in8_input	       pwm2_tolerance
 temp1_offset
 fan2_min	 in2_max    in8_max	       pwm3
 temp1_type
 fan3_alarm	 in2_min    in8_min	       pwm3_enable
 temp2_alarm
 fan3_div	 in3_alarm  intrusion0_alarm   pwm3_mode
 temp2_input
 fan3_input	 in3_input  modalias	       pwm3_start_output
 temp2_max
 fan3_min	 in3_max    name	       pwm3_stop_output
 temp2_max_hyst
 fan4_alarm	 in3_min    power	       pwm3_stop_time
 temp2_offset
 fan4_div	 in4_alarm  pwm1	       pwm3_target
 temp2_type
 fan4_input	 in4_input  pwm1_enable        pwm3_tolerance
 temp3_alarm
 fan4_min	 in4_max    pwm1_mode	       pwm4
 temp3_input
 fan5_alarm	 in4_min    pwm1_start_output  pwm4_enable
 temp3_max
 fan5_div	 in5_alarm  pwm1_stop_output   pwm4_max_output
 temp3_max_hyst
 fan5_input	 in5_input  pwm1_stop_time     pwm4_mode
 temp3_offset
 fan5_min	 in5_max    pwm1_target        pwm4_start_output
 temp3_type
 hwmon		 in5_min    pwm1_tolerance     pwm4_step_output
 uevent
 root@amd:/sys/class/hwmon#

Plus, no matter what I do, I can't control the pwm2 (only one used on
my board):

root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
80
root@amd:/sys/class/hwmon/hwmon1/device# echo 0 > pwm2
root@amd:/sys/class/hwmon/hwmon1/device# cat pwm2
80
root@amd:/sys/class/hwmon/hwmon1/device#

I tried playing with other files, too, but no luck. Documentation
mentions:

Note: last six functions are influenced by other control bits, not yet
exported
      by the driver, so a change might not have any effect.


Any ideas what bits those are, and what needs to be implemented? (I'm
currently reading through the documentation).

Thanks,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
