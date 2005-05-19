From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Ported lm80 to Linux 2.6
Message-Id: <20040217201920.29606ffa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1076403383.40289cb779c27@imp.gcu.info>
In-Reply-To: <1076403383.40289cb779c27@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> darksun:~# i2cdump 0 0x2d
> No size specified (using byte-data access)
>   WARNING! This program can confuse your I2C bus, cause data loss and
>   worse! I will probe file /dev/i2c-0, address 0x2d, mode byte
>   You have five seconds to reconsider and press CTRL-C!
> (...)

Interesting. I will analyze the data and try to summarize some facts.
Could you dump the chip again under high load? If it is some temperature
sensor, we should see at least one register increase.

I also have dumps from another user, and I'll try to compare yours and
his, so as to locate invariant registers (which are candidates for chip
or manufacturer ID).

> Indeed, it no longer detects LM80 nor any other in its place.
> Does this mean that I have a non-identified sensor chip, or that it
> doesn't exist at all? In any case, if you require further tests, I'll
> be glad to help.

You got it right, it is unknown so far. We never took the time to
investigate because usually people have the via686a working well so they
don't need more. That time I'll try to gather more data and maybe I'll
learn something.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
