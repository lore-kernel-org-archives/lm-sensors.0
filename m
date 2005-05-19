From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: unknown eeprom type (65) [ticket #1449]
Message-Id: <20031126073920.0247547a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069703037.8309.4.camel@localhost>
In-Reply-To: <1069703037.8309.4.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> don't rule out a bus driver problem. They're both using nforce2.

OMG, you're just too good. (Yes, that's another way to say I'm just too
bad.) That said, the debug logs clearly point in that direction too, so
maybe I'd have thought of it in the end ;) Since the rows and slices
indexes are correct, one logical conclusion is that the I2C read
commands wouldn't be returning what they should.

There was another report for the same problem 3 weeks ago. I asked for
additional information but the guy never replied. Guess which bus driver
he was using? Nforce2 of course.

> We have had previous reports (months ago) that the ddcmon driver
> was reading off-by-one, we never figured that out.
> This looks different though (off-by-slices).

Not really off-by-slices. I'd say that it returns row 5 for each odd
row, and row 6 for each even row. Very strange bug indeed.

Thanks a lot for helping me on this.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
