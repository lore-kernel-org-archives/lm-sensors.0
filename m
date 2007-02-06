From: jharvell@dogpad.net (Joe Harvell)
Date: Tue, 06 Feb 2007 03:54:44 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <45C7FC04.4050607@dogpad.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Joe Harvell wrote:
> Rudolf Marek wrote:
>   
>>> temp2):  Under load, my temp3 *drops* from 119 to 103.5 under load and 
>>> then goes back up afterwards ?????
>>>     
>>>       
>> Hmm my MB has this at 127C which means unconnected. Please can you send a
>> dsdt.bin file? (cat /proc/acpi/dsdt > /tmp/dsdt.bin)
>>   
>>     
> This machine is powered down right now.  I'll send this shortly.
>   
Sent.
>
> I'll get that shortly also.  Just wanted to let you know that I see some 
> strange behavior of lm_sensors with respect to the fan5.  This sensor 
> usually reports zero.  But after it has been up for a while it starts 
> reporting something in the 1100 to 1200 range.  This is consistent with 
> my case fan speed.  So it seems fan5 is either CHA_FAN1 or CHA_FAN2.  
> Actually, I can't confirm it's the fan5 sensor that's doing this.  That 
> is what I remember from a couple of days ago.  But I updated my 
> sensors.conf file to put a label on the sensor that was doing this, so 
> once I power up my machine again, I'll verify this as well.
>   
Confirmed, fan5 is the sensors showing false zero readings most of the 
time and valid readings for CHA_FAN1 or CHA_FAN2 sometimes.

I need to hook up a console again to get the BIOS fans.
>> here is my:
>>
>> axon:~# sensors
>> w83627dhg-isa-0290
>> Adapter: ISA adapter
>> VCore:     +1.14 V  (min =  +0.00 V, max =  +1.74 V)
>> in1:      +12.30 V  (min =  +0.26 V, max = +10.88 V) ALARM
>> AVCC:      +3.25 V  (min =  +1.74 V, max =  +2.24 V) ALARM
>> 3VCC:      +3.25 V  (min =  +3.44 V, max =  +3.17 V) ALARM
>> in4:       +1.11 V  (min =  +1.17 V, max =  +0.26 V) ALARM
>> in5:       +1.59 V  (min =  +0.06 V, max =  +1.54 V) ALARM
>> in6:       +3.53 V  (min =  +0.51 V, max =  +1.00 V) ALARM
>> VSB:       +3.25 V  (min =  +1.74 V, max =  +3.66 V)
>> VBAT:      +3.25 V  (min =  +0.05 V, max =  +0.64 V) ALARM
>> Case Fan:    0 RPM  (min = 21093 RPM, div = 64) ALARM
>> CPU Fan:  1687 RPM  (min = 1662 RPM, div = 4)
>> Aux Fan:     0 RPM  (min = 10546 RPM, div = 64) ALARM
>> fan4:        0 RPM  (min = 10546 RPM, div = 32) ALARM
>> fan5:     3835 RPM  (min = 7670 RPM, div = 2) ALARM
>> Sys Temp:    +33?C  (high =   -56?C, hyst =   +39?C)
>> CPU Temp:  +39.5?C  (high = +80.0?C, hyst = +75.0?C)
>> AUX Temp: +127.0?C  (high = +80.0?C, hyst = +75.0?C)   ALARM
>>
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> temp1:       +30?C  (high =   +85?C)
>>
>> coretemp-isa-0001
>> Adapter: ISA adapter
>> temp1:       +32?C  (high =   +85?C)
>>
>> Rudolf
>>   
>>     
> I forget, is your board a P5B Deluxe WiFi?
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


