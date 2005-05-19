From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Installation report/Feedback
Message-Id: <20031220140851.3ce15a64.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207183312.GA855@GreenHouse.dorchain.net>
In-Reply-To: <20031207183312.GA855@GreenHouse.dorchain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The motherboard is Ausus OEM by 4MBO. (...)

I suppose you really mean "Asus"?

> i2cdetect 1
> (...)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d 2e XX
> 30: XX XX XX XX XX XX XX 37 XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX 48 49 XX XX XX XX XX XX
> 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 7f

Interesting. 2d+48+49 is the ASB100, 2e is the W83L785TS-S. This leaves
three addresses: 08, 37 and 7f, which my map present as, respectively
"SMB host", "Reserved for Access.Bus default address" and "Reserved". I
don't know much about these things, but that could mean that there is
some alternate access to the bus, possibly interfering with us accessing
the W83L785TS-S. That would explain the "XX" (but doesn't help much
since I don't know what to do to solve the problem).

> i2cdump 1 0x2e c
> (...)

Doesn't work (returns the first value all the time).

> BTW, on the smbus 0, there are some clients that the sensors package
> does not regognize. Are you interested in more details?

Sure. Provide i2cdumps for these and I'll take a look. That said, you
already have two monitoring chips on smbus 1, so I doubt we'll find any
more on smbus 0.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
