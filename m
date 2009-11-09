From: Rim Shao <rim.shao@ericsson.com>
Date: Mon, 09 Nov 2009 08:50:27 +0000
Subject: Re: [lm-sensors] lm sensors help
Message-Id: <EDE287309C3D8141BC2A1DB7D9F8925D01C2E0A267@ESGSCCMS0002.eapac.ericsson.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <EDE287309C3D8141BC2A1DB7D9F8925D01C2D683EC@ESGSCCMS0002.eapac.ericsson.se>
In-Reply-To: <EDE287309C3D8141BC2A1DB7D9F8925D01C2D683EC@ESGSCCMS0002.eapac.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Delvare 

Thanks for your value information.
I am using the SLES10(SUSE Linux Enterprise Server By Novell) SP 2, the runing kernel is 2.6.16.60-0.21-smp.
After I use the latest sensors-detect and the output is pasted below. I got that my chip is 'IPMI BMC KCS'.


=========
# ./sensors-detect
# sensors-detect revision 5729 (2009-06-02 15:51:29 +0200)
# System: Hewlett-Packard ProLiant DL380 G6

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal and voltage sensors...                       No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found `SMSC SCH4307 Super IO Fan Sensors'                   Success!
    (address 0x300, driver `to-be-written')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no):
Found `IPMI BMC KCS' at 0xca2...                            Success!
    (confidence 8, driver `ipmisensors')

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO):

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Sorry, no supported PCI bus adapters found.
Module i2c-dev loaded successfully.

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `to-be-written':
  * ISA bus, address 0x300 (Busdriver `i2c-isa')
    Chip `SMSC SCH4307 Super IO Fan Sensors' (confidence: 9)

Driver `coretemp':
  * Chip `Intel Core family thermal sensor' (confidence: 9)

Driver `ipmisensors':
  * ISA bus, address 0xca2 (Busdriver `i2c-isa')
    Chip `IPMI BMC KCS' (confidence: 8)

Note: there is no driver for SMSC SCH4307 Super IO Fan Sensors yet.
Check http://www.lm-sensors.org/wiki/Devices for updates.

Warning: the required module coretemp is not currently installed
on your system. If it is built into the kernel then it's OK.
Otherwise, check http://www.lm-sensors.org/wiki/Devices for
driver availability.

Warning: the required module ipmisensors is not currently installed
on your system. If it is built into the kernel then it's OK.
Otherwise, check http://www.lm-sensors.org/wiki/Devices for
driver availability.

No modules to load, skipping modules configuration.

Unloading i2c-dev... OK

=========


-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Friday, November 06, 2009 8:46 PM
To: Rim Shao
Cc: lm-sensors@lm-sensors.org; Zhenjie Wang
Subject: Re: lm sensors help

Hi Shao,

On Tue, 3 Nov 2009 17:02:42 +0800, Rim Shao wrote:
> I use the sensors to collect the hardware information(fan speed/cpu 
> temperature/voltage) on HP workstation FF825AV with SUSE Linux 10

Which version of "SUSE Linux 10" are you using exactly? Except for SLE products, they are all unmaintained by now and I wouldn't recommend using them any longer.

> installed, and I installed lm_sensors-3.0.2-1 and i2c-tools-3.0.2 package to my system. Then I executed the 'sensors' on the shell console and got the errors below.
> 
> ===============
> linux-ipworks:/mnt # sensors
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
> ===============
> 
> 
> also I type the sensors-detect to detect which sensor chip in my hardware. But I was told that there is no chips found, and I confirm with HP service support that this workstation surely have sensors embeded on the motherboard.

Would they tell you which chip is used for the hardware monitoring?
This would help us for sure.

> I posted the output of the command below. can you please help to find little clew ? your valuable information are appreciated!
> 
> 
> ===============
> linux-ipworks:/mnt # sensors-detect
> # sensors-detect revision 1.413 (2006/01/19 20:28:00)
> (...)

This is very old, an definitely not from lm-sensors 3.0.2 which you wrote you were using. Please double-check which version of the "sensors" package you have installed.

Even better would be to try the latest version of the sensors-detect
script:
http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

(Our server seems to be very slow today, I hope you still manage to download that file.)

> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for `ITE 8702F Super IO Sensors'
>   Failed! (0x8c01)
> Probing for `ITE 8705F Super IO Sensors'
>   Failed! (0x8c01)
> Probing for `ITE 8712F Super IO Sensors'
>   Failed! (0x8c01)
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87591 Super IO'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC87371 Super IO'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC97371 Super IO'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC8739x Super IO'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PC8741x Super IO'
>   Failed! (0x8c)
> Probing for `Nat. Semi. PCPC87427 Super IO'
>   Failed! (0x8c)
> Probing for `SMSC 47B27x Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `SMSC 47M14x Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `SMSC 47M15x/192/997 Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `SMSC 47S42x Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `SMSC 47S45x Super IO Fan Sensors'
>   Failed! (0x8c)
> Probing for `SMSC 47M172 Super IO'
>   Failed! (0x8c)
> Probing for `SMSC LPC47B397-NC Super IO'
>   Failed! (0x8c)
> Probing for `SMSC SCH5307-NS Super IO'
>   Failed! (0x8c)
> Probing for `VT1211 Super IO Sensors'
>   Failed! (skipping family)
> Probing for `Winbond W83627EHF/EHG Super IO Sensors'
>   Failed! (skipping family)

Could be an SMSC SCH5317, hopefully a more recent version of sensors-detect will confirm. We have partial support for this chip, since kernel 2.6.25. Which kernel are you running?

--
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
