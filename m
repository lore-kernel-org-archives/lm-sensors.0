From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: 1283 ticket datasheet
Message-Id: <20031217210321.40bafa23.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1055798868.13976.2.camel@rentnerschreck.mine.nu>
In-Reply-To: <1055798868.13976.2.camel@rentnerschreck.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'm rather skeptical for this one. I would read the temperature fault
> limit from register 0x53, according to the data sheet. That said, the
> value in this register, from a dump one user provided, is 100, while I
> would expect 85 of 90.

About that point, I confirm my first guess. I saw a number of dumps of
that chipset, it turns out that register 0x53 always holds 0x55 or 0x64,
and is constant over subsequent dumps, while the value at 0x26 is not.
So my belief is that the register 0x53 holds the limit, but the data
sheet is wrong about the possible values, which are 85 and 100 degrees,
not 85 and 90.

I still don't know if it is possible to write to this register to change
the value.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
