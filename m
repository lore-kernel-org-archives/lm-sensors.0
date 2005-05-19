From: TheOneAndOnlySM@hot.rr.com (Sandeep Mehta)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: News about PC87366
Message-Id: <40B3EA7E.3000708@hot.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516104801.568f2ad0.khali@linux-fr.org>
In-Reply-To: <20040516104801.568f2ad0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Forgot to add the full sensors output, here it is:

+5V:       +3.38 V  (min = +11.48 V, max =  11.48 V)       ALARM
Vcore:     +0.78 V  (min =  +3.02 V, max =   3.02 V)       ALARM
+12V:      +6.04 V  (min = +17.00 V, max =  17.00 V)       ALARM
5VSB:      +2.47 V  (min =  +4.48 V, max =   5.47 V)       ALARM
Vsb:       +3.36 V  (min =  +3.00 V, max =   3.60 V)
Vdd:       +3.34 V  (min =  +3.00 V, max =   3.60 V)
Vbat:      +0.00 V  (min =  +2.40 V, max =   3.02 V)
AVdd:      +3.34 V  (min =  +3.00 V, max =   3.60 V)
fan1:     3503 RPM  (min = 3000 RPM, div = 1)
fan2:     2123 RPM  (min = 2000 RPM, div = 2)
S-IO Temp:   +54 C  (low  =    +0 C, high =   +66 C)
S-IO Crit:  +100 C
temp4:       +37 C  (low  =   -24 C, high =   -24 C)   ALARM
temp4_crit:
             -24 C
temp5:       +40 C  (low  =   -24 C, high =   -24 C)   ALARM
temp5_crit:
             -24 C
temp6:       +38 C  (low  =   -24 C, high =   -24 C)   ALARM
temp6_crit:
             -24 C

and sensors -u
pc87366-isa-ecc0
Adapter: ISA adapter
alarms_in: 0.00 (alarms_in)
alarms_temp: 0.00 (alarms_temp)
fan1: 3779.00 (fan1)
  fan1_min: 3000.00 (fan1_min)
  fan1_div: 1.00 (fan1_div)
  fan1_status: 1.00 (fan1_status)
fan2: 2123.00 (fan2)
  fan2_min: 2000.00 (fan2_min)
  fan2_div: 2.00 (fan2_div)
  fan2_status: 1.00 (fan2_status)
+5V: 3.38 (in1)
  in1_min: 11.48 (in1_min)
  in1_max: 11.48 (in1_max)
  in1_status: 131.00 (in1_status)
Vcore: 0.78 (in2)
  in2_min: 3.02 (in2_min)
  in2_max: 3.02 (in2_max)
  in2_status: 131.00 (in2_status)
+12V: 6.04 (in5)
  in5_min: 17.00 (in5_min)
  in5_max: 17.00 (in5_max)
  in5_status: 131.00 (in5_status)
5VSB: 2.47 (in6)
  in6_min: 4.48 (in6_min)
  in6_max: 5.47 (in6_max)
  in6_status: 131.00 (in6_status)
Vsb: 3.34 (in7)
  in7_min: 3.00 (in7_min)
  in7_max: 3.60 (in7_max)
  in7_status: 129.00 (in7_status)
Vdd: 3.34 (in8)
  in8_min: 3.00 (in8_min)
  in8_max: 3.60 (in8_max)
  in8_status: 129.00 (in8_status)
Vbat: 0.00 (in9)
  in9_min: 2.40 (in9_min)
  in9_max: 3.02 (in9_max)
  in9_status: 0.00 (in9_status)
AVdd: 3.32 (in10)
  in10_min: 3.00 (in10_min)
  in10_max: 3.60 (in10_max)
  in10_status: 129.00 (in10_status)
S-IO Temp: 54.00 (temp3)
  temp3_min: 0.00 (temp3_min)
  temp3_max: 66.00 (temp3_max)
  S-IO Crit: 100.00 (temp3_crit)
  temp3_status: 129.00 (temp3_status)
temp4: 36.51 (temp4)
  temp4_min: -24.78 (temp4_min)
  temp4_max: -24.78 (temp4_max)
  temp4_crit: -24.78 (temp4_crit)
  temp4_status: 131.00 (temp4_status)
temp5: 39.75 (temp5)
  temp5_min: -24.78 (temp5_min)
  temp5_max: -24.78 (temp5_max)
  temp5_crit: -24.78 (temp5_crit)
  temp5_status: 131.00 (temp5_status)
temp6: 37.93 (temp6)
  temp6_min: -24.78 (temp6_min)
  temp6_max: -24.78 (temp6_max)
  temp6_crit: -24.78 (temp6_crit)
  temp6_status: 131.00 (temp6_status)
