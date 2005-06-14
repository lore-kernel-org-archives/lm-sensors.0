From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 14 Jun 2005 15:18:46 +0000
Subject: [lm-sensors] w83781d.o: Subclient 0 registration at address 0x49
Message-Id: <pr6PyFKP.1118754459.8623930.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ef564dc05061302175b8427fd@mail.gmail.com>
In-Reply-To: <2ef564dc05061302175b8427fd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Sukhdeep,

> Our motherboard is a custom one (used for our(Symbol) wireless switches )
> They are similar to the kt400 is what i know.
>
> Here is the i2cdump :

This looks like two distinct Winbond W83782D chips to me, one at 0x29 and
one at 0x2d.

> The warning went after loading with :
>        #modprobe w83781d init=0 force_subclients=0,0x29,0x4a,0x4b

Yes, the two chips previously had their subclients colliding (BIOS
didn't intialize them properly). The force_sublients option let you fix
that.

> But, I now see that the sensors command gives _TWO_ results :

Well, there are two chips, what did you expect?

> The second output seems quite vague.

Looks like the voltage inputs are not wired. Fans and temperatures may be
though.

> I also see two directories created in the /proc -
>
> WS5K #cat /proc/sys/dev/sensors/
> chips             w83782d-i2c-0-29  w83782d-i2c-0-2d

One directory per chip. What's the problem?

> Can you make out what's going wrong ?

Nothing is going wrong (anymore). Once the subclient addresses are fixed
not to collide, you get two working chips. You said it was a custom
board, if you are the one building it, you *should* know which chips are
on it and how they are wired. Don't expect us to tell you, that's not
something we can guess.

As for strange temperature values, you may try changing the sensor types
(/proc/sys/dev/sensors/w83782d-i2c-0-*/sensor* or /etc/sensors.conf).
Maybe your board uses thermal diodes rather than thermistors.

--
Jean Delvare
