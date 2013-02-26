From: "SP2148421 (at) web.de" <sp2148421@web.de>
Date: Tue, 26 Feb 2013 12:44:53 +0000
Subject: [lm-sensors] problem:  thresholds change to zero after some time
Message-Id: <512CAE45.8090007@web.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8998130130372173845=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--===============8998130130372173845==
Content-Type: multipart/alternative;
 boundary="------------020307050300020800090204"

This is a multi-part message in MIME format.
--------------020307050300020800090204
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi List,
I have a strange problem…
After some running days some sensor thresholds change from their 
original values to zero (in the example below 3VSB, but I have seen this 
for different values)!??? After reboot the machine I got the original 
values again. A reload of the w83627ehf module do not clear the problem. 
I recorded no other problems while running the machine.
I’m not sure is this a Problem of lm-sensors, a hardware failure or a 
compability error? Any ideas?
Board:
supermicro x7spa-hf
OS:
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 12.04.2 LTS
Release:        12.04
Codename:       precise
Kernel:
3.2.0-38-generic #61-Ubuntu SMP Tue Feb 19 12:18:21 UTC 2013 x86_64 
x86_64 x86_64 GNU/Linux
ii libsensors4 1:3.3.1-2ubuntu1                        library to read 
temperature/voltage/fan sensors
ii lm-sensors 1:3.3.1-2ubuntu1                        utilities to read 
temperature/voltage/fan sensors
ii sensord 1:3.3.1-2ubuntu1                        hardware sensor 
information logging daemon
sample syslog output:
Feb 20 04:00:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
Vcore: +1.16 V (min = +0.00 V, max = +0.00 V) [ALARM]
Feb 20 04:00:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
+1.05V: +1.05 V (min = +0.36 V, max = +0.00 V) [ALARM]
Feb 20 04:00:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
3VCC: +3.33 V (min = +2.98 V, max = +0.00 V) [ALARM]
Feb 20 04:00:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
Vdimm: +1.85 V (min = +0.41 V, max = +0.00 V) [ALARM]
Feb 20 04:00:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
+5V: +5.15 V (min = +0.13 V, max = +0.00 V) [ALARM]
Feb 20 04:00:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
+12V: +11.90 V (min = +0.00 V, max = +0.13 V) [ALARM]
Feb 20 04:00:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
3VSB: +3.30 V (min = +0.00 V, max = +0.00 V) [ALARM]
Feb 20 04:00:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
Case Temp: 26.5 C (limit = 0.0 C, hysteresis = 4.0 C) [ALARM]
Feb 20 04:01:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
Vcore: +1.15 V (min = +0.00 V, max = +0.00 V) [ALARM]
Feb 20 04:01:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
+1.05V: +1.05 V (min = +0.36 V, max = +0.00 V) [ALARM]
Feb 20 04:01:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
3VCC: +3.33 V (min = +2.98 V, max = +0.00 V) [ALARM]
Feb 20 04:01:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
Vdimm: +1.85 V (min = +0.41 V, max = +0.00 V) [ALARM]
Feb 20 04:01:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
+5V: +5.15 V (min = +0.13 V, max = +0.00 V) [ALARM]
Feb 20 04:01:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
+12V: +11.90 V (min = +0.00 V, max = +0.13 V) [ALARM]
Feb 20 04:01:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
3VSB: +3.30 V (min = +0.00 V, max = +0.00 V) [ALARM]
Feb 20 04:01:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
Case Temp: 26.0 C (limit = 0.0 C, hysteresis = 4.0 C) [ALARM]
Feb 20 04:02:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
Vcore: +1.15 V (min = +0.00 V, max = +0.00 V) [ALARM]
Feb 20 04:02:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
+1.05V: +1.05 V (min = +0.36 V, max = +0.00 V) [ALARM]
Feb 20 04:02:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
3VCC: +3.33 V (min = +2.98 V, max = +0.00 V) [ALARM]
Feb 20 04:02:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
Vdimm: +1.85 V (min = +0.41 V, max = +0.00 V) [ALARM]
Feb 20 04:02:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
+5V: +5.15 V (min = +0.13 V, max = +0.00 V) [ALARM]
Feb 20 04:02:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
+12V: +11.90 V (min = +0.00 V, max = +0.13 V) [ALARM]
Feb 20 04:02:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
3VSB: +3.30 V (min = +0.00 V, max = +0.00 V) [ALARM]
Feb 20 04:02:33 gw00 sensord: Sensor alarm: Chip w83627dhg-isa-0ca0: 
Case Temp: 26.0 C (limit = 0.0 C, hysteresis = 4.0 C) [ALARM]
After reboot:
Feb 24 07:06:45 gw00 sensord: Chip: coretemp-isa-0000
Feb 24 07:06:45 gw00 sensord: Adapter: ISA adapter
Feb 24 07:06:45 gw00 sensord: Core 0: 23.0 C
Feb 24 07:06:45 gw00 sensord: Core 1: 25.0 C
Feb 24 07:06:45 gw00 sensord: Chip: w83627dhg-isa-0ca0
Feb 24 07:06:45 gw00 sensord: Adapter: ISA adapter
Feb 24 07:06:45 gw00 sensord: Vcore: +1.15 V (min = +0.01 V, max = +1.39 V)
Feb 24 07:06:45 gw00 sensord: +1.05V: +1.05 V (min = +0.94 V, max = +1.16 V)
Feb 24 07:06:45 gw00 sensord: AVCC: +3.33 V (min = +2.96 V, max = +3.63 V)
Feb 24 07:06:45 gw00 sensord: 3VCC: +3.33 V (min = +0.02 V, max = +3.63 V)
Feb 24 07:06:45 gw00 sensord: Vdimm: +1.85 V (min = +1.62 V, max = +1.98 V)
Feb 24 07:06:45 gw00 sensord: +12V: +11.90 V (min = +10.75 V, max = 
+13.18 V)
Feb 24 07:06:45 gw00 sensord: 3VSB: +3.30 V (min = +2.96 V, max = +3.63 V)
Feb 24 07:06:45 gw00 sensord: Vbat: +3.15 V (min = +2.96 V, max = +3.63 V)
Feb 24 07:06:45 gw00 sensord: MB Temp: 39.0 C (limit = 75.0 C, 
hysteresis = 0.0 C)
Feb 24 07:06:45 gw00 sensord: CPU Temp: 39.5 C (limit = 100.0 C, 
hysteresis = 97.0 C)
Feb 24 07:06:45 gw00 sensord: Case Temp: 24.0 C (limit = 80.0 C, 
hysteresis = 75.0 C)
sensors:
coretemp-isa-0000
Adapter: ISA adapter
Core 0:       +25.0 C  (crit = +100.0 C)
Core 1:       +26.0 C  (crit = +100.0 C)
w83627dhg-isa-0ca0
Adapter: ISA adapter
Vcore:        +1.15 V  (min = +0.72 V, max =  +1.39 V)
+1.05V:       +1.05 V  (min = +0.94 V, max =  +1.16 V)
AVCC:         +3.33 V  (min = +2.96 V, max =  +3.63 V)
3VCC:         +3.33 V  (min = +2.98 V, max =  +3.63 V)
Vdimm:        +1.85 V  (min = +1.62 V, max =  +1.98 V)
+5V:          +5.15 V  (min = +4.74 V, max =  +5.25 V)
+12V:        +11.90 V  (min = +0.00 V, max = +13.18 V)
3VSB:         +3.30 V  (min = +2.96 V, max =  +0.00 V)  ALARM
Vbat:         +3.15 V  (min = +2.96 V, max =  +3.63 V)
MB Temp:      +40.0 C  (high = +0.0 C, hyst = +70.0 C)  sensor = thermistor
CPU Temp:     +41.5 C  (high = +100.0 C, hyst = +97.0 C)  sensor = diode
Case Temp:    +25.5 C  (high = +0.0 C, hyst = +75.0 C)  sensor = diode
intrusion0:  OK



--------------020307050300020800090204
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-forward-container"><font size="2" face="Calibri"><span
          style="font-size:11pt;">
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Hi List,</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;"><font size="2">I</font> have a
                strange problem…</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">After some running days some
                sensor thresholds change from their original values to
                zero (in the example below 3VSB, but I have seen this
                for different values)!??? After reboot the machine I got
                the original values again. A reload of the w83627ehf
                module do not clear the problem. I recorded no other
                problems while running the machine.</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;"> </span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">I’m not sure is this a Problem
                of lm-sensors, a hardware failure or a compability
                error? Any ideas?</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;"> </span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Board:</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">supermicro x7spa-hf</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;"> </span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">OS:</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">No LSB modules are available.</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Distributor ID: Ubuntu</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Description:    Ubuntu 12.04.2
                LTS</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Release:        12.04</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Codename:       precise</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;"> </span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Kernel:</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">3.2.0-38-generic #61-Ubuntu SMP
                Tue Feb 19 12:18:21 UTC 2013 x86_64 x86_64 x86_64
                GNU/Linux </span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;"> </span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">ii 
                libsensors4                           
                1:3.3.1-2ubuntu1                        library to read
                temperature/voltage/fan sensors</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">ii 
                lm-sensors                            
                1:3.3.1-2ubuntu1                        utilities to
                read temperature/voltage/fan sensors</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">ii 
                sensord                               
                1:3.3.1-2ubuntu1                        hardware sensor
                information logging daemon</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;"> </span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">sample syslog output:</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:00:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: Vcore: +1.16 V
                (min = +0.00 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:00:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: +1.05V: +1.05 V
                (min = +0.36 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:00:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: 3VCC: +3.33 V
                (min = +2.98 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:00:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: Vdimm: +1.85 V
                (min = +0.41 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:00:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: +5V: +5.15 V (min
                = +0.13 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:00:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: +12V: +11.90 V
                (min = +0.00 V, max = +0.13 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:00:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: 3VSB: +3.30 V
                (min = +0.00 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:00:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: Case Temp: 26.5 C
                (limit = 0.0 C, hysteresis = 4.0 C) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:01:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: Vcore: +1.15 V
                (min = +0.00 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:01:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: +1.05V: +1.05 V
                (min = +0.36 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:01:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: 3VCC: +3.33 V
                (min = +2.98 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:01:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: Vdimm: +1.85 V
                (min = +0.41 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:01:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: +5V: +5.15 V (min
                = +0.13 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:01:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: +12V: +11.90 V
                (min = +0.00 V, max = +0.13 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:01:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: 3VSB: +3.30 V
                (min = +0.00 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:01:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: Case Temp: 26.0 C
                (limit = 0.0 C, hysteresis = 4.0 C) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:02:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: Vcore: +1.15 V
                (min = +0.00 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:02:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: +1.05V: +1.05 V
                (min = +0.36 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:02:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: 3VCC: +3.33 V
                (min = +2.98 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:02:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: Vdimm: +1.85 V
                (min = +0.41 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:02:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: +5V: +5.15 V (min
                = +0.13 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:02:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: +12V: +11.90 V
                (min = +0.00 V, max = +0.13 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:02:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: 3VSB: +3.30 V
                (min = +0.00 V, max = +0.00 V) [ALARM]</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Feb 20 04:02:33 gw00 sensord:
                Sensor alarm: Chip w83627dhg-isa-0ca0: Case Temp: 26.0 C
                (limit = 0.0 C, hysteresis = 4.0 C) [ALARM]</span></font></div>
          <div><font color="#1F497D"> </font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">After reboot:</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:
                Chip: coretemp-isa-0000</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:
                Adapter: ISA adapter</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:  
                Core 0: 23.0 C</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:  
                Core 1: 25.0 C</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:
                Chip: w83627dhg-isa-0ca0</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:
                Adapter: ISA adapter</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:  
                Vcore: +1.15 V (min = +0.01 V, max = +1.39 V)</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:  
                +1.05V: +1.05 V (min = +0.94 V, max = +1.16 V)</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:  
                AVCC: +3.33 V (min = +2.96 V, max = +3.63 V)</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:  
                3VCC: +3.33 V (min = +0.02 V, max = +3.63 V)</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:  
                Vdimm: +1.85 V (min = +1.62 V, max = +1.98 V)</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:  
                +12V: +11.90 V (min = +10.75 V, max = +13.18 V)</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:  
                3VSB: +3.30 V (min = +2.96 V, max = +3.63 V)</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:  
                Vbat: +3.15 V (min = +2.96 V, max = +3.63 V)</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:  
                MB Temp: 39.0 C (limit = 75.0 C, hysteresis = 0.0 C)</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:  
                CPU Temp: 39.5 C (limit = 100.0 C, hysteresis = 97.0 C)</span></font></div>
          <div><font size="2" color="#1F497D" face="Verdana"><span
                style="font-size:10pt;">Feb 24 07:06:45 gw00 sensord:  
                Case Temp: 24.0 C (limit = 80.0 C, hysteresis = 75.0 C)</span></font></div>
          <div><font color="#1F497D"> </font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">sensors:</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">coretemp-isa-0000</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Adapter: ISA adapter</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Core 0:       +25.0 C  (crit =
                +100.0 C)</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Core 1:       +26.0 C  (crit =
                +100.0 C)</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;"> </span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">w83627dhg-isa-0ca0</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Adapter: ISA adapter</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Vcore:        +1.15 V  (min = 
                +0.72 V, max =  +1.39 V)</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">+1.05V:       +1.05 V  (min = 
                +0.94 V, max =  +1.16 V)</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">AVCC:         +3.33 V  (min = 
                +2.96 V, max =  +3.63 V)</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">3VCC:         +3.33 V  (min = 
                +2.98 V, max =  +3.63 V)</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Vdimm:        +1.85 V  (min = 
                +1.62 V, max =  +1.98 V)</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">+5V:          +5.15 V  (min = 
                +4.74 V, max =  +5.25 V)</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">+12V:        +11.90 V  (min = 
                +0.00 V, max = +13.18 V)</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">3VSB:         +3.30 V  (min = 
                +2.96 V, max =  +0.00 V)  ALARM</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Vbat:         +3.15 V  (min = 
                +2.96 V, max =  +3.63 V)</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">MB Temp:      +40.0 C  (high = 
                +0.0 C, hyst = +70.0 C)  sensor = thermistor</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">CPU Temp:     +41.5 C  (high =
                +100.0 C, hyst = +97.0 C)  sensor = diode</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">Case Temp:    +25.5 C  (high = 
                +0.0 C, hyst = +75.0 C)  sensor = diode</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;">intrusion0:  OK</span></font></div>
          <div><font size="2" face="Verdana"><span
                style="font-size:10pt;"> </span></font></div>
          <div> </div>
          <div> </div>
        </span></font>
      <br>
    </div>
    <br>
  </body>
</html>

--------------020307050300020800090204--


--===============8998130130372173845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8998130130372173845==--
