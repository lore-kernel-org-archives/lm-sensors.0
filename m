From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 26 Jun 2006 18:16:03 +0000
Subject: [lm-sensors] whitespace in patches Q
Message-Id: <44A02463.1050504@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



I just went back over the patches on ticket #2076, looking for whitespace
that might give heartburn to the reviewer;  I found a few spots..

 cat -TE hwmon-pc87360-sysfs-combo-callbacks.patch |less

In this chunk-frag, 2 leading tabs are conforming, but my editor adds spaces
so that the code lines up inside the (open-paren).  IMO thats an editor 
feature,
and Doc/CodingStyle doesnt really speak to it, but its not clear that 
its an
acceptable variation either.

(that the spaces are present in the current code is *something*,
but they were put there by me, and dont really prove much)


 static struct sensor_device_attribute_2 fan_min[] = {$
 ^ISENSOR_ATTR_2(fan1_min, S_IWUSR | S_IRUGO,$
-^I^I      show_fan_min, set_fan_min, FN_FAN_MIN, 0),$
+^I^I      show_fan, set_fan_min, FN_FAN_MIN, 0),$
 ^ISENSOR_ATTR_2(fan2_min, S_IWUSR | S_IRUGO,$
-^I^I      show_fan_min, set_fan_min, FN_FAN_MIN, 1),$
+^I^I      show_fan, set_fan_min, FN_FAN_MIN, 1),$
 ^ISENSOR_ATTR_2(fan3_min, S_IWUSR | S_IRUGO,$
-^I^I      show_fan_min, set_fan_min, FN_FAN_MIN, 2),$
+^I^I      show_fan, set_fan_min, FN_FAN_MIN, 2),$
 };$


