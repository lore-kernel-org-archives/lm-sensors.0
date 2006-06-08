From: Frantisek.Rysanek@post.cz (Frantisek Rysanek)
Date: Thu, 08 Jun 2006 07:23:31 +0000
Subject: [lm-sensors] a simple parallel port dongle (active,
Message-Id: <4487EC93.3745.1ED6DEBB@localhost>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Gentlemen,

hereby I'd like to post two updates. I'll leave it up to the
maintainers whether updating the master source tree is worth it...


1) yet another parallel port I2C dongle, active but simple,
just two transistors and two resistors (+ two more resistors
for optional pull-ups, if your circuit doesn't contain these).
Couldn't find one ready, so I created one based on the earlier
i2c-pport passive dongle.

http://sweb.cz/Frantisek.Rysanek/I2C-dongle.tgz
Contains:
- a GIF image (schematic) and
- a small patch to
   $(2.6_KERNEL)/drivers/i2c/busses/i2c-parport.h


2) some time ago, I have added a few updates to eeprom.c.
The various I2C EEPROMs from 24c01 to 24c16 have so many
minor differences, that I decided to add another cmdline
argument: -t <type> . Thus, you can type e.g.

  eeprom -t 24c08 -w -f image.raw

http://sweb.cz/Frantisek.Rysanek/eeprom.tgz
Contains:
lm_sensors-2.10.0/prog/eepromer/eeprom.c
lm_sensors-2.10.0/prog/eepromer/README.eeprom


Background:

Yesterday I've been forced by circumstances to wiretap
a 24C08 on a motherboard. Therefore I had to revisit the
old i2c-pport dongle. Current PC hardware doesn't allow
read-back on parallel port output pins. Therefore I decided
to make an active dongle, as simple as possible.

I was wondering about using a 7401 or some such, but I decided
that static electricity might be a problem, and that discrete
transies would probably cope better.

I was *delighted* by the current version of i2c-parport,
which is _so_easy_ to modify for your own bit-banging
dongle :-)

I hope this helps someone

Frank Rysanek


