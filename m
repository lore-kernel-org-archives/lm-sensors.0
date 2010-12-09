From: Juerg Haefliger <juergh@gmail.com>
Date: Thu, 09 Dec 2010 11:31:28 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <AANLkTim2D8NAzjNL_0GNz0e8B9vjuYH_J5FKGoOvMDXJ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jean and Jeff,


> On Mon, 29 Nov 2010 00:20:44 -0600 (CST), Jeff Rickman wrote:
>> Providing some feedback now that SCH5127 support is "mainline" in
>> LM_Sensors; no "force_id" option required.
>> (...)
>> [root@anas-01 ~]# service lm_sensors status
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Core 0:      +21.0°C  (crit = +90.0°C)
>>
>> sch5127-isa-0870
>> Adapter: ISA adapter
>> V+1.5:       +1.42 V  (min =  +1.35 V, max =  +1.65 V)
>> 5VTR:        +4.78 V  (min =  +4.50 V, max =  +5.48 V)
>> VBAT:        +3.32 V  (min =  +0.00 V, max =  +4.38 V)
>> V+5:         +5.09 V  (min =  +0.00 V, max =  +6.72 V)
>> Vccp:        +1.48 V  (min =  +1.35 V, max =  +1.49 V)
>> VCC:         +3.33 V  (min =  +0.00 V, max =  +4.38 V)
>> VTR:         +3.24 V  (min =  +0.00 V, max =  +4.38 V)
>> Side Fan:   2250 RPM  (min = 600 RPM)
>> MCH Fan:    5137 RPM  (min = 4500 RPM)
>> CPU Temp:    +47.6°C  (low  = +20.0°C, high = +60.0°C)
>> SYS Temp:    +35.1°C  (low  = +20.0°C, high = +60.0°C)
>>
>> Here is my "/etc/sensors.d/local.conf" file:
>>
>> [root@anas-01 ~]# cat /etc/sensors.d/local.conf
>> # libsensors configuration file
>> # -----------------------------
>>
>> chip "sch5127-isa-0870"
>>
>>     label in0 "V+1.5"
>>     label in1 "5VTR"
>>     label in2 "VBAT"
>>     label in3 "V+5"
>>     label in4 "Vccp"
>>     label in5 "VCC"
>>     label in6 "VTR"

According to the datasheet (and I just double-checked the scaling
factors in the driver and they are correct), the voltages are as
follows:

in0: 2.5V   (2.5V nominal, 3.320V max)
in1: Vccp   (2.25V nominal, 2.988V max)
in2: VCC   (3.3V nominal, 4.383V max)
in3: V2_IN   (1.125V nominal, 1.5V max, should be wired to scaled down 5V)
in4: V1_IN   (1.125V nominal, 1.5V max, should be wired to scaled down 12V)
in5: VTR   (3.3V nominal, 4.383V max)
in6: VBat   (3.0V nominal, 4.383V max)

If the chip is hooked up according to the datasheet then the only
voltages that require scaling are in3 & 4.

...Juerg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
