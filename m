From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: EEPROM write support
Message-Id: <20030723000302.32db3d3f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307221931.02558.sascha@akv-soft.de>
In-Reply-To: <200307221931.02558.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I've just connected an old serial EEPROM to my i2c-bus, to see what
> else can be done with this bus. My question is, why is there no write
> support (yet)? Mere protection?

Protection and lack of need. The module was initially written to read
memory chips eeproms, and that's not the kind of eeprom you want to
write to (if you only can, I'm not sure about that.) What's more, we
have been having trouble with some eeproms found on IBM laptops. This
has kept our project from being integrated into the Linux kernel tree
for years (no kidding) so nobody here is wanting to play with eeproms
anymore.

> I've added a basic write functionality myself, and it works pretty
> fine (the chip didn't blow and presents the written data on next
> real read-out).

As said before, I think there is almost no need for such a use. Same as
your SAA1064 driver actually. We had fun writing it but we don't expect
hundreds of users to need it.

If we are to add write support to the module, it has to be an option,
and disabled by default (my opinion).

> I've also found some other I2C-Chips on the board I have that one
> from, mostly Audio and Video processors also found in other packages.
> Are those drivers intentionally not part of lm_sensors but instead
> their respective driver packages?

It's intentional. We can't handle all these devices, and we simply don't
*want* to do so. The project is aimed at hardware monitoring. We only
"host" drivers that couldn't possibly leave out there, either because
they are generic (eeprom driver) or too specific (such as your saa1064
driver). Such drivers would probably not be maintained if we weren't
maintaining them by ourselves. This is also linked to the fact that we
are responsible for the i2c subsystem.

Audio and video drivers (well, mostly video) are more complex things,
requiring regular updates and hardware for testing. It's better that the
people who know much more than us on the topic write and maintain the
drivers on their own.

BTW, just my own point of view, not the lm-sensors-team official one (if
there ever was one).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
