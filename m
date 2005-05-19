From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <20031126204713.2723a127.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> don't rule out a bus driver problem. They're both using nforce2.

Actually I think I've narrowed it to i2c-nforce2's
i2c_smbus_write_byte() being broken. After performing the checksum, the
address register has value 0x40. The i2c_smbus_write_byte() call should
change that value to the right one for each read slice, but for some
reason fails to do so. This is why it always returns rows 5 and 6
(because this slice really begins at 0x40).

As to why the call fails, I have no clue. I've never messed with (real)
bus drivers. I'll contact the author of the module, I hope he'll be able
to help. Only a few chip drivers use that call, among which there is no
widely used monitoring chip, so we can reasonnably suppose that a bug
here could have been left uncaught so far (especially since the
i2c-nforce2 driver itself is fairly new).

BTW, Mark, what's the difference between (2c_smbus_write_byte and
i2c_smbus_write_quick? I can't really tell, since they have the same
prototype. For a moment, I wondered if I shouldn't have been using
_quick instead of _byte, but since _byte works OK for me...

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
