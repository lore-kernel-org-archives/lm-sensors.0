From: david-b@pacbell.net (David Brownell)
Date: Tue, 12 Jul 2005 13:51:31 +0000
Subject: [lm-sensors] Re: at24c i2c EEPROM driver
Message-Id: <200507120450.54671.david-b@pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200507111737.11097.david-b@pacbell.net>
In-Reply-To: <200507111737.11097.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Monday 11 July 2005 5:37 pm, David Brownell wrote:
> I ran into one too many board with an I2C EEPROM that Linux handled poorly,
> and got a hack attack.  Here's the result ... tested on at24c04 but it
> should work on most other chips in the at24c series without much effort.

Hmm, and it appears most other I2C EEPROMs too; I happened across a
chart with about eight vendors showing part number equivalence.
And the AT24C column was big, but maybe not the biggest.

So now what I need is some 8 pin DIP sockets on a Linux machine
and then I can use this driver to program the 24LCxx EEPROMs
used on some 8 bit microcontrollers I've got sitting around (on
the grounds that they won't run Linux).  Hmm.  :)

- Dave

