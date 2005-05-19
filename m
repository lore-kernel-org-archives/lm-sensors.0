From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: new stuff
Message-Id: <1073644715.3ffe84ab5d687@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alex,

> 1) you need any info on the ALi M1563 southbridge ?

We had no request so far, but we'll keep your implicit proposal in mind
as the time comes :)

> 2) have you heard about the Uguru on the new Abit boards, they are
> replacing the normal senor chip with this, I have run into a brick
> wall at Abit
> though, forum posting is here:
> http://www.livewiredev.com/bbs/showthread.php?s=&threadidT53
> 
> maybe we can combine forces on this one ? as I think will become a
> problem :)

I read the thread. Sure we can combine our forces. What do you propose?

Is it an SMBus-compatible chipset without specs (ala AS199127F) or
something completely different from other known chips. If it's too
different, it's unlikely that the LM Sensors project will support it,
but having a data sheet to write an "external" driver would be
appreciated though.

> 3) Asus is releasing boards like the ASUS PC-DL which show 5 temp
> sensors in the bios, however all my scans only show a normal winbond
> with the 3 sensors, you ran into this yet ?

We have had one report:
http://archives.andrew.net.au/lm-sensors/msg05327.html

From that post, looks like the monitoring chipset was detected as one
supported by our w83627hf driver, i.e. W83627HF, W83627THF or W83697HF.
W83697HF is unlikely since it would show 2 temperatures and you say
you see 3. So it must be a W83627HF or W83627THF.

That said, we know that ASUS are good at stealing chip designs from
Winbond and including modified versions on their boards. For example,
the ASB100 had a fourth temperature channel. Maybe that's something
similar here.

Or maybe the other temperature measurements come from somewhere else,
maybe ACPI? Or another I2C bus on the Video board for example (I wonder
how the BIOS could grab information from it, but who knows... if the
mobo has an integrated video chip, that would make sense)

BTW I wonder what the user will do with 5 temperatures... What are the
extra readings for?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
