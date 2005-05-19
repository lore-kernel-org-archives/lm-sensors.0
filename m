From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: i2c bus classes in 2.6
Message-Id: <20031230223329.3ed46570.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031230212940.2d21c683.khali@linux-fr.org>
In-Reply-To: <20031230212940.2d21c683.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Or at least sensor chips are not detected on them (I experienced
> > this a few minutes ago and it took me a while to figure out why).
> 
> What bus driver doesn't specify this?  Why was a sensor chip not being
> detected?  The SMBUS check in the chip driver?

My new i2c-parport driver(s) ;) But the older ones (i2c-philips-par,
i2c-elv and i2c-velleman) don't specify any class either.

The sensor chip not being detected was the ADM1032 of my evaluation
board (lm90 driver, port in progress). I copied the I2C_ADAP_CLASS_SMBUS
check from lm83, where in turn I had copied it from lm78. All chip
drivers but eeprom do have the check.

I think I remember that Ky?sti was quite interested in classes because
it would let us ignore non-SMBus adapters in sensors. Not sure how
great it is however, since actually we should look for specific chips,
not specific adapters.

I don't see any problem using these classes as long as it is done
consistently, and that adapters that are missing their class definition
are given one where needed. This could help prevent misdetections
(most chip drivers already defend themselves against that, but chips
such as the LM75 or the LM80 are rather hard to detect) and help
user-space programs as underlined above.

OTOH, we definitely can live without them, as we used to. And this will
require a little bit more work from us and others.

Do we all agree that setting classes for an adapter is more or less
arbitrary? To me, it is more of "it was noticed that this adapter
usually has this kind of devices attached" than of "this adapter could
not have devices of other kinds attached, ever". So it is a hint and
a misdetection preventer, not an absolute truth.

Additional comments anyone?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
