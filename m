From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 18 Jul 2013 21:37:40 +0000
Subject: Re: [lm-sensors] [PATCH v4 2/2] i2c_imc: New driver for Intel's iMC, found on LGA2011 chips
Message-Id: <CALCETrUUkSenOD1KS7rrVV1czjhTJ-c1sFebrDygcCB+5Y2upA@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1374171757.git.luto@amacapital.net> <c4bb014e8793e8d0059ecf5633f01ab9e15409d2.1374171757.git.luto@amacapital.net>
 <20130718213331.GA6237@roeck-us.net>
In-Reply-To: <20130718213331.GA6237-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, James Ralston <james.d.ralston-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

On Thu, Jul 18, 2013 at 2:33 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Jul 18, 2013 at 11:36:54AM -0700, Andy Lutomirski wrote:
>> Sandy Bridge Xeon and Extreme chips have integrated memory controllers
>> with (rather limited) onboard SMBUS masters.  This driver gives access
>> to the bus.
>>
>> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
>> ---
>>  drivers/i2c/busses/Kconfig   |  15 ++
>>  drivers/i2c/busses/Makefile  |   1 +
>>  drivers/i2c/busses/i2c-imc.c | 548 +++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 564 insertions(+)
>>  create mode 100644 drivers/i2c/busses/i2c-imc.c
>>
>> diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
>> index e837f0e..7636782 100644
>> --- a/drivers/i2c/busses/Kconfig
>> +++ b/drivers/i2c/busses/Kconfig
>> @@ -137,6 +137,21 @@ config I2C_DIMM_BUS
>>         tristate
>>         default n
>>
>> +config I2C_IMC
>> +     tristate "Intel iMC (LGA 2011) SMBus Controller"
>> +     depends on PCI && X86
>> +     select I2C_DIMM_BUS
>> +     help
>> +       If you say yes to this option, support will be included for the Intel
>> +       Integrated Memory Controller SMBus host controller interface.  This
>> +       controller is found on LGA 2011 Xeons and Core i7 Extremes.
>> +
>> +       It is possibly, although unlikely, that the use of this driver will
>> +       interfere with your platform's RAM thermal management.
>> +
>> +       This driver can also be built as a module.  If so, the module will be
>> +       called i2c-imc.
>> +
>>  config I2C_PIIX4
>>       tristate "Intel PIIX4 and compatible (ATI/AMD/Serverworks/Broadcom/SMSC)"
>>       depends on PCI
>> diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
>> index 226bb2e..790b63d 100644
>> --- a/drivers/i2c/busses/Makefile
>> +++ b/drivers/i2c/busses/Makefile
>> @@ -15,6 +15,7 @@ obj-$(CONFIG_I2C_AMD8111)   += i2c-amd8111.o
>>  obj-$(CONFIG_I2C_I801)               += i2c-i801.o
>>  obj-$(CONFIG_I2C_ISCH)               += i2c-isch.o
>>  obj-$(CONFIG_I2C_ISMT)               += i2c-ismt.o
>> +obj-$(CONFIG_I2C_IMC)                += i2c-imc.o
>>  obj-$(CONFIG_I2C_NFORCE2)    += i2c-nforce2.o
>>  obj-$(CONFIG_I2C_NFORCE2_S4985)      += i2c-nforce2-s4985.o
>>  obj-$(CONFIG_I2C_PIIX4)              += i2c-piix4.o
>> diff --git a/drivers/i2c/busses/i2c-imc.c b/drivers/i2c/busses/i2c-imc.c
>> new file mode 100644
>> index 0000000..9643aeb
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-imc.c
>
> [ ... ]
>
>> +
>> +     i2c_scan_dimm_bus(&ch->adapter);
>> +
> Wonder if this should (can) be part of the infrastructure, eg by introducing
> I2C_CLASS_DIMM.

If so, it'll have to work differently than the current class bits.
All they do is determine which drivers get detected, and that
detection happens by completely generic means that's not really
applicable to DIMMs (and doesn't work on this bus).


--Andy

-- 
Andy Lutomirski
AMA Capital Management, LLC

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
