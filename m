From: r.marek@assembler.cz (Rudolf Marek)
Date: Sat, 03 Mar 2007 17:08:27 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <45E9AB8B.1070804@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070228213803.GA4877@ucw.cz>	<20070301152655.f232db64.khali@linux-fr.org>	<20070302114023.GD2163@elf.ucw.cz>	<20070302114747.GB1212@srcf.ucam.org>	<20070302151055.d2665d66.khali@linux-fr.org>	<20070302141840.GA3441@srcf.ucam.org>	<20070302220454.a0c66d04.khali@linux-fr.org>	<20070302211251.GA10035@srcf.ucam.org>	<20070303105316.d51e032d.khali@linux-fr.org>	<4dfa50520703030747g3c887f5bxe25caefd1723c635@mail.gmail.com> <20070303155048.GA22755@srcf.ucam.org>
In-Reply-To: <20070303155048.GA22755@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: David Hubbard <david.c.hubbard@gmail.com>, Rudolf@atrpms.net, Pavel Machek <pavel@ucw.cz>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, Chuck Ebbert <cebbert@redhat.com>

Hello all,

I was already thinking about some very general port forwarder,
(http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/018788.html)

But I'm not able to find out how to do that painlessly. Even don't know if to
use the classes or even some new "bus" in driver model :/ some suggestions on
this would be very welcome.

Let start with some very naive 1:1 solution which would try out if we can handle
"transactions" (typically write to one port read from other operation)
and preserve the "banks". As was already written some virtualization in driver
would be required, but it may be done because we know how the hardware is
supposed to work.

It seems that most simple solution to try out would be to add a possible
callback structure into a IORESOURCE structure. Please don't blame me for this,
it is just for testing purpose, we must think of better place, but as I said I
dont know where or how :/

Here is some concept:

When the request_region fails, ACPI could call request_region_acpi
which will return a pointer to some structure with defined callbacks
like do->outb do->inb. ACPI will first chekc if the pointer is not NULL ;)

This callback would end up in let say other linux driver.

For the typical hwmon chip things works similar way as CMOS access. Port is
written 0x295 with register address and port 0x296 is read or written.

Therefore:
void outb(port, val) {

if (port = 0x295) {
	reg_pointer=val;
} else if (port = 0x296) {
	// ACPI wants to write to the chip
	if (reg_pointer = BANKREG)
		reg_bank=val;
	}
	do_chip_write(reg_pointer, reg_bank_val);
}
}

void inb(port, val) {

if (port = 0x296) {
	

	return do_read_chip(reg_pointer, reg_bank);
}

}

The code above shows how the IO access could be synchronized with the ACPI, to
make everyone happy again. The driver could snoop what ACPI tries to change, so
it for example force reloading the cached values...

The second device which might be a challange is the SMBus controller. The
virtualization could be done same/similar way.

For PCI memory regions, the situation is same as for IO, however for the
pci_config space I cannot see any straight solution.


Regards
Rudolf

