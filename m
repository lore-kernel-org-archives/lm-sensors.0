From: mblack@csi-inc.com (Mike Black)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Ticket# 1566
Message-Id: <02f601c3ebf9$5dacdde0$c8de11cc@black>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Got the new sensors.conf from Tyan (lms_s2462.tgz) and temperatures readings look better.  Voltages are still off:
And sensord doesn't want to start without specify the full hardware spec.
I'm using the current CVS version of lm_sensors2 and Linux-2.6.2

Got this after restarting sensord like this: /usr/local/sbin/sensord -d --rrd-file /var/sensor/yeti.rrd w83782d-i2c-0-2d
Feb  5 09:32:57 yeti sensord: Error updating RRD file: /var/sensor/yeti.rrd: expected 15 data source readings (got 0) from N:...

Removed the old rrd file and tried: /usr/local/sbin/sensord -d --rrd-file /var/sensor/yeti.rrd
Feb  5 09:51:40 yeti sensord: Error getting sensor data: w83782d/#81: Can't access procfs/sysfs file

With wildcards still fails: /usr/local/sbin/sensord -d --rrd-file /var/sensor/yeti.rrd w83782d-\*
Feb  5 09:53:24 yeti sensord: sensord failed


Have to start sensord like this: /usr/local/sbin/sensord -d --rrd-file /var/sensor/yeti.rrd w83782d-i2c-3-2d


sensors now shows:
w83782d-i2c-3-2d
Adapter: SMBus AMD756 adapter at 80e0
AGP V:     +1.52 V  (min =  +3.14 V, max =  +3.46 V)
+5 V:     +4.89 V  (min =  +4.73 V, max =  +5.24 V)
DDR V:     +1.23 V  (min =  +2.85 V, max =  +3.47 V)       <<<<<<<< low by more than 2X
3 VSB:     +3.33 V  (min =  +2.85 V, max =  +3.15 V)        <<<<<<<< too high?
Bat V:     +2.61 V  (min =  +2.64 V, max =  +3.95 V)         <<<<<<<< too low??
CPU1 Fan: 3325 RPM  (min =   -1 RPM, div = 2)
CPU2 Fan: 5000 RPM  (min =   -1 RPM, div = 2)
chs1 Fan:    0 RPM  (min =   -1 RPM, div = 2)
VRM2 Temp:   +52?C  (high =  +100?C)                     sensor = 3904 transistor
CPU1 Temp: +49.5?C  (high =   +72?C, hyst =   +32?C)   sensor = 3904 transistor   ALARM
CPU2 Temp: +50.0?C  (high =   +72?C, hyst =   +32?C)   sensor = 3904 transistor   ALARM
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
         Sound alarm disabled


#####

chip "w83782d-*"

   ignore in0
   ignore in1
   ignore in5
   ignore in7
   ignore vid

   label in2 "AGP V"
   label in3 " +5 V"
   label in4 "DDR V"
   label in6 "3 VSB"
   label in8 "Bat V"

   label fan1 "CPU1 Fan"
   label fan2 "CPU2 Fan"
   label fan3 "chs1 Fan"

   label temp1 "VRM2 Temp"
   label temp2 "CPU1 Temp"
   label temp3 "CPU2 Temp"
   compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)

# set limits to  5% for the critical voltages
# set limits to 10% for the non-critical voltages
# set limits to 20% for the battery voltage

   set in2_min 3.3 * 0.95
   set in2_max 3.3 * 1.05
   set in3_min 5.0 * 0.95
   set in3_max 5.0 * 1.05
   set in6_max 3.0 * 1.05
   set in6_min 3.0 * 0.95
   set in8_min 3.3 * 0.80
   set in8_max 3.3 * 1.20

# thermal sensor types (do not adjust)
   set sensor1 2
   set sensor2 2
   set sensor3 2

# examples for temperature limits
#    set temp1_over 40
#    set temp1_hyst 60
#    set temp2_over 70
#    set temp2_hyst 80
#    set temp3_over 70
#    set temp3_hyst 80

   set beep_enable 0

# CPU VRM Spec.
   set vrm 9.0

# Fan divisors.  Some fans (.18A) may need this to be set to 4
   set fan1_div 2
   set fan2_div 2
   set fan3_div 2


Michael D. Black mblack@csi-inc.com
http://www.csi-inc.com/
http://www.csi-inc.com/~mike
321-676-2923, x203
Melbourne FL
