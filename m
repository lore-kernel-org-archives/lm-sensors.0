From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 15 Oct 2010 08:32:05 +0000
Subject: Re: [lm-sensors] f71882fg on Jetway NC92-330-LF
Message-Id: <20101015103205.123ac96a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=abRLHVUXTz=fwAiWcD1sUgdPjKxz3xY92j=8O@mail.gmail.com>
In-Reply-To: <AANLkTi=abRLHVUXTz=fwAiWcD1sUgdPjKxz3xY92j=8O@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Luca,

On Fri, 15 Oct 2010 10:03:47 +0200, Luca Tettamanti wrote:
> On Thu, Oct 14, 2010 at 10:39 AM, Алексей Сычев <taviscaron@gmail.com> wrote:
> > Hello.
> > I have Jetway NC92-330-LF and interesting in your post:
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2010-April/028281.html
> >
> > I have compiled attached driver, but it still does not work:
> >
> > f71882fg: Found f71862fg chip at 0x290, revision 1
> > ACPI: resource f71882fg [io  0x0290-0x0297] conflicts with ACPI region IP__
> > [??? 0x00000295-0x00000296 flags 0x5f]
> > ACPI: If an ACPI driver is available for this device, you should use it
> > instead of the native driver
> >
> > Maybe i can help in something (testing, log, etc)? Working driver will be
> > very good.
> 
> There was a bit of round trip with the user to adjust the driver. I'm
> attaching a version that was confirmed working, but it's an ugly ugly
> ugly hack. In fact if Jean sees this he's going to ask my maintainer
> badge back :P

Not as long as you keep helping us make users happy :)

> Keep the conversation on the list, we might get some insight on how to
> proceed with this...

If I understand correctly, the ACPI BIOS on this board (and hopefully
other Jetway boards) implements functions to read and write bytes
from/to the hardware monitoring chip, and you are hacking the f71882fg
driver to make use of them when available instead of direct I/O?

That's quite interesting, even though I think I would play it safe at
first and only allow reading from the chip. Who knows if the BIOS
includes code with read-modify-write cycles? Did you check if these
functions were callled by the BIOS itself?

Of course I see that your code is currently a hack only working for
this board, or at best for several Jetway boards with a device
supported by the f71882fg driver. Ultimately it would be better to have
a generalized abstraction layer, so that every I/O-based hwmon driver
can use any available ACPI byte access function, without having to
hard-code every board/chip combination.

That being said, if you can get this specific board to work, and even
if the code looks ugly, I have no objection. Our main objective is to
let users monitor their hardware now, not in 2 years. And it is easier
to generalize something if we have several implementations for specific
cases already.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
