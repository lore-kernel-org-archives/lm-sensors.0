From: pgaige@cadesis.com (=?ISO-8859-1?Q?Gaig=E9_Pierre?=)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: support for p4s8x motherboard
Message-Id: <3EFCA43F.7070601@cadesis.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EFA15C6.5020503@cadesis.com>
In-Reply-To: <3EFA15C6.5020503@cadesis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>>>Maybe some value is (supposedly) out of limits and you have beeping
>>>enabled. Does "sensors -s" (as root) end the noise? What does
>>>"sensors" output then? Does unloading the w83781d module stop the
>>>beeps?
>>>
>>
>>"sensors -s" does not end the noise and gives no information.
> 
> 
> It is perfectly normal that it doesn't give any information.
> 
> 
>>Unloading the module does not help too.
>>Only a reboot stop the beep sequence.
> 
> 
> And what about "sensors" (without "-s")? Does it actually show something
> is over limit?
> 
here is the results of "sensors" :

as99127f-i2c-0-2d
Adapter: SMBus SiS645 adapter at 0xe600
Algorithm: Non-I2C SMBus adapter
VCore 1:   +1.53 V  (min =  +1.26 V, max =  +1.53 V)       ALARM
VCore 2:   +1.58 V  (min =  +1.26 V, max =  +1.53 V)
+3.3V:     +3.39 V  (min =  +2.97 V, max =  +3.63 V)
+5V:       +5.07 V  (min =  +4.50 V, max =  +5.48 V)
+12V:     +11.48 V  (min = +10.79 V, max = +13.11 V)
-12V:     -12.00 V  (min =  -0.00 V, max =  -0.00 V)
-5V:       -4.58 V  (min =  -0.00 V, max =  -0.00 V)
fan1:     3054 RPM  (min = 3000 RPM, div = 2)              ALARM
fan2:        0 RPM  (min = 3000 RPM, div = 2)              ALARM
fan3:        0 RPM  (min = 3000 RPM, div = 2)
temp1:       +37?C  (limit =  +60?C)
temp2:     +38.0?C  (limit = +120?C, hysteresis = +100?C)
temp3:     +36.0?C  (limit = +120?C, hysteresis = +100?C)
vid:      +1.400 V
alarms:
beep_enable:
           Sound alarm enabled

