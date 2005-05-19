From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: Eeprom driver optimization
Message-Id: <20030823210908.62520036.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030816141351.76899190.khali@linux-fr.org>
In-Reply-To: <20030816141351.76899190.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> The refresh time is 5 minutes now.

And shouldn't be increased IMHO. And could even be lowered if we support
writing to eeproms.

> As I've said before, I consider the eeprom driver a "demonstration"
> rather than something with a whole lot of value.

In this case, we can exclude it from sensors.

> Therefore I don't feel that inefficiency is a big concern.
> But if there's some generic method to reduce the number of accesses
> that could be added, that may be interesting.

Give it a look and try and tell me what you think about it.

> I'm not in favor of more Vaio- or EDID-specific stuff
> ("subsets") in eeprom.c.

I finally chose a generic slices method, as you can see. I too think
it's better than a Vaio- or EDID- or whatever-oriented partitioning.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
