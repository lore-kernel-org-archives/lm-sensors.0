From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 03 Mar 2007 06:44:22 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070303074422.4926e428.khali@linux-fr.org>
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
	<20070302143720.cfd8afeb.khali@linux-fr.org>
	<20070302135706.GE2156@elf.ucw.cz>
In-Reply-To: <20070302135706.GE2156@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Dave Jones <davej@redhat.com>, Chuck Ebbert <cebbert@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Fri, 2 Mar 2007 14:57:06 +0100, Pavel Machek wrote:
> On Fri 2007-03-02 14:37:20, Jean Delvare wrote:
> > drivers/pci/quirks.c is full of things we do against the BIOS authors
> > intent. You don't plan to remove them all, do you?
> 
> Notice how quirks.c is careful to name machines where given quirk is
> used.

Notice how we unhide the SMBus only on a few named machines as well.

> If you do whitelist "it is okay to do sensors accesses on this board",
> that is okay with me. But having quirk "on all future Intel chipsets,
> do foo" would be stupid.

We don't do that, never did, and never planed to do.

>                    (...) Enabling sensors blindly is pretty similar.

This is the view of someone obviously not interested in sensors. Go
tell that to all the lm-sensors users and they'll reply: "Disabling
sensors blindly would be stupid." Please realize that we're not writing
hardware monitoring drivers just for the fun of conflicting with ACPI
on some machines. We're writing them because users are asking for these
features.

-- 
Jean Delvare

