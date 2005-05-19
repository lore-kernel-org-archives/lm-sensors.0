From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: LM83 test results
Message-Id: <20030827111215.3da0e705.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806122107.6d678b30.khali@linux-fr.org>
In-Reply-To: <20030806122107.6d678b30.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > That's very interesting. See how the limits appear not only in one,
> > but many registers. I had never seen this behavior. Could be used
> > for detection purpose (although we already have a reliable detection
> > mechanism now, thanks to you).
> 
> what you're seeing is a relatively common behavior where,
> when you read an invalid location, it returns the
> value from the last valid read.
> So it depends on the order you read things.

Yes, I came to the same conclusion. And that's logical after all.

> I would be wary of using this for detection purposes.

Sure, I wouldn't use that as a primary detection method. If we have a
"normal" method (manufacturer and device IDs, unused
configuration/status bits) it's far better. But if we even have a chip
that has no clean detection method and behaves like that, we still could
make use of it in some way. That's not very different from our LM75 or
SAA1064 detection methods, for which we rely on the fact that not all
(if any) address bits are valid for the chip.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
