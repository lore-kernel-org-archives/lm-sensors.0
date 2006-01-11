From: stevenkaratnyk@rogers.com (Steven Karatnyk)
Date: Wed, 11 Jan 2006 07:01:56 +0000
Subject: [lm-sensors] seeking a W83687THF patch for 2.6.15 (re: ticket 1944)
Message-Id: <43C4AD64.2080608@rogers.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <43BDFEEE.4070408@rogers.com>
In-Reply-To: <43BDFEEE.4070408@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Steven Karatnyk wrote:
      Jean Delvare wrote:

>> Please also keep in mind that for user-space support you need to apply
>> the following patch to the lm_sensors sources:
>>   http://jdelvare.net2.nerim.net/sensors/CVS-w83687thf.diff
>> I checked it and it still applies to CVS with some offset.
>>       
>
> It Applied without issue, but your wording ("it still applies with 
> some offset") makes me think I may have missed something or done 
> something wrong here.  And indeed, although sensors-detect now detects 
> the IC, I haven't succeeded with getting the support implemented yet.  
> I will re-look at this later tonight, time permitting.
>
>   

Ummmm, lets just say I'm a monkey (i.e. I hadn't modprobe w83627hf ).

Anyways, here's the successful output:

# sensors
lm90-i2c-0-4c
Adapter: SMBus Via Pro adapter at 5000

M/B Temp: +37?C (low = +0?C, high = +70?C)
CPU Temp: +54.4?C (low = +0.0?C, high = +70.0?C)
M/B Crit: +85?C (hyst = +75?C)
CPU Crit: +85?C (hyst = +75?C)

w83687thf-isa-0290
Adapter: ISA adapter
in0: +1.10 V (min = +0.70 V, max = +1.87 V)
in1: +1.52 V (min = +2.54 V, max = +2.11 V) ALARM
in2: +3.30 V (min = +2.86 V, max = +1.66 V) ALARM
in3: +2.99 V (min = +2.05 V, max = +3.36 V)
in4: +2.59 V (min = +3.49 V, max = +2.14 V) ALARM
in7: +2.94 V (min = +0.16 V, max = +0.42 V) ALARM
in8: +3.30 V (min = +0.38 V, max = +3.14 V) ALARM
fan1: 1328 RPM (min = 9375 RPM, div = 8) ALARM
fan2: 1339 RPM (min = 1016 RPM, div = 8)
fan3: 0 RPM (min = 6136 RPM, div = 2) ALARM
temp1: +39?C (high = -122?C, hyst = -41?C) sensor = diode ALARM
temp2: +39.0?C (high = +80?C, hyst = +75?C) sensor = diode
temp3: +59.0?C (high = +80?C, hyst = +75?C) sensor = diode
vid: +0.275 V (VRM Version 9.0)
alarms:
beep_enable:
Sound alarm enabled


Pretty happy camper here! Thanks so much guys.

Looking back to what Hugo also reported with the experimental code 
(http://lists.lm-sensors.org/pipermail/lm-sensors/2005-June/012769.html), 
on a glance it seems like I get pretty similar results.

Anyways, definitely count me in for testing any revised/changed code as 
the result of info gleaned from the data sheet. Looking forward to it!

Thanks, Steven

Sorry - probably a duplicate message...replied from one of my other 
accounts (CK) by mistake.




