From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: adm1021 (probably) does something VERY,VERY BAD
Message-Id: <20040327124448.18c9c13c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4062C734.5000104@gmx.net>
In-Reply-To: <4062C734.5000104@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> This looks to me like a lm75-compatible or adm1021-compatible chip;
> the address range 48-4f is traditionally for temperature sensors;
> it wouldn't be that unusual for a board with a w83627hf (with 3 temp
> sensors) to have another chip to provide additional temperatures.

Granted, it could be an extra temperature sensor. Except that it doesn't
change values, and shuts the system down when you try to use it ;)

> I agree w/ Khali that you can watch the registers with i2cdump
> (esp. at data address 0x00) to see if it varies with CPU load,
> if so try loading lm75.
> 
> The first 4 locations look somewhat like temp, control, hyst, and max
> to me.... then again, maybe not.

109 degrees C seems slightly excessive for early spring, don't you
think? Plus there is too much difference between hyst and max, and
anyway hyst = 16 degrees C doesn't make much sense, and max = 114
degrees C doesn't make any sense either.

I'm sorry but that chip doesn't look like an LM75 to me at all, and
since it was already proved that it wasn't adm1021-compatible...

> I see the lm75 section in sensors-detect has grown a lot,
> I don't pretend to understand it all but perhaps there is a new
> case here or perhaps it is too restrictive?

It hasn't changed much. The extra code is mainly there to refine the
confidence value we give to the chip (from 6 down to 3). The main
detection trick is unchanged, and relies of the fact that the LM75
addresses registers over 3 bits only, so values cycle every 8 bytes.
This is obviously not the case here, but I agree that a LM75-compatible
chip wouldn't *have* to behave the same way.

> Our first guess for a chip in the range 48-4f should always be lm75
> or compatible.

I don't see no reason for this. There are many more chips that live in
this area, especially at 0x4c-0x4e, that are not compatible with the
LM75 at all, and that are much more likely to be found in modern
computers (Winbond-like emulation left apart).

> Eric perhaps you can look at your board and find out what chip this
> is, that would be a big help to us.

Sure it would.

Also, Eric, could you try dumping the chip in word mode (i2cdump 0 0x4e
w)? This will let us know is some registers are word-sized, which would
help identify the chip.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
