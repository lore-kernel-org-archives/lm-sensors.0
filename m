From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 01 Nov 2007 21:58:58 +0000
Subject: Re: [lm-sensors] What to use as prefix for TI TMP401 IC,
Message-Id: <472A4C22.30709@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4722FB3C.9010402@hhs.nl>
In-Reply-To: <4722FB3C.9010402@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Sun, 28 Oct 2007 21:09:37 +0100, Jean Delvare wrote:
>> On Sun, 28 Oct 2007 15:24:06 +0100, Hans de Goede wrote:
>>> Jean Delvare wrote:
>>>> Also, I suggest that you add detection for the TMP401 to sensors-detect
>>>> right away. That's the best way to find early testers for your work.
>>> Done. (not tested I don't have access to the actual hardware at this moment).
>> In this kind of situation, I can only recommend using Mark Hoffman's
>> i2c-stub driver. It allows emulating one or more I2C/SMBus chips from
>> dumps. It works as follows:
>>
>> * On the machine with the chip, use i2cdump to dump the registers of
>> the chip:
>>
>> i2cdump -y 0 0x4c b > tmp401.dump
>>
>> * On your own workstation, build the i2c-stub driver
>> (CONFIG_I2C_STUB=m) and load it. You must pass the chip address as a
>> parameter, so that the driver will emulate a chip at this specific
>> address:
>>
>> modprobe i2c-stub chip_addr=0x4c
>>
>> * Program the emulated chip from the dump. Get my helper script from:
>>
>> http://jdelvare.pck.nerim.net/sensors/stub-from-dump.pl
>>
>> Run that script on the dump and it will generate a shell script to
>> program the emulated chip:
>>
>> ./stub-from-dump.pl tmp401.dump > set_tmp401.sh
>>
>> Then as root, run the script in question:
>>
>> sh set_tmp401.sh 6 0x4c
>>
>> Adjust the bus number so that it matches those of i2c-stub, check with
>> i2cdetect -l. The script simply runs i2cset for each register.
>>
>> At this point you have an emulated chip to play with. It will let you
>> test sensors-detect, device detection at driver load, the sysfs
>> interface, etc.
>>
>> Limitations:
>> * Driver must only use byte register access. i2c-stub supports word
>>   access by my script doesn't (yet).
>> * Device must not have banks (as Winbond devices do).
>> * You can't test alarms this way, obviously.
>>
>> Beware that i2c-stub is very verbose and will flood your logs. This
>> might help a lot when debugging the driver though.
>>
>> If this proves useful, I should probably cleanup stub-from-dump.pl and
>> include it in i2c-tools so that others can benefit.
> 
> I've committed an improved version of this script to the i2c-tools
> repository. This version programs the i2c-stub chip directly rather
> than generating an intermediate shell script. It also loads the
> i2c-stub driver automatically, and detects its number automatically as
> well.
> 
> I've also added a manual page so that hopefully more developers can use
> it.
> 

Sounds good!

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
