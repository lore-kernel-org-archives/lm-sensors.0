From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: sensord: rrd database and timeslots
Message-Id: <20040424190529.3ee1dce8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040421222823.GA14256@pc.aurel32.private>
In-Reply-To: <20040421222823.GA14256@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> even if he increases the fan divisor so he doesn't get 0 anymore,
> fan readings don't have a lot of resolution, so the values
> might be 4111, 4221, 4309, etc., so I can see where
> interpolation could be misleading.

I don't. Who cares about the exact reading (which anyway is already a
truncated value)? If rrd averages 4111 and 4221 to, say, 4139, well,
this is a relevant value (while averaging 4111 and 0 to, say, 300
wouldn't).

As a side note, the 0 reading cannot be due to a bad fan divisor. Mario
set the divisors to 2 and 4200 is no way near the limit for an AS99127F
(it is below 3000 if I remember correctly). More likely the fan is
broken

I also think that it is possible to tell rrd to ignore values outside of
a given range. You could make it so that 0 isn't in the range, so it be
taken into account. However, this makes monitoring the fan rather
useless, of course. In any case I would consider buying a new, working
fan. Trying to work around buggy hardware through software tricks rarely
works (and is never the right thing to do).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
