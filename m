From: tonu@jes.ee (=?utf-8?Q?T=F5nu_Samuel?=)
Date: Sat, 24 Sep 2005 08:53:26 +0000
Subject: [lm-sensors] SE95 driver
Message-Id: <4647.192.168.0.190.1127544743.squirrel@www.jes.ee>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi everybody!

Seems like Philips SE95 i2c thermo sensor support is missing. Datasheet
http://www.semiconductors.philips.com/acrobat/datasheets/SE95_2.pdf

Because I have some of those chips, I would take writing driver for it.
Chip itself is very similar to LM75 but hs high accuracy and read-only
register to identify chip.

Another chip I would like to cover is PCA9554(A). This is nearly identical
to old 8574(A), resides on same addresses but has some advantages like
automatic detection possibility and similar. So probably it takes just to
slightly modify 8574.

I have more cool Philips chips I have but give me try on first two simple
cases and them I can continue on others.

   T=F5nu

