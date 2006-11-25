From: r.marek@assembler.cz (Rudolf Marek)
Date: Sat, 25 Nov 2006 21:10:33 +0000
Subject: [lm-sensors] Tyan S2877 CPU Temp Erratic
Message-Id: <4568B149.1030302@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1163375222.4557b2764fc69@mail.third-rock.net>
In-Reply-To: <1163375222.4557b2764fc69@mail.third-rock.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> What would it look like if I add a second physical processor in
> the second socket? Would I get the same lmsensor names repeated?

Yes, it will be just new instance of the driver. So, there will be 
k8temp-pci-00xx where xx is something else here for next physical CPU (in fact 
it is PCI bus address)

> Here are the logs.
> It looks like a timeout problem....
> 
> syslog:Nov 25 08:31:58 discover kernel: i2c /dev entries driver
> syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-9191: ISA main adapter
> registered
> syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-0: nForce2 SMBus adapter
> at 0xa000
> syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-1: nForce2 SMBus adapter
> at 0xa040
> syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-0: SMBus Timeout! (0x10)
> syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-1: SMBus Timeout! (0x10)
> syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-9191: Driver w83627hf
> registered
> syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-0: SMBus Timeout! (0x10)
> syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-1: SMBus Timeout! (0x10)
> syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-9191: Driver w83781d-isa
> registered
> syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-0: SMBus Timeout! (0x10)
> syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-1: SMBus Timeout! (0x10)
> syslog:Nov 25 08:31:58 discover kernel: i2c_adapter i2c-1: SMBus Timeout! (0x10)


Well this is from probing phase. It might happen that the probed devices are not 
on that address. It seems the SMBus controller follows the ACPI 2.00 proposal 
(13.9.1.1 Status Register, SMB_STS ), and 0x10 means: Indicates the transaction 
failed because the slave device address was not acknowledged.

I will need part of the log just after you issued the "sensors" command. (when 
there is some error in log...) also when you will have the error condition, 
(strange temperature) please send the output of following command:

i2cdump -y 1 0x2e

This will show if the chip reports sane values in registers, if so then there is 
something wrong with the "analog" path to the chip.

Does it work when you poweroff the machine - unplug the power cable? And try 
again? What kernel are you using? When it was not working and you entered the 
BIOS I guess it worked in there? (no need to hurry with real test, the i2cdump 
will be enough maybe)

Problem is that I dont have the nVidia datasheet, so I need to guess, when it 
will turn out that there is a problem with bus driver...

Regards
Rudolf




