From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:14 +0000
Subject: Ticket #1376
Message-Id: <3F49A1C9.3000403@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030817003245.GA12961@hurg.org>
In-Reply-To: <20030817003245.GA12961@hurg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

 From sensors_detect, it looks like he *does* have an ADM1021 compatible 
device.  But because two drivers detected the chip, an incorrect modules.conf 
config was generated that told adm1021 to IGNORE the address that was detected.

Please try commenting out the following line in /etc/modules.conf

    options adm1021 ignore=0,0x2b

and then execute:

    rmmod adm1021
    modprobe adm1021

Then let's see what you get from sensors.

As for the "Can't access" error, it looks like the driver isn't exporting a 
variable that libsensors is expecting.

The variable is:
    {CTL_DEV, 2, 101, 4b2}

Where 0x4b2 is 1202 decimal and in the w83627hf.c or w83781d.c driver is 
W83781D_SYSCTL_TEMP3 and is only listed in
w83782d_isa_dir_table_template and not in w83697hf_dir_table_template

There are two potential fixes:

1. In /etc/sensors.conf, in the w83697hf section, add:

     ignore temp3

2. Fix libsensors so that for the w83697hf it doesn't try and print temp3.

:v)


Johannes Wei?l wrote:

> On 2003-08-24 10:24:50, Jean Delvare wrote:
>>Before you do that, however, I'm interested in the adm1021 problem. You
>>don't seem to have such a chip on your system, so I wonder why
>>sensors-detect told you to use it. Could you please provide a full log
>>of sensors-detect? Please unload all chip drivers (adm1021, eeprom,
>>w83781d) before running sensors-detect again.
>>
> 
> I've attached a "LOG" file ...
> 
> 
>>The two suspects left are: libsensors, and sensors itself. I'm not fully
>>qualified to track that kind of bug. I think that Philip Pokorny would
>>be much more that I am. In a similar case, he suggested to use "strace
>>-o /tmp/sensors.strace sensors -s". Maybe we can start with that.
>>
> 
> here it is
> 
> 
>>Maybe the problem is that sensors drops its root priviledges at some
>>point. But I don't know why nor how it could do that. All I know is that
>>only Debian-system-based (or clones) users have reported the problem,
>>which is probably not a simpe coincidence. What's more, I think I
>>remember the i2c-isa module was in use each time. That too is probably
>>not a coincidence. What do Debian systems have particular, and what does
>>the i2c-isa module do that other bus drivers don't?
>>
> 
> hmm, as far as I know, Debian is nearly completely FHS compatible ...
> and the module-handling is different from the other distributions
> (update-modules, /etc/modutils, ...)
> 
> I've never used another distribution, so I don't know what's different.

> Probing for `Maxim MAX1617'... Success!
>     (confidence 3, driver `adm1021')
> Probing for `National Semiconductor LM84'... Success!
>     (confidence 6, driver `adm1021')


> Driver `adm1021' (should be inserted but causes problems):
>   Detects correctly:
>   * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x2b
>     Chip `National Semiconductor LM84' (confidence: 6)
>   Misdetects:
>   * Bus `SMBus Via Pro adapter at 5000' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x2b
>     Chip `Maxim MAX1617' (confidence: 3)


> To make the sensors modules behave correctly, add these lines to either
> /etc/modules.conf or /etc/conf.modules:
> 
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> options adm1021 ignore=0,0x2b
> #----cut here----


> ------------------------------------------------------------------------


 
> _sysctl({{CTL_DEV, 2, 101, 4b1}, 4, 0x40039be0, 12, (nil), 0}) = 0
> _sysctl({{CTL_DEV, 2, 101, 4b1}, 4, (nil), 1074247997, 0x40039be0, 4}) = 0
> _sysctl({{CTL_DEV, 2, 101, 4b1}, 4, 0x40039be0, 12, (nil), 0}) = 0
> _sysctl({{CTL_DEV, 2, 101, 4b1}, 4, (nil), 1074247997, 0x40039be0, 8}) = 0
> _sysctl({{CTL_DEV, 2, 101, 4b2}, 4, 0x40039be0, 4096, (nil), 0}) = -1 ENOTDIR (Not a directory)
> _sysctl({{CTL_DEV, 2, 101, 4b2}, 4, 0x40039be0, 4096, (nil), 0}) = -1 ENOTDIR (Not a directory)
> write(2, "w83697hf-isa-0290: Can\'t access "..., 56) = 56
> write(2, "Run as root?\n", 13)          = 13
> exit_group(0)                           = ?
> 

