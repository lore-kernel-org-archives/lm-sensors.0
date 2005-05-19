From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: question (IBM i2c-piix4)
Message-Id: <Kn8VvbsY.1112963095.2900690.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <000101c53bd2$a7dbfbb0$e500a8c0@KRTEK>
In-Reply-To: <000101c53bd2$a7dbfbb0$e500a8c0@KRTEK>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

> I have this problem:
> ==
> i2c-piix4.o: IBM Laptop detected; this module may corrupt your serial
> eeprom! Refusing to load module!
> ==
>
> And I have read this message:
> ####
> http://archives.andrew.net.au/lm-sensors/msg01833.html
> ####
>
> Is my PC on your "whitelist", please?

The whitelist was never actually implemented, sorry. Too much work, not
enough information from IBM.

We have moved to a different strategy since, which was to not use the
command which possibly corrupts the EEPROMs at all. This was only
implemented in user-space at the moment though, not in the kernel. One
more thing I need to do, but hadn't the time to actually tackle yet.

If you are compiling your kernel manually, I can tell you how to hack the
i2c-piix4 driver to bypass the check. You'd have to tell me which model
you have before though, because the check is there for a good reason and
you shouldn't remove it before we are certain your system is not at
risk. The "vpddecode" tool which comes with dmidecode might help you
identify your IBM system.

> PS: What means "serial eeprom" - is it "BIOS chip"?

It can be about anything, most frequently the ones connected to the SMBus
are from the memory modules of your system. BIOS chips are much larger
than that, and never found on the SMBus as far as I know.

--
Jean Delvare
