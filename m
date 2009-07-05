From: Dan Davison <davison@stats.ox.ac.uk>
Date: Sun, 05 Jul 2009 18:10:04 +0000
Subject: Re: [lm-sensors] pwmconfig failure under Ubuntu Intrepid with Intel
Message-Id: <87prcfknlv.fsf@stats.ox.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081124013830.GA9778@stats.ox.ac.uk>
In-Reply-To: <20081124013830.GA9778@stats.ox.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I don't think I ever thanked you for this helpful reply. It's summer
again, and I'm getting annoyed by my laptop fan again, and I had cause
to re-read your email. Thanks.

Dan

Jean Delvare <khali@linux-fr.org> writes:

> Hi Dan,
>
> On Sun, 23 Nov 2008 20:38:30 -0500, Dan Davison wrote:
>> pwmconfig fails with the message
>> 
>>   /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
>> 
>> Looking at the pwmconfig shell-script, the error occurs because there are no pwm* files in the relevant place:
>> 
>> ~> ls /sys/class/hwmon/hwmon*/device/
>> /sys/class/hwmon/hwmon1/device/:
>> driver  hwmon  modalias  name  power  subsystem  temp1_crit  temp1_crit_alarm  temp1_input  temp1_label  uevent
>> 
>> /sys/class/hwmon/hwmon2/device/:
>> driver  hwmon  modalias  name  power  subsystem  temp1_crit  temp1_crit_alarm  temp1_input  temp1_label  uevent
>> 
>> 
>> However, despite a few hours googling, I am unclear whether there is
>> any hope that I can get this working, and if so what to do next. This
>> is a Fujitsu-Siemens Lifebook S Series laptop which has the an Intel
>> Core Duo processor with Intel 945GM chipset, and is running Ubuntu
>> Intrepid (fully updated).
>
> On most recent laptops, thermal management is handled by ACPI. No
> hardware monitoring chips are exposed to the OS and thus software-based
> fan speed control is not possible (and most often not desirable either
> - the ACPI-based control should work just fine.)
>
>> I've looked at http://www.lm-sensors.org/wiki/Devices, but don't fully
>> understand the information there. Under SENSOR CHIP DRIVERS there is
>> this entry
>> 
>> Intel   Core, Core 2  yes  coretemp   2.6.22  (2007-03-25) Integrated sensor in CPU. Driver contributed by Rudolf Marek. 
>> 
>> Is this good news, or is it saying that there's just temperature stuff
>> but no fan control?
>
> The coretemp driver lets you read the CPU temperature value of Intel
> Core and later CPU models. It is not a hardware monitoring chip driver,
> so, no fan speed readings nor control.
>
>> and under I2C/SMBUS BUS DRIVERS there are several entries for Intel
>> none of which obviously correspond to my hardware.
>> 
>> I've run sensors-detect which results in (full output at bottom) 
>> 
>> Driver `smartbatt' (should be inserted):
>
> FWIW, the smartbatt driver is a legacy thing for Linux 2.4. I seem to
> remember that ACPI is taking care of this now (at least on some laptop
> models). The ACPI driver is named sbs. We should no longer recommend
> the smartbatt driver.
>
>>   Detects correctly:
>>   * Bus `SMBus I801 adapter at 18e0'
>>     Busdriver `i2c-i801', I2C address 0x0b
>>     Chip `Smart Battery' (confidence: 5)
>> 
>> Driver `coretemp' (should be inserted):
>>   Detects correctly:
>>   * Chip `Intel Core family thermal sensor' (confidence: 9)
>> 
>> This coretemp module is loaded and is providing temperature
>> readings. I don't know if it has anything to do with fan control.
>
> No, it doesn't. It is a simple temperature-only driver.
>
>> 
>> Running sensors gives
>> 
>> ~> sensors
>> acpitz-virtual-0
>> Adapter: Virtual device
>> temp1:       +26.8°C  (crit = +100.0°C)                  
>> temp2:       +26.8°C  (crit = +100.0°C)                  
>> 
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Core 0:      +43.0°C  (crit = +100.0°C)                  
>> 
>> coretemp-isa-0001
>> Adapter: ISA adapter
>> Core 1:      +43.0°C  (crit = +100.0°C)            
>> 
>> 
>> (I have not observed the first two temperatures be anything other than
>> 26.8).
>
> These are the ACPI temperatures, if they never change, this suggests
> that the ACPI implementation of your laptop is broken. Upgrading the
> BIOS might help. As a side note, the value 26.8 itself is pretty
> suspicious, considering that 26.8 + 273.2 (the difference between the
> degree C and Kelvin scales) = 300.
>
>> I'd like to be able to modify my fan behaviour but don't know what to
>> do in order that pwmconfig runs. Thanks very much for any help. Full
>> output from sensors-detect follows.
>
> pwmconfig will most likely never work on your system, sorry. If you
> need to control your fans, and if this can indeed be done, this will
> either be done through ACPI, or through a laptop-specific kernel driver.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
