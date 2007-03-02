From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 02 Mar 2007 13:37:20 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070302143720.cfd8afeb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
	<45D6DDCE.5050803@assembler.cz>
	<45D7461A.2040808@redhat.com>
	<20070218183805.5a4fd813.khali@linux-fr.org>
	<20070228213803.GA4877@ucw.cz>
	<20070301152655.f232db64.khali@linux-fr.org>
	<20070301174806.GA4979@redhat.com>
	<20070302122736.f14a7a22.khali@linux-fr.org>
	<20070302113158.GC2156@elf.ucw.cz>
In-Reply-To: <20070302113158.GC2156@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Jones <davej@redhat.com>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Fri, 2 Mar 2007 12:31:58 +0100, Pavel Machek wrote:
> > My point (which you didn't quote) was that there is no correlation
> > between the SMBus being hidden and ACPI accessing the hardware
> > monitoring chip, contrary to what Pavel was suggesting.
> 
> It may not be correlated with ACPI, but BIOS authors clearly want to
> keep you away from their SMBus controllers....

drivers/pci/quirks.c is full of things we do against the BIOS authors
intent. You don't plan to remove them all, do you?

(And as a side note, this is really the board's owner SMBus controller.
The hardware doesn't belong to the BIOS author.)

-- 
Jean Delvare

