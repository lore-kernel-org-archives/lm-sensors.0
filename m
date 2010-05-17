From: "Virgil Gheorghiu" <virgilg@cs.uchicago.edu>
Date: Mon, 17 May 2010 15:21:55 +0000
Subject: [lm-sensors] lm-sensors and SNMP traps
Message-Id: <op.vcuvmts5752aa5@microbe.cs.uchicago.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Dear lm-sensors team,

We are using lm-sensors on lots of machines to monitor their temperature  
(http://sensors.cs.uchicago.edu).
One mechanism for alerts is to have one central computer walk through all  
sensor data and e-mail us when it gets out of range.
cacti, zenoss, etc. walk the snmp tree and can get this data, e.g.:

root@server:~# snmpwalk -v2c -cpublic microbe  
LM-SENSORS-MIB::lmFanSensorsTable
LM-SENSORS-MIB::lmFanSensorsIndex.1 = INTEGER: 0
LM-SENSORS-MIB::lmFanSensorsIndex.2 = INTEGER: 1
LM-SENSORS-MIB::lmFanSensorsIndex.3 = INTEGER: 2
LM-SENSORS-MIB::lmFanSensorsDevice.1 = STRING: CPU0 Fan
LM-SENSORS-MIB::lmFanSensorsDevice.2 = STRING: fan2
LM-SENSORS-MIB::lmFanSensorsDevice.3 = STRING: fan3
LM-SENSORS-MIB::lmFanSensorsValue.1 = Gauge32: 1038
LM-SENSORS-MIB::lmFanSensorsValue.2 = Gauge32: 10384
LM-SENSORS-MIB::lmFanSensorsValue.3 = Gauge32: 0

We want to be notified by the machine itself via a trap sent to a trap  
destination server every time one of the indices configured in  
/etc/sensors.conf triggers an alarm, e.g.
- temperature threshold CPU(s) / MB
- fan(s) threshold
- voltage threshold
This simplifies infrastructure configuration a lot. We already have in  
place specific sensors.conf for about 30 motherboards.

I cannot find anywhere on lm-sensors.org or on net-snmp.org a proper  
(current) example of configuring snmpd.conf/sensors.conf to send trap  
notifications.
Since it appears that /usr/share/snmp/mibs/LM-SENSORS-MIB.txt does not  
contain any trap definitions, I am assuming this functionality is not  
implemented. Is this correct? If so, are there plans to have such  
functionality added?

If I am mistaking and there is such functionality in both packages, can  
someone please point me to the proper documentation?

Thank you,
Virgil Gheorghiu
Systems Administrator
Department of Computer Science
The University of Chicago


------------- Begin technical data 8x -------------
For example:
microbe:~# /opt/techstaff/bin/sysinfo -a
Manufacturer: Shuttle
Motherboard model: FX22V10
BIOS Version: 6.00 PG (released on 12/08/2008)
Total memory slots: 2
         Size: 1024 MB
         Size: 1024 MB
Total RAM: 2048 MB
Total BogoMIPS: 9205.20
Processor Count: 2
Processor Model: AMD Athlon(tm) 64 X2 Dual Core Processor 4400+
Processor Speed: 2299.733 MHz
Processor L2 Cache: 512 KB

with this /etc/sensors.conf:

chip "it87-*" "it8712-*"
         label in0 "VCore 1"
         label in1 "Chipset"
         label in2 "+3.3V"
         label in3 "+5V"
         label in4 "+12V"
         label in5 "-12V"
         label in6 "-5V"
         label in7 "+5V Stdby"
         label in8 "VBatt"

         label temp1 "MB Temp"
         label temp3 "CPU0 Temp"
         label fan1 "CPU0 Fan"

         ignore vid
         ignore in6
         ignore temp2
         ignore fan2
         ignore fan3

         compute in3 ((6.8/10)+1) * @ , @ / ((6.8/10)+1)
         compute in4 ((30/10) +1) * @ , @ / ((30/10) +1)
         compute in5 (7.67 * @) - 19.36 , (@ + 19.36) / 7.67
         compute in6 (4.33 * @) - 13.64 , (@ + 13.64) / 4.33
         compute in7 ((6.8/10)+1) * @ , @ / ((6.8/10)+1)
         compute fan1 @ / 10, @ * 10

         set in0_min 1.35 * 0.95
         set in0_max 1.35 * 1.05
         set in1_min 1.46 * 0.95
         set in1_max 1.46 * 1.05
         set in2_min 3.3 * 0.95
         set in2_max 3.3 * 1.05
         set in3_min 5.0 * 0.95
         set in3_max 5.0 * 1.05
         set in4_min 12 * 0.95
         set in4_max 12 * 1.05
         set in5_max -12 * 0.95
         set in5_min -12 * 1.05
         #set in6_max -5 * 0.95
         #set in6_min -5 * 1.05
         set in7_min 5 * 0.95
         set in7_max 5 * 1.05

         set   temp1_max 45
         set   temp1_min 15
         set   temp3_max 60
         set   temp3_min 15

         set fan1_min 3000 # for testing purposes only, right value is ~  
1000rpm

with this ALARM output of sensors:
microbe:~# sensors -s && sensors
it8712-isa-0290
Adapter: ISA adapter
VCore 1:     +1.36 V  (min =  +1.28 V, max =  +1.42 V)
Chipset:     +1.44 V  (min =  +1.39 V, max =  +1.54 V)
+3.3V:       +3.30 V  (min =  +3.14 V, max =  +3.47 V)
+5V:         +5.00 V  (min =  +4.76 V, max =  +5.24 V)
+12V:       +12.22 V  (min = +11.39 V, max = +12.61 V)
-12V:       -12.12 V  (min = -12.61 V, max = -11.38 V)
+5V Stdby:   +4.95 V  (min =  +4.76 V, max =  +5.24 V)
VBatt:       +3.25 V
CPU0 Fan:   1055 RPM  (min = 2935 RPM)  ALARM
MB Temp:     +40.0°C  (low  = +15.0°C, high = +45.0°C)  sensor = thermistor
CPU0 Temp:   +48.0°C  (low  = +15.0°C, high = +60.0°C)  sensor = thermistor
cpu0_vid:   +0.000 V

and this /etc/snmp/snmpd.local.conf
microbe:~# cat /etc/snmp/snmpd.local.conf
createUser internal
agentSecName internal
rouser internal

# sensors monitoring
setEvent overheat prErrFix = 1
monitor -r 10 -e overheat LM-SENSORS-MIB::lmFanSensorsValue.1 1100 2000

should trigger a fan-speed-too-low trap sent to the configured snmptrapd  
server under some lm-sensors OID.
------------- x8 End technical data -------------

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
