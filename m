From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 15 Oct 2010 13:22:07 +0000
Subject: Re: [lm-sensors] f71882fg on Jetway NC92-330-LF
Message-Id: <AANLkTimAQ2iCYZRZ-+R8J+ygnvxQm4hFysiQGD5Uwbd1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTi=abRLHVUXTz=fwAiWcD1sUgdPjKxz3xY92j=8O@mail.gmail.com>
In-Reply-To: <AANLkTi=abRLHVUXTz=fwAiWcD1sUgdPjKxz3xY92j=8O@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Oct 15, 2010 at 10:32 AM, Jean Delvare <khali@linux-fr.org> wrote:
>> Keep the conversation on the list, we might get some insight on how to
>> proceed with this...
>
> If I understand correctly, the ACPI BIOS on this board (and hopefully
> other Jetway boards) implements functions to read and write bytes
> from/to the hardware monitoring chip, and you are hacking the f71882fg
> driver to make use of them when available instead of direct I/O?

Yes that's correct. ACPI exposes read/write operations(in term of
(offset, data) registers.

> That's quite interesting, even though I think I would play it safe at
> first and only allow reading from the chip. Who knows if the BIOS
> includes code with read-modify-write cycles? Did you check if these
> functions were callled by the BIOS itself?

Yes, the BIOS reads from the chip only for exposing a TZ. The writes
are also tied to the TZ (AFAICS for setting the limit on temp1).
Anyway the execution of ACPI methods is atomic, so the hacked driver
cannot interrupt whatever the BIOS is doing (including a RMW cycle).
The opposite may happen though; if we decide to go down this road it's
possible to expose the ACPI interpreter mutex and take it before doing
RMW in the native driver.

> Of course I see that your code is currently a hack only working for
> this board, or at best for several Jetway boards with a device
> supported by the f71882fg driver. Ultimately it would be better to have
> a generalized abstraction layer, so that every I/O-based hwmon driver
> can use any available ACPI byte access function, without having to
> hard-code every board/chip combination.

The read/write operations are not standard, however if the IO range is
reserved it's very likely that there will be an indexed field covering
it, that may be used to access the hardware.
If there isn't a high-level API available (like ATK0110) it would
probably be easier to lock/unlock the ACPI interpreter to protect
native accesses to the chip. The only exceptions are SMI and EC which
require explicit synchronization (the latter is present on some Asus
boards, and there's a mutex guarding the access to the hwmon chip).

> That being said, if you can get this specific board to work, and even
> if the code looks ugly, I have no objection.

I'll see what I can do :)

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
