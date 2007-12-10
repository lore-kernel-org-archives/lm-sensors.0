From: Peter Ganzhorn <peter.ganzhorn@googlemail.com>
Date: Mon, 10 Dec 2007 18:12:36 +0000
Subject: Re: [lm-sensors] Intel Core voltage monitoring
Message-Id: <475D8194.1000207@googlemail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <475BDA45.70400@googlemail.com>
In-Reply-To: <475BDA45.70400@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for your reply - is it possible that I am missing a driver to 
access my smbus? I enabled the i2C driver for the ICH8 chips 
(CONFIG_I2C_I801) and that's about it.

I investigated the cpu-z output as well and it seems it is using the 
current VID setting to display the voltage - there seem to be no 
fluctuations in voltage which is kinda strange for real hardware...

And BTW, I ommitted some obvious useless output of sensors-detect which 
I consider to be smbus-related; but it looks like smbus is a complete no-go:

# sensors-detect revision 4609 (2007-07-14 09:28:39 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Sorry, no known PCI bus adapters found.

We will now try to load each adapter module in turn.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

If you can think of any other way to see what *real* vcore my cpu runs 
with let me know, but I am afraid it won't be possible considering what 
you've told me.
Thanks anyways for the great job you are doing with sensors,

Peter


Jean Delvare wrote:
> Hi Peter,
>
> On Sun, 09 Dec 2007 13:06:29 +0100, Peter Ganzhorn wrote:
>   
>> BTW: I have a Toshiba Tecra A9 notebook on which lm_sensors can't 
>> identify the hardware monitoring chips:
>>
>> Some chips are also accessible through the ISA I/O ports. We have to
>> write to arbitrary I/O ports to probe them. This is usually safe though.
>> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
>> Do you want to scan the ISA I/O ports? (YES/no):
>> Probing for `National Semiconductor LM78' at 0x290...       No
>> Probing for `National Semiconductor LM78-J' at 0x290...     No
>> Probing for `National Semiconductor LM79' at 0x290...       No
>> Probing for `Winbond W83781D' at 0x290...                   No
>> Probing for `Winbond W83782D' at 0x290...                   No
>> Probing for `Silicon Integrated Systems SIS5595'...         No
>> Probing for `VIA VT82C686 Integrated Sensors'...            No
>> Probing for `VIA VT8231 Integrated Sensors'...              No
>> Probing for `IPMI BMC KCS' at 0xca0...                      No
>> Probing for `IPMI BMC SMIC' at 0xca8...                     No
>>
>> Some Super I/O chips may also contain sensors. We have to write to
>> standard I/O ports to probe them. This is usually safe.
>> Do you want to scan for Super I/O sensors? (YES/no):
>> Probing for Super-I/O at 0x2e/0x2f
>> Trying family `National Semiconductor'...                   No
>> Trying family `SMSC'...                                     Yes
>> Found unknown non-standard chip with ID 0x7a
>> Probing for Super-I/O at 0x4e/0x4f
>> Trying family `National Semiconductor'...                   No
>> Trying family `SMSC'...                                     Yes
>> Found unknown chip with ID 0x0b00
>>
>> Some CPUs or memory controllers may also contain embedded sensors.
>> Do you want to scan for them? (YES/no):
>> AMD K8 thermal sensors...                                   No
>> Intel Core family thermal sensor...                         Success!
>>     (driver `coretemp')
>> Intel AMB FB-DIMM thermal sensor...                         No
>>
>>
>> coretemp works just fine, but I have no way of monitoring anything else 
>> which is quite unsatisfying to me...
>> Maybe you guys can help me monitoring at least vcore!
>>     
>
> Your sensors-detect output doesn't include the SMBus scan, I guess that
> the SMBus is hidden. I've seen this before on Toshiba laptops, and
> after investigation we found that the SMBus was being accessed by SMM
> code, so it's not safe to let Linux access it. That's a design decision
> by the manufacturer, there's nothing we can do. You might be able to
> get the fan reading using the toshiba_acpi driver, but that's about it.
>
>   


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
