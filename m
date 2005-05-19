From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: w83781d family detection
Message-Id: <20030726112657.79c34e37.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I made significant changes to the w83781d family detection method in
sensors-detect.

* Separate detection sub for W83L784R/AR. Its registers differ from the
other chipsets in the family, it shouldn't have been added to
w83781d_detect in the first place.
* Ranges limited to what the specs say for I2C-only chips (see below).
* Add detection for the AS99127F rev.2 and explicit detection of the
ASB100 Bach.
* Improve code readability.
* Do not ignore the chipset ID LSB anymore. Explicit acceptation of 0x11
as a W83781D ID instead.
* Fix a bug in secondary LM75 address extraction. The previous code
returned 0x48 whatever the register could contain. I'm astonished it was
never reported. This means that most if not all chipsets in that family
use 0x48 as their secondary LM75's address.

Similar changes should be made to the w83781d driver itself, but I would
like my changes to be tested before that. My tests were successful on
three chips I own (AS99127F rev.1, W83781D and W83782D) but more tests
would be welcome.

About the address ranges:

For the W83783S and the W83L784R/AR, no address selection pins exist.
Since they cab be accessed only via the I2C bus, this make me think the
address is unlikely to be changed, so I limited the range to the default
address (0x2D). Likewise, the W83791D has 2 address selector pins, so
the range is 0x2C-0x2F (4 addresses).
For Asus chip, I chose the range 0x28-0x2F. We have no datasheet, this
seem to be a good compromise (and Alex does the same). However, the fact
that the register 0x48 doesn't hold the chip I2C address make me think
Asus doesn't want the address to be changed at all, so we could limit
the address to 0x2d. (MMH, do you confirm that your ASB100 has nothing
useful at 0x48?)

I think it's better to limit the ranges. This reduces scan time (not
significantly I guess) and limits the risks of misdetection and
corruptions. I browsed the mailing list and every log I could find fits
the new ranges. I voluntarily left the ISA chips ranges unchanged, since
in this case the address can be changed using the ISA bus and we have
reports it occured (W83627HF have been seen at 0x2c and 0x2f according
to what I read in our archives).

I'd like to thank Alex *a lot* for taking some time to tell us about how
he detects the Asus chips. I'll add a copy of his explanations to our
w83781d doc soon.

Comments welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
