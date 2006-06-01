From: andrew@donehue.net (Andrew)
Date: Thu, 01 Jun 2006 10:02:08 +0000
Subject: [lm-sensors] how accurate?
Message-Id: <447EBB20.80004@donehue.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <447ABAC1.3080706@donehue.net>
In-Reply-To: <447ABAC1.3080706@donehue.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Thanks for the reply - Changing to diode didn't make any difference - 
dmidecode doesn't  give me any useful information... (see below)

I might send someone on a road trip - I think the fans might be broken :)

Thank you for all your help.

Cheers,
Andrew

Handle 0x0001
        DMI type 1, 25 bytes.
        System Information
                Manufacturer: To Be Filled By O.E.M.
                Product Name: To Be Filled By O.E.M.
                Version: To Be Filled By O.E.M.
                Serial Number: To Be Filled By O.E.M.
                UUID: Not Settable
                Wake-up Type: Unknown
Handle 0x0002
        DMI type 2, 8 bytes.
        Base Board Information
                Manufacturer: To be filled by O.E.M.
                Product Name: To be filled by O.E.M.
                Version: To be filled by O.E.M.
                Serial Number: To be filled by O.E.M.
Handle 0x0003
        DMI type 3, 17 bytes.
        Chassis Information
                Manufacturer: To Be Filled By O.E.M.
                Type: Desktop
                Lock: Not Present
                Version: To Be Filled By O.E.M.
                Serial Number: To Be Filled By O.E.M.
                Asset Tag: To Be Filled By O.E.M.
                Boot-up State: Unknown
                Power Supply State: Unknown
                Thermal State: Unknown
                Security Status: Unknown
                OEM Information: 0x00000000

Rudolf Marek wrote:

> Andrew wrote:
>
>> Hi All,
>>
>> I have a server (remote, 300kms away) that crash on me yesterday... 
>> Anyhow, I upgraded it to a 2.6 kernel after it came back up, and 
>> installed lm-sensors.  
>
>
> Good. Most likely overheat.
>
>> Sensors-detect found the following modules to install:
>> i2c-piix4
>> w83781d
>> eeprom
>>
>>
>> I have used sensors on about 15 other machines so far, and the 
>> results always seemed to be accurate.  Is there a chance that the 
>> temps could be wrong? (I haven't used this module before). The 
>> machine is reasonably old, so I would not be surprised if the fans 
>> were broken...
>
>
> Well there is always a chance...
>
> Do you know the motherboard manufacturer? maybe we can compare with 
> some database of motherboards to see which thermal lines means what.
>
> Maybe you can try dmidecode utility which should tell you the manuf name.
>
>> w83782d-i2c-0-29
>> Adapter: SMBus PIIX4 adapter at 0580
>> VCore 1:   +1.50 V  (min =  +0.00 V, max =  +4.08 V)
>> VCore 2:   +1.25 V  (min =  +0.00 V, max =  +4.08 V)
>> +3.3V:     +3.31 V  (min =  +2.82 V, max =  +3.79 V)
>> +5V:       +5.08 V  (min =  +4.52 V, max =  +4.30 V)       ALARM
>> +12V:     +11.86 V  (min =  +0.06 V, max =  +0.00 V)       ALARM
>> -12V:      -1.01 V  (min =  -9.65 V, max = -12.28 V)       ALARM
>> -5V:       +2.59 V  (min =  +0.33 V, max =  -0.93 V)       ALARM
>> V5SB:      +5.08 V  (min =  +0.86 V, max =  +3.44 V)       ALARM
>> VBat:      +1.04 V  (min =  +0.03 V, max =  +0.02 V)       ALARM
>> fan1:        0 RPM  (min = 21093 RPM, div = 2)              ALARM
>> fan2:        0 RPM  (min = 16071 RPM, div = 2)              ALARM
>> fan3:        0 RPM  (min = 75000 RPM, div = 2)              ALARM
>
>
> Try changing fan divisor to 4 or 8 if the fan really spins. (but slowly)
>
>> temp1:       +77 C  (high =    +0 C, hyst =    +4 C)   sensor = 
>> thermistor   ALARM
>
>
> Thermistor...  Quite hot down the CPU socket...
>
>> temp2:     +64.0 C  (high =   +80 C, hyst =   +75 C)   sensor = 
>> thermistor
>> temp3:     +64.0 C  (high =   +80 C, hyst =   +75 C)   sensor = 
>> thermistor
>
>
> 64 quite hot inside.
>
> You may try to change the temp inputs to diode to see if there some 
> more reasonable temps...
>
> Suggested steps: change the fan divisor (check fanX_div stuff in 
> sensors conf) to see if the fans still reads 0
> if so maybe someone should check the fan if it is stuck or not + PSU fan.
>
> then you might try to change the sensor type to diode... (set senors 
> stuff)
>
> Best would be to know the motherboard manufacturer/type so we might 
> know what sensors is what...
>
> Regards
> Rudolf



