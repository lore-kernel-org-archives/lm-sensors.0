From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Please analyse output
Message-Id: <20021116135911.06749ab9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <B9F99D36.445B%zdavatz@ywesee.com>
In-Reply-To: <B9F99D36.445B%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > I took a look at your EEPROM dumps, two of them seem to contain some
> > valuable data. Nothing usable without some specification from Asus
> > anyway, and I know we won't get anything from them. I don't plan to
> > do any work about them until we have more information (which could
> > actually take forever). So all you have to do is not to load the
> > eeprom module, and you won't be annoyed bye the eeproms anymore.

> By eeproms you mean the messages I get before the actual data shows
> up? Will I get any more info if I do not load the eeproms?
Actually, I meant the messages that you got *after* the actual data
shows up. You won't get anything more without the eeproms, it is
completely independant, but at least the extra messages won't annoy you
anymore.



-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
