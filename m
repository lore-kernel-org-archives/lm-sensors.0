From: Wolfgang Grandegger <wg@grandegger.com>
Date: Wed, 13 Aug 2008 13:48:14 +0000
Subject: Re: [lm-sensors] New style driver for w83781d?
Message-Id: <48A2E61E.7070600@grandegger.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4899A4F7.70201@grandegger.com>
In-Reply-To: <4899A4F7.70201@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Wolfgang,
> 
> On Wed, 13 Aug 2008 12:14:29 +0200, Wolfgang Grandegger wrote:
>> Jean Delvare wrote:
>>> On Tue, 12 Aug 2008 11:28:54 +0200, Wolfgang Grandegger wrote:
>>>> Jean Delvare wrote:
>>>>> Hi Wolfgang,
>>>>>
>>>>> On Tue, 12 Aug 2008 10:55:58 +0200, Wolfgang Grandegger wrote:
>>>>>> We need support for the MON35W42 on an embedded MPC8544 board, which 
>>>>>> seems to be compatible with the w83782d. There are more issues, e.g. the 
>>>>>> early ISA bus probing of the existing driver hangs the system. Maybe i2c 
>>>>>> probing should be done first!?
>>>>> If both interfaces are available, we want to use the ISA one, because
>>>>> it's much faster, so it must be registered first.
>>>>>
>>>>> What could be done though would be disabling the ISA interface
>>>>> altogether on architectures where it isn't supported (in particular
>>>>> PPC.) This shouldn't be too difficult. If you write a patch doing this,
>>>>> I'll be happy to review it. Affected drivers would be w83781d and lm78.
>>>> Some PPC have an ISA bus as well:
>>>>
>>>>    http://lxr.linux.no/linux+v2.6.26.2/arch/powerpc/Kconfig#L494
>>>>
>>>> I think selecting the ISA code with '#ifdef CONFIG_ISA' would be the 
>>>> right solution?
>>> Agreed.
>> See the attached patch below. When I have some more free time, I will
>> convert the driver to new style as well.
> 
> Weren't you supposed to work on top of my 2 patches? Please do,
> especially when my patches have an impact on the relation between the
> ISA device and potential I2C devices.

Sorry, I forgot about them :-(.

> 
> Your patch breaks the build with CONFIG_ISA=y:
> 
>   CC [M]  drivers/hwmon/w83781d.o
> drivers/hwmon/w83781d.c: In function `w83781d_read_value_i2c_isa':
> drivers/hwmon/w83781d.c:1668: error: `client' undeclared (first use in this function)
> drivers/hwmon/w83781d.c:1668: error: (Each undeclared identifier is reported only once
> drivers/hwmon/w83781d.c:1668: error: for each function it appears in.)
> drivers/hwmon/w83781d.c:1660: warning: unused variable `bank'
> drivers/hwmon/w83781d.c: In function `w83781d_write_value_i2c_isa':
> drivers/hwmon/w83781d.c:1694: warning: unused variable `bank'
> drivers/hwmon/w83781d.c:1695: warning: unused variable `cl'
> drivers/hwmon/w83781d.c: In function `w83781d_isa_add_driver':
> drivers/hwmon/w83781d.c:1967: error: `w83781d_read_value_isa' undeclared (first use in this function)
> drivers/hwmon/w83781d.c:1968: error: `w83781d_write_value_isa' undeclared (first use in this function)
> drivers/hwmon/w83781d.c: At top level:
> drivers/hwmon/w83781d.c:1659: warning: 'w83781d_read_value_i2c_isa' defined but not used
> drivers/hwmon/w83781d.c:1692: warning: 'w83781d_write_value_i2c_isa' defined but not used
> make[2]: *** [drivers/hwmon/w83781d.o] Error 1
> make[1]: *** [drivers/hwmon] Error 2
> make: *** [drivers] Error 2

> Apparently you didn't test that case - you really have to.

I thought I did but... Anyway, I cannot really test the ISA interface 
because I just have an embedded PowerPC board with a w83782.

> I am surprised by the size of your patch. I expected something much
> smaller and less intrusive than that. As I understand it, you tried to
> optimize the case CONFIG_ISA=n. Did you check how much exactly this was
> saving? I guess not much.

I mainly moved all ISA related code within one #ifdef ... #endif block 
to avoild plenty of #ifdef's. Furthermore I splitted up the register 
read and write function for i2c and isa and introduced function pointers 
for w83781d_read_value and w83781d_write_value.

> I don't think that going to this level of optimization is needed. Or,
> if you insist on doing it, that would be a separate patch. The first
> patch should really only move things around to group them inside the
> #ifdef/#endif, and skip the detection of the ISA device and
> registration of the platform driver. You shouldn't have to modify the
> actual driver code.

I did not do any optimization saving code.

>> (...)
>> +static int __devinit
>> +w83781d_isa_add_driver(void)
>> +{
>> +	int res;
>>  
>>  	if (w83781d_isa_found(isa_address)) {
>>  		res = platform_driver_register(&w83781d_isa_driver);
>>  		if (res)
>> -			goto exit_unreg_i2c_driver;
>> +			goto exit;
>>  
>>  		/* Sets global pdev as a side effect */
>>  		res = w83781d_isa_device_add(isa_address);
>>  		if (res)
>>  			goto exit_unreg_isa_driver;
>> -	}
>>  
>> +		/* Use ISA bus to access registers */
>> +		w83781d_read_value = w83781d_read_value_isa;
>> +		w83781d_write_value = w83781d_write_value_isa;
> 
> You can't do that. It is possible, and perfectly valid, to have two
> supported chips on the same system, one on the ISA bus and one on an
> I2C bus. I do have a system like that, with a W83781D on the
> motherboard's ISA bus and a W83783S on the graphics adapter. The bus
> type (and thus the register access method) is really a chip-specific
> and not driver-wide.

I do not see a functional difference to the existing driver. If ISA 
probing is  successful, the device will be accessd with ISA bus, 
otherwise via I2C bus. Did I miss something?

Sorry for the bad quality of my patch. It was done in a hurry :-(.

Wolfgang.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
