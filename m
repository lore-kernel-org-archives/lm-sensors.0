From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: RFC PATCH partial fix for libsensors adm9240
Message-Id: <aq0i51thbsk5vnmf3sdamght4hjimrp7dk@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

libsensors 2.9.0 and CVS complain they cannot see adm9240 Temp.

peetoo:lm_sensors2$ sensors
adm9240-i2c-0-2d
Adapter: SMBus PIIX4 adapter at 7000
2.5V:      +1.51 V  (min =  +1.37 V, max =  +1.64 V)
Vccp1:     +2.01 V  (min =  +0.00 V, max =  +3.59 V)
3.3V:      +3.35 V  (min =  +3.13 V, max =  +3.47 V)
5V:        +5.18 V  (min =  +4.74 V, max =  +5.26 V)
12V:      +12.25 V  (min = +11.38 V, max = +12.62 V)
Vccp2:     +2.59 V  (min =  +0.00 V, max =  +3.59 V)
fan1:     4141 RPM  (min = 3000 RPM, div = 0)
fan2:     1918 RPM  (min = 1103 RPM, div = 0)
ERROR: Can't get TEMP data!
alarms:

 - - -
my sysfs reader shell script says:
peetoo:0-002d$ ww_adm9240

    in0_min         in0_input     in0_max
0     1367            1510          1641
1     0               2025          3586
2     3128            3352          3472
3     4740            5182          5260
4     11375           12250         12625
5     0               2588          3586

      cpu0_vid:       2000
      analog_out:     789

    temp1_input     temp1_max     temp1_hyst
1     37500           60000         55000

    fan1_input      fan1_min
1     4141            3000
2     1940            1103

alarms
bit     label           state
0       +2.5 V_Error    --
1       VCCP_Error      --
2       +3.3 V_Error    --
3       +5 V_Error      --
4       Temp_Error      --
6       FAN1_Error      --
7       FAN2_Error      --
8       +12 V_Error     --
9       VCCP2_Error     --
12      Chassis_Error   --

Attached is a patch against CVS to remove fan_div as it is no longer 
exposed in this driver, I can't see why Temp is upset, followed the 
constants but cannot make sense of them. ??  

Cheers,
Grant.

--- prog/sensors/chips.c.orig	2005-03-28 20:23:36.000000000 +1000
+++ prog/sensors/chips.c	2005-04-10 20:20:21.000000000 +1000
@@ -367,7 +367,6 @@
 
   if (!sensors_get_label_and_valid(*name,SENSORS_ADM9240_FAN1,&label,&valid) &&
       !sensors_get_feature(*name,SENSORS_ADM9240_FAN1,&cur) &&
-      !sensors_get_feature(*name,SENSORS_ADM9240_FAN1_DIV,&fdiv) &&
       !sensors_get_feature(*name,SENSORS_ADM9240_FAN1_MIN,&min)) {
     if (valid) {
       print_label(label,10);
@@ -379,7 +378,6 @@
   free_the_label(&label);
   if (!sensors_get_label_and_valid(*name,SENSORS_ADM9240_FAN2,&label,&valid) &&
       !sensors_get_feature(*name,SENSORS_ADM9240_FAN2,&cur) &&
-      !sensors_get_feature(*name,SENSORS_ADM9240_FAN2_DIV,&fdiv) &&
       !sensors_get_feature(*name,SENSORS_ADM9240_FAN2_MIN,&min)) {
     if (valid) {
       print_label(label,10);
