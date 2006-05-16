From: jim.cromie@gmail.com (Jim Cromie)
Date: Tue, 16 May 2006 18:32:55 +0000
Subject: [lm-sensors] [ patch 3/3 ] hwmon/pc87360 use combo callbacks
Message-Id: <446A1AD7.70006@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


3. hwmon-pc87360-sysfs-combo-callbacks.patch

This patch uses the 2nd field in the SENSOR_ATTR_2s to encode
the supported attributes for that sensor-type, thus allowing the
separate callbacks for each of them to be combined to a single function
that keys on the encoded attribute.

Note that combinations respect the getter/setter distinction,
and maintain the sensor-type distinctions: temp, therm, in, fan, pwm.
Further combos are possible, but get diminishing returns, and obfuscation.

heres a nm -S pc87360.ko,  < before vs after  >
It should clarify the callback changes

63,72c63,67
< 00001084 000000f1 t set_fan_min
< 00000c3b 0000009c t set_in_max
< 00000b9f 0000009c t set_in_min
< 00001175 00000099 t set_pwm
< 00000e0b 0000009a t set_temp_crit
< 00000d71 0000009a t set_temp_max
< 00000cd7 0000009a t set_temp_min
< 00000fdd 000000a7 t set_therm_crit
< 00000f41 0000009c t set_therm_max
< 00000ea5 0000009c t set_therm_min
---
 > 00000d87 000000f1 t set_fan_min
 > 00000164 00000110 t set_in
 > 00000e78 00000099 t set_pwm
 > 00000acc 00000152 t set_temp
 > 00000c1e 00000169 t set_therm
74,96c69,77
< 00000aee 0000003a t show_fan_div
< 00000a48 00000053 t show_fan_input
< 00000a9b 00000053 t show_fan_min
< 00000b28 00000031 t show_fan_status
< 000007b0 00000022 t show_in_alarms
< 00000652 0000004a t show_in_input
< 000006e6 0000004a t show_in_max
< 0000069c 0000004a t show_in_min
< 00000730 0000002e t show_in_status
< 00000b59 00000046 t show_pwm
< 000008d0 00000022 t show_temp_alarms
< 0000086e 00000034 t show_temp_crit
< 000007d2 00000034 t show_temp_input
< 0000083a 00000034 t show_temp_max
< 00000806 00000034 t show_temp_min
< 000008a2 0000002e t show_temp_status
< 000009d0 0000004a t show_therm_crit
< 000008f2 0000004a t show_therm_input
< 00000986 0000004a t show_therm_max
< 0000093c 0000004a t show_therm_min
< 00000a1a 0000002e t show_therm_status
< 0000075e 00000030 t show_vid
< 0000078e 00000022 t show_vrm
---
 > 000009e0 000000a6 t show_fan
 > 00000762 000000b1 t show_in
 > 00000865 00000022 t show_in_alarms
 > 00000a86 00000046 t show_pwm
 > 00000887 00000084 t show_temp
 > 0000090b 00000022 t show_temp_alarms
 > 0000092d 000000b3 t show_therm
 > 00000813 00000030 t show_vid
 > 00000843 00000022 t show_vrm

apologies if Ive said too much

Signed-off-by:  Jim Cromie  <jim.cromie at gmail.com>

$ diffstat hwmon-pc87360-sysfs-combo-callbacks.patch
 pc87360.c |  570 
+++++++++++++++++++++++++++++---------------------------------
 1 files changed, 271 insertions(+), 299 deletions(-)

---

-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-pc87360-sysfs-combo-callbacks.patch
Type: text/x-patch
Size: 31627 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060516/590b2424/hwmon-pc87360-sysfs-combo-callbacks-0001.bin
