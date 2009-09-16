From: =?UTF-8?B?TWFydGluIE1PS1JFSsWg?= <mmokrejs@ribosome.natur.cuni.cz>
Date: Wed, 16 Sep 2009 16:48:43 +0000
Subject: Re: [lm-sensors] unhide_ICH_SMBus: line 33:
Message-Id: <4AB116EB.7000707@ribosome.natur.cuni.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9122E1.7010006@ribosome.natur.cuni.cz>
In-Reply-To: <4A9122E1.7010006@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Tue, 15 Sep 2009 18:41:41 +0200, Martin MOKREJŠ wrote:
>> Jean Delvare wrote:
>>> On Tue, 15 Sep 2009 17:43:19 +0200, Martin MOKREJŠ wrote:
>>>> $ gzip -dc /proc/config.gz | grep THERMAL
>>>> CONFIG_ACPI_THERMAL=y
>>>> CONFIG_THERMAL=y
>>>> CONFIG_THERMAL_HWMON=y
>>>> $ gzip -dc /proc/config.gz | grep ATK
>>>> CONFIG_KEYBOARD_ATKBD=y
>>>> CONFIG_SENSORS_ATK0110=y
>>>> $
>>>>
>>>> These I have already in the kernel, so I can drop the whole SMbus thing?
>>> Yes.
>> Ooops, are we talking about I2C_I801=N, I2C=N or SENSORS_DS1621=N? ;-)
> 
> ENSORS_DS1621=N and I2C_I801=N, yes. I2C=N, bad idea, you might need
> I2C support for something else.

$ sensors 
max6657-i2c-4-4c
Adapter: SMBus I801 adapter at e800
M/B Temp:  +39.1°C  (low  =   -55°C, high =  +127°C)   
CPU Temp:  +49.2°C  (low  = +48.0°C, high = +62.0°C)   
M/B Crit:    +85°C  (hyst =   +75°C)                  
CPU Crit:    +75°C  (hyst =   +65°C)                  

$
> 
>> Actually I had SENSORS_LM90=Y as it was also proposed by sensors-detect.
>> That one was also mis-detected?
> 
> I can't tell as your sensors-detect report was incomplete (with ds1621
> loaded, sensors-detect can't probe the chip). I'm not sure why you are
> hard-building all the drivers that way, BTW, it makes investigating
> problems much harder. Probably the LM90 detection was correct, as these
> chips are much more reliably detected than the DS1621.
> 
> Anyway, as further kernels say that ACPI is conflicting with the native
> SMBus controller driver, the only safe bet is to drop i2c-i801 and go
> with the ACPI thermal driver instead.

So doing that lm90 driver does not find any hardware chip and sensors
do not see therefore anything either. modprob-ing ATK0110 driver surprisingly
doesn't give anything either (lsmod reports it is unused and nothing new in
dmesg). 

Dropping i2c-i801 seems like a bad idea. ;-)

What do you propose now? Some debug flags for insmod when inserting the atk*
driver?

M.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
