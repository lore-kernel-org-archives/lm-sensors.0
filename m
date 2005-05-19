From: boi@chrysler.kbs.twi.tudelft.nl (Boi Sletterink)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: ---=== Lm_sensors Support DB Entry ===---
Message-Id: <20020324193410.GA7656@chrysler.kbs.twi.tudelft.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

an update on the problem that I reported (Ticket # 849).

FYI, this board (Soltek SL-75DRV2) uses a VIA KT266A chipset, ie. a VT8366A
northbridge and a VT8233 southbridge (containing the SMBus bus driver,
handled by the viapro module). The manual also mentions the ITE8705 low
pincount IO chip, which is properly detected as a IT87 chip.

Looking at ticket 727, this guy has the same southbridge on his Soyo board
and sensors-detect also reports an lm75 chip at 0x4e, which is not actually
there. I wonder if this is a coincidence.

> So there is some voltage-setting chip, not an LM75, at 0x4e,
> which the lm75 driver reprograms?
>
> Or there is an LM75 at 0x4e and the driver causes side-effects
> at some other location?

Good question. Comparing the BIOS to the output of lm_sensor's
interpretation of the it87 readout, I think there is no lm75. There are two
temp. sensors for this board, one beneath the CPU and one external (for a
probe). Both are listed in both the BIOS and with lm_sensors.

Also, it shows that the BIOS settings suck, since it sets bad alarms. Eg.
the +3.3v sensor is always on alarm (unless I do sensors -s to fix it with
new settings), because the alarm registers trigger on half the approriate
voltage (+1.48v and +1.80v).

My guess is that this funky SMBus chip is actually the voltage controller.
I'll try to back it up with evidence ;)

I also had a minor problem with the -12v and -5v sensors - the calibration
transistors (or whatever you'd call them, see sensors.conf) are different
than the onces used in sensors.conf. I found a fairly good estimate for the
compute formulas for my board, I think. What would be the best way to report
it? Add another ticket?

> If you can look at your board or ask the board supplier that would help.

I'll try to find the time for it. Unfortunately, the manual nor the Soltek
website are very helpful.=20

> Also if you can send us the output of prog/dump/i2cdump 0 0x4e
> that may help identify the device. Then we could =B4blacklist=B4
> this device so the lm75 driver won=B4t be recommended.

Here's the output of i2cdump 0 0x4e:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????
10: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????
20: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????
30: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????
40: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????
50: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????
60: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????
70: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????
80: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????
90: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????
a0: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????
b0: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????
c0: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????
d0: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????
e0: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????
f0: 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b 0b    ????????????????

Doesn't look very interesting to me. On the positive side, just scanning it
didn't raise my core voltage, so it's safe to scan it.

Thanks for the feedback,
Boi

> Your Lm_sensors support entry has been updated.
>=20
> Please go to http://www.netroedge.com/~lm78/support.html to check
> the status of your entry. =20
>=20
> Ticket # 849

--=20
                Predestination was doomed from the start.
 ------------------------------------------------------------------------
Support your freedom and privacy, support OpenPGP - http://www.openpgp.org/
My PGP key: http://www.kbs.twi.tudelft.nl/People/Staff/B.Sletterink/boi.pgp
