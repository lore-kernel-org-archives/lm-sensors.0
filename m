From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 04 Mar 2007 17:29:12 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <45EB01E8.5080003@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070228213803.GA4877@ucw.cz>	<20070301152655.f232db64.khali@linux-fr.org>	<20070302114023.GD2163@elf.ucw.cz>	<20070302114747.GB1212@srcf.ucam.org>	<20070302151055.d2665d66.khali@linux-fr.org>	<20070302141840.GA3441@srcf.ucam.org>	<20070302220454.a0c66d04.khali@linux-fr.org>	<20070302211251.GA10035@srcf.ucam.org>	<20070303105316.d51e032d.khali@linux-fr.org>	<4dfa50520703030747g3c887f5bxe25caefd1723c635@mail.gmail.com>	<20070303155048.GA22755@srcf.ucam.org> <45E9AB8B.1070804@assembler.cz>
In-Reply-To: <45E9AB8B.1070804@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Chuck Ebbert <cebbert@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

Hello again,

I produced some code which I proposed in mail above. The patch is not for review
it is just a PoC to better show what I'm trying to do. It is a test case for my
motherboard which has W83627EHF chip and ACPI thermal method and w83627ehf
compete the device.

When no driver is loaded, acpi is doing its own raw access to device. However
when the w83627ehf driver is loaded, the ACPI access to ports (0x295/0x296) is
forwarded to the w83627ehf driver.

How it works? I added one pointer to the struct resource which will contain a
pointer to the structure with callback functions. I know this is not an ideal
solution, but for a test it works fine. Everytime ACPI wants do IO it will ask
via ____request_resource(conflict, &res) if some driver claimed the resource,
if so, it iterates the resource structure to the last entry, if the callback
structure exists it is called (and device driver context is passed too), if not,
raw hw access is performed.

The routines in EHF driver partly emulates the chip, the address of which next
acpi access will want to read or write is saved in the data->reg_pointer.

The actual access to the chip is done only when the data port of the chip is
accessed, and driver generic io function is called. Bank register writes are
faked to the data->reg_bank. All access to the chip which is done in these
routines respects the "virtual" bank register which was previously set by ACPI.
(current emulation is not 100% perfect, but this could be easily fixed)
If something was written to the chip, driver's register cache is invalidated.

This approach does not need any external locking because the actual device
access is done by one function of driver (which already locks).

As from ACPI point of view the device behaves same way as real HW, the big plus
is that the driver actually KNOWs what is ACPI trying to do to the chip. Of
course if the HW access is done in SMM some other countermeasures must be
invented like GBL lock or the "take ownership" stuff.

Maybe this forwarder may be used by other drivers, which may want to know what
is ACPI doing to hardware during suspend/resume methods...

As I wrote earlier the SMBus access could be also virtualized same way, there
will be only more virtual registers, real transaction will start when the ACPI
sets the "begin transaction" bits ;).

Maybe the pointer to driver context could be removed, and container_of could be
used instead to reach it. I will need some advise how to implement this
randevouz between ACPI and one Linux driver... Exploiting the resource structure
  is nice but pehaps not acceptable??? Some class maybe? We have only 1:1
relation...

Thanks,
Rudolf


-------------- next part --------------
A non-text attachment was scrubbed...
Name: acpi-io-sync.patch
Type: text/x-diff
Size: 7824 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070304/8d85322d/attachment.bin 
