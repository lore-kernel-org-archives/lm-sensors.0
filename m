From: Jim Cromie <jim.cromie@gmail.com>
Date: Sun, 29 Jun 2008 17:52:54 +0000
Subject: [lm-sensors] [patch 0/6 v2] hwmon/pc87360 individual alarm files
Message-Id: <4867CBF6.60508@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


in this 2nd rev of the patchset (against -rc8), the new voltage and temp 
alarms
work as they should; setting min & max above and below input results in
alarm activation. 

- My board has no thermistors, so I cannot test them.
- The temp units have temp[1-3]-fault files, 2 of them are active on my 
soekris.
- The therm(istor) units temp[4-6] do not have one, since they use 
voltage units 11-14,
  which doesnt support OPEN bit (but does have an overtemp bit on 
v-units 11-14)
- temp_alarms and in_alarms do *not* work. 
  They never did, IIRC, in any case theyre not touched in this patchset.
  Are they properly subject to deprecation and eventual removal ?
  Or do they work on lesser pc8736x chips ?
    (theres some vague hint of diffs where x=[56] in sec 11.2.3)
- All patches pass scripts/checkpatch.pl

Jim Cromie (6):
  hwmon/pc87360 separate alarm files - define some constants
  hwmon/pc87360 separate alarm files - add in-min/max-alarms
  hwmon/pc87360 separate alarm files - add
    temp-min/max/crit/fault-alarms
  hwmon/pc87360 separate alarm files - define LDNI_MAX const
  hwmon/pc87360 separate alarm files - add dev_dbg help
  hwmon/pc87360 separate alarm files - add therm-min/max/crit-alarms

 drivers/hwmon/pc87360.c |  244 
+++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 223 insertions(+), 21 deletions(-)


Having worked thru the patches again, ISTM that 1st patch might have an
aesthetic issue - I put defines as close as possible to where theyll be 
used,
not at the top.  If you want this changed, please indicate if an additional
fixup patch to move them up is acceptable.


thanks
Jim Cromie


PS. The following is a copy-paste of alarms being toggled by setting 
limits..

# sensors -v
sensors version 2.10.1 with libsensors version 2.10.1

# sensors
pc87366-isa-6620
Adapter: ISA a[ 3659.886392] pc87360 pc87360.26144: Data update
dapter
VCORE:     +2.01 V  (min =  +0.00 V, max =  +3.01 V)      
VCC:       +4.96 V  (min =  +0.00 V, max =  +6.03 V)      
VPWR:     +13.55 V  (min =  +0.00 V, max = +60.56 V)      
+12V:     +11.87 V  (min =  +0.00 V, max = +14.55 V)      
-12V:     -11.90 V  (min = -59.77 V, max =  -1.92 V)      
GND:       +0.00 V  (min =  +0.00 V, max =  +3.01 V)      
Vsb:       +3.31 V  (min =  +0.00 V, max =  +6.03 V)      
Vdd:       +2.98 V  (min =  +0.00 V, max =  +6.03 V)      
Vbat:      +0.00 V  (min =  +0.00 V, max =  +0.00 V)      
AVdd:      +3.28 V  (min =  +0.00 V, max =  +6.03 V)      
temp1:      +127 C  (low  =   -55 C, high =  +127 C)   OPEN
temp1_crit:
            +127 C ALARM
temp2:      +127 C  (low  =   -55 C, high =  +127 C)   OPEN
temp2_crit:
            +127 C ALARM
Temp:        +98 C  (low  =   -55 C, high =  +127 C) 
Critical:   +127 C


soekris:/sys/devices/platform/pc87360.26144# cat temp[123]*fault
[ 4044.030817] pc87360 pc87360.26144: Data update
1
1
0

the 2 faults agree with the 2 OPENs in sensors output
(though I suspect they are determined by other means)


soekris:/sys/devices/platform/pc87360.26144# cat temp[123]*max_alarm
[ 4302.257654] pc87360 pc87360.26144: Data update
1
1
0
soekris:/sys/devices/platform/pc87360.26144# ls temp3*

temp3_crit      temp3_fault  temp3_max    temp3_min     temp3_status
temp3_crit_alarm  temp3_input  temp3_max_alarm    temp3_min_alarm

soekris:/sys/devices/platform/pc87360.26144# cat temp3*
[ 4321.958856] pc87360 pc87360.26144: Data update
127000
0
0
98000
127000
0
-55000
0
129

soekris:/sys/devices/platform/pc87360.26144# echo 97000 > temp3_max 
soekris:/sys/devices/platform/pc87360.26144# cat temp3*
[ 4434.226746] pc87360 pc87360.26144: Data update
127000
0
0
98000
97000
1
-55000
0
133

soekris:/sys/devices/platform/pc87360.26144# echo 97000 > temp3_crit
soekris:/sys/devices/platform/pc87360.26144# cat temp3*
[ 4461.619010] pc87360 pc87360.26144: Data update
97000
1
0
98000
97000
1
-55000
0
141

soekris:/sys/devices/platform/pc87360.26144# echo 101000 > temp3_max
soekris:/sys/devices/platform/pc87360.26144# cat temp3*
[ 4489.270994] pc87360 pc87360.26144: Data update
97000
1
0
98000
101000
1
-55000
0
141
soekris:/sys/devices/platform/pc87360.26144#
soekris:/sys/devices/platform/pc87360.26144# cat temp3*
[ 4495.027270] pc87360 pc87360.26144: Data update
97000
1
0
98000
101000
0
-55000
0
137






_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
