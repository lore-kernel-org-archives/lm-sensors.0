From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: PII4X/Compaq ProLiant ML370 G2 server (fwd)
Message-Id: <20030128184521.4786e88e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200301281638.h0SGcEm25577@morannon.frodo.local>
In-Reply-To: <200301281638.h0SGcEm25577@morannon.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


*** PLEASE REPLY TO THE LIST, NOT TO ME ***
(There are lots of people there, much better qualified than I am to
solve the problem.)


> http://secure.netroedge.com/~lm78/supported.html
> =>
> ServerWorks 	OSB4,  CSB5 	i2c-piix4 

OK, so it must be there. Since you have already updated the BIOS, you
are supposed to force the address. The problems are, that we have to
find the address, and that the procedure is known to be extremely
dangerous.

First thing, could you issue a "lspci" (or "cat /proc/pci") and see if
you can find an entry for the PIIX4. I got a Compaq desktop system here,
which says:

00:14.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
        Flags: medium devsel, IRQ 9

That's what you are looking for. The function must be 3.

From our docs (busses/piix4):

On some computers (most notably, some Dells), the SMBus is disabled by
default. If you use the insmod parameter 'force=1', the kernel module
 will try to enable it. THIS IS VERY DANGEROUS! If the BIOS did not
set up a correct address for this module, you could get in big trouble
(read: crashes, data corruption, etc.). Try this only as a last resort
(try BIOS updates first, for example), and backup first! An even more
dangerous option is 'force_addr=<IOPORT>'. This will not only enable the
PIIX4 like 'force' foes, but it will also set a new base I/O port
address.
The SMBus parts of the PIIX4 needs a range of 8 of these addresses to
function correctly. If these addresses are already reserved by some
other
device, you will get into big trouble! DON'T USE THIS IF YOU ARE NOT
VERY
SURE ABOUT WHAT YOU ARE DOING!

So be very careful. I'd suggest you wait a bit so that Mark gets a
chance to answer, I think he knows the PIIX4 better than anyone here and
may have some precious piece of advice for you.

(From previous mail)

> sensor-detect also fails...

How does it fail?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
