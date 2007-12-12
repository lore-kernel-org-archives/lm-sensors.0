From: linux@horizon.com
Date: Wed, 12 Dec 2007 06:39:30 +0000
Subject: Re: [lm-sensors] Intel Core voltage monitoring
Message-Id: <20071212063930.1755.qmail@science.horizon.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <475BDA45.70400@googlemail.com>
In-Reply-To: <475BDA45.70400@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> You're not missing any driver. What you're missing is the SMBus master
> device itself, because it was hidden from you by the BIOS, but given
> what the BIOS does with it, that's the only safe approach.

I don't see a Linux driver for it, but there is a spec for SMBus
access via ACPI, which could synchronize with SMM properly.

The spec's at http://www.smbus.org/specs/
specifically
SMBus Control Method Interface Specification, version 1.0
http://www.smbus.org/specs/smbus_cmi10.pdf

Supposedly there should be something like

Device(SMB<id>){
   Name(_HID, "SMBUS01")   // Hardware ID (PnP ID)
   Name(_UID, <uid>)       // Unique Identification
   Method(_SBI, 0) {...}   // SMBus Information
   Method(_SBR, 3) {...}   // SMBus Data Read
   Method(_SBW, 6) {...}   // SMBus Data Write
   Method(_SBT, 6) {...}   // SMBus Data Transfer
   Method(_SBA, 0) {...}   // SMBus Alert Information
}

Does anyone know the right incanation (probably using "acpidump")
to see if this is supported on the problematic machines?  If so,
writing a driver becomes an interesting question.

(This seems rather obvious, so I hope this idea hasn't been
discarded already for some reason I have overlooked.)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
