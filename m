From: linux@horizon.com
Date: Wed, 12 Dec 2007 12:07:40 +0000
Subject: Re: [lm-sensors] Intel Core voltage monitoring
Message-Id: <20071212120740.6643.qmail@science.horizon.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <475BDA45.70400@googlemail.com>
In-Reply-To: <475BDA45.70400@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> There has been a driver doing that in kernel 2.6.18 to 2.6.22, named
> i2c_ec:
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=drivers/acpi/i2c_ec.c
> But then the driver we deleted by Len Brown. As the log message is
> empty, I can't tell you why the driver was deleted.
> 
> Note that this driver was looking for an ACPI device named "ACPI0001",
> not SMB<id> as you described above. So maybe it's something different,
> I don't know.

It looks like that was just a helper for a "Smart Battery" driver,
and it was rendered unnecessary.  There are a few clues at
http://marc.info/?t7409889900001

> Yes, acpidump should tell you. Or just run "iasl -d" on your DSDT
> table, I guess that this is where the device in question would be
> declared. But I don't remember ever seeing the above implemented in any
> ACPI DSDT I've disassembled.

Unfortunately, my knowledge of ACPI rivals my knowledge of Xhosa, so
acpidump doesn't tell me any more than "xxd /dev/urandom", and "iasl -d"
on my latest machine just produces:

# iasl -d
Intel ACPI Component Architecture
AML Disassembler version 20061109 [May 15 2007]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

Could not obtain DSDT
Could not get ACPI tables, AE_NO_ACPI_TABLES

> I'm not sure why this would be more robust to SMM than any other driver
> though. How could the ACPI code synchronize with SMM given that you do
> not know when an SMI happens?

There are ways to do this, with cooperation from both sides.  The most
obvious to me is a sort of redo log, where the SMM code finishes the
I2C transaction if one is in progress when it needs to use the I2C bus.

Whether BIOS writers can get something that subtle correct is, of course,
always an exciting question.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
