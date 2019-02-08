From: Pekka Sarnila <sarnila@adit.fi>
Date: Fri, 08 Feb 2019 13:30:41 +0000
Subject: Re: i7-8550U core temps
Message-Id: <44e8e3c5-e2db-2ee8-b6be-19b881c1b00d@adit.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <45b369af-dd8a-0514-815d-3501b1377ad3@adit.fi>
In-Reply-To: <45b369af-dd8a-0514-815d-3501b1377ad3@adit.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Thanks,

yes, didn't have ic2-dev in .config (had looked for I2C_DEV):

# CONFIG_I2C_CHARDEV is not set

And you are right: i7-8550U has got of course only 4 cores (8 threads 
which are shown as 8 CPUs in /proc/cpuinfo as well as in monitor).

I guess it has been in some older Lenovos that thinkpad-isa-0000 showed 
cores temps.

Pekka

On 2/8/19 11:54 AM, Ondřej Lysoněk wrote:
> Hi,
> 
> On 08. 02. 19 1:23, Pekka Sarnila wrote:
>> Lenovo T580: i7-8550U
>> Debian Buster
>> Kernel 4.3.12 (static), .config:
>> ----------------------------------
>> ...
>> CONFIG_I2C_SMBUS=y
>> CONFIG_I2C_ALGOBIT=y
>> ...
>> CONFIG_I2C_I801=y
>> ...
>> ----------------------------------
>>
>> lspci -v
>> -------------------------------------------------------------
>> ...
>> 00:1f.4 SMBus: Intel Corporation Sunrise Point-LP SMBus (rev 21)
>>      Subsystem: Lenovo Sunrise Point-LP SMBus
>>      Flags: medium devsel, IRQ 16
>>      Memory at ed253000 (64-bit, non-prefetchable) [size%6]
>>      I/O ports at efa0 [size2]
>>      Kernel driver in use: i801_smbus
>> ...
>> --------------------------------------------------------------
>>
>> Only 4 core temps reported by sensors (/proc/cpuinfo shows all 8).
>>
>> Senors report:
>> ---------------------------------------------
>> thinkpad-isa-0000
>> Adapter: ISA adapter
>> fan1:           0 RPM
>>
>> coretemp-isa-0000
>> Adapter: ISA adapter
>> Package id 0:  +45.0°C  (high = +100.0°C, crit = +100.0°C)
>> Core 0:        +44.0°C  (high = +100.0°C, crit = +100.0°C)
>> Core 1:        +43.0°C  (high = +100.0°C, crit = +100.0°C)
>> Core 2:        +43.0°C  (high = +100.0°C, crit = +100.0°C)
>> Core 3:        +44.0°C  (high = +100.0°C, crit = +100.0°C)
>>
>> acpitz-virtual-0
>> Adapter: Virtual device
>> temp1:        +44.0°C  (crit = +98.0°C)
>>
>> pch_skylake-virtual-0
>> Adapter: Virtual device
>> temp1:        +40.0°C
>>
>> iwlwifi-virtual-0
>> Adapter: Virtual device
>> temp1:        +34.0°C
>> ------------------------------------------------
>>
>> sensors-detect complains:
>>
>> -------------------------------------------------
>> Do you want to probe the I2C/SMBus adapters now? (YES/no):
>> Using driver `i2c-i801' for device 0000:00:1f.4: Sunrise Point-LP (PCH)
>> modprobe: FATAL: Module i2c-dev not found in directory /lib/modules/4.13.12
>> Failed to load module i2c-dev.
>> ------------------------------------------------
>>
>> Of course module can not be loaded in a static kernel. IMHO detection
>> should not depend on that.
> 
> sensors-detect checks if /sys/class/i2c-dev/ exists before trying to
> load i2c-dev. Does that directory exist on your system?
> 
>> Is this the reason for not showing any core temps under thinkpad-isa-0000?
> 
> No, I think it's normal that no temperatures are shown there.
> 
>> Why only 4 under coretemp-isa-0000?
> 
> Presumably because you don't have an 8 core CPU. You have a 4 core CPU
> with hyperthreading enabled.
> 
> Ondřej Lysoněk
> 
