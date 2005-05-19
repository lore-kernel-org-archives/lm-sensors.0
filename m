From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: EEPROM read/write user space program
Message-Id: <20031128192357.0f0021bc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031122084059.0f9f73fa.khali@linux-fr.org>
In-Reply-To: <20031122084059.0f9f73fa.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> __________________________________WARNING____________________________
> ___ Erroneously writing to a system EEPROM (like DIMM SPD modules) can
> brake your system.  It will NOT boot any more so you'll not be able to
> fix it.

It's "break", not "brake" (also in some way I agree it does too ;)).
And "any more" is "anymore".

> Reading from 8bit EEPROMs (like that in your DIMM) without using the
> -8 switch can also UNEXPECTEDLY write to them, so be sure to use the
> -8 command param when required.

Wouldn't it be safer to default to 8-bit and have a switch to use
16-bit addressing? From what you said, "reading from an 8bit eeprom
using 16bit addressing can actually *write* to the eeprom", but what
would reading a 16-bit eeprom using 8-bit addressing do? If it isn't
dangerous, I believe you should default to 8-bit addressing.

BTW, isn't it possible to detect the addressing mode?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
