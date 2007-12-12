From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 Dec 2007 12:39:40 +0000
Subject: Re: [lm-sensors] Intel Core voltage monitoring
Message-Id: <20071212133940.402f47c0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <475BDA45.70400@googlemail.com>
In-Reply-To: <475BDA45.70400@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 12 Dec 2007 07:07:40 -0500, linux@horizon.com wrote:
> > There has been a driver doing that in kernel 2.6.18 to 2.6.22, named
> > i2c_ec:
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=drivers/acpi/i2c_ec.c
> > But then the driver we deleted by Len Brown. As the log message is
> > empty, I can't tell you why the driver was deleted.
> > 
> > Note that this driver was looking for an ACPI device named "ACPI0001",
> > not SMB<id> as you described above. So maybe it's something different,
> > I don't know.
> 
> It looks like that was just a helper for a "Smart Battery" driver,
> and it was rendered unnecessary.  There are a few clues at
> http://marc.info/?t7409889900001

This is my guess as well. And I can't really argue against that, as I
never saw any machine implementing this myself, I have no idea whether
there was anything other than the smart battery stuff on the bus.

> > Yes, acpidump should tell you. Or just run "iasl -d" on your DSDT
> > table, I guess that this is where the device in question would be
> > declared. But I don't remember ever seeing the above implemented in any
> > ACPI DSDT I've disassembled.
> 
> Unfortunately, my knowledge of ACPI rivals my knowledge of Xhosa, so
> acpidump doesn't tell me any more than "xxd /dev/urandom", and "iasl -d"
> on my latest machine just produces:
> 
> # iasl -d
> Intel ACPI Component Architecture
> AML Disassembler version 20061109 [May 15 2007]
> Copyright (C) 2000 - 2006 Intel Corporation
> Supports ACPI Specification Revision 3.0a
> 
> Could not obtain DSDT
> Could not get ACPI tables, AE_NO_ACPI_TABLES

You need to pass it your DSDT file as a parameter. It used to be
at /proc/acpi/dsdt but on recent kernels it moved
to /sys/firmware/acpi/tables/DSDT. You might need to copy the file to a
temporary directory before iasl -d will be able to disassemble it. Then
you can grep the disassembled form for "SMB", "ACPI0001" or whatever
you want.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
