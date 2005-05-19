From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: New driver for MAX663x temperature sensor.
Message-Id: <1081854066.407bc872adf2f@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081775028.11592.294.camel@uganda>
In-Reply-To: <1081775028.11592.294.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hm, just noticed...

Looks like the LM76 is 100% compatible with the LM92, and we have a
driver for the LM92 (lm92.c). Since the MAX6635 is obviously a clone of
the LM76, it should fit well in the lm92 driver as well.

I admit that the lm92 driver isn't our best driver, there are several
places where it does the things in a very different way when compared
with the other drivers. Still it would be much better to extend and fix
this existing driver that to duplicate the exact same functionality in
a different driver.

Since the LM92 has a manufacturer ID register, you can use that to
distinguish it from Maxim's clones. Also, I noticed that the five chips
(LM76, LM92, MAX6633, MAX6634 and MAX6635) have different address
ranges. That's something you can use to distinguish between the four of
them that do not have a manufacturer's ID register (although it will of
course not be perfect). You would also add the 4-bit cycle trick as
mentioned in an earlier, and the unused bits in the temperature limits
registers. The lm92.c driver has a very simple detection function at
the moment because it could rely on the manufacturer's ID. Now that you
can't, you have to use all the tricks we've discussed before.

You are welcome to clean whatever you fell like cleaning in the lm92.c
driver, I don't like it much (although it's definitely better than no
driver at all, I don't intend to denigrate Abraham's work, it's just
that it is different from the other drivers, which makes it harder to
maintain).

Sorry for not checking before, that would have saved us much time and
work :/

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
