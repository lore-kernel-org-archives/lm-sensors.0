From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 Dec 2007 11:17:42 +0000
Subject: Re: [lm-sensors] Intel Core voltage monitoring
Message-Id: <20071212121742.3fab1ba2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <475BDA45.70400@googlemail.com>
In-Reply-To: <475BDA45.70400@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 12 Dec 2007 01:39:30 -0500, linux@horizon.com wrote:
> > You're not missing any driver. What you're missing is the SMBus master
> > device itself, because it was hidden from you by the BIOS, but given
> > what the BIOS does with it, that's the only safe approach.
> 
> I don't see a Linux driver for it, but there is a spec for SMBus
> access via ACPI, which could synchronize with SMM properly.
> 
> The spec's at http://www.smbus.org/specs/
> specifically
> SMBus Control Method Interface Specification, version 1.0
> http://www.smbus.org/specs/smbus_cmi10.pdf
> 
> Supposedly there should be something like
> 
> Device(SMB<id>){
>    Name(_HID, "SMBUS01")   // Hardware ID (PnP ID)
>    Name(_UID, <uid>)       // Unique Identification
>    Method(_SBI, 0) {...}   // SMBus Information
>    Method(_SBR, 3) {...}   // SMBus Data Read
>    Method(_SBW, 6) {...}   // SMBus Data Write
>    Method(_SBT, 6) {...}   // SMBus Data Transfer
>    Method(_SBA, 0) {...}   // SMBus Alert Information
> }

There has been a driver doing that in kernel 2.6.18 to 2.6.22, named
i2c_ec:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;f=drivers/acpi/i2c_ec.c
But then the driver we deleted by Len Brown. As the log message is
empty, I can't tell you why the driver was deleted.

Note that this driver was looking for an ACPI device named "ACPI0001",
not SMB<id> as you described above. So maybe it's something different,
I don't know.

> Does anyone know the right incanation (probably using "acpidump")
> to see if this is supported on the problematic machines?  If so,
> writing a driver becomes an interesting question.

Yes, acpidump should tell you. Or just run "iasl -d" on your DSDT
table, I guess that this is where the device in question would be
declared. But I don't remember ever seeing the above implemented in any
ACPI DSDT I've disassembled.

I'm not sure why this would be more robust to SMM than any other driver
though. How could the ACPI code synchronize with SMM given that you do
not know when an SMI happens?

> (This seems rather obvious, so I hope this idea hasn't been
> discarded already for some reason I have overlooked.)

There clearly is a need for this on some machines, but it remains to be
understood why the Linux ACPI people apparently do not want to expose
this interface.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
