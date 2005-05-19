From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: sensord: rrd database and timeslots
Message-Id: <20040424195234.16f3c427.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040421222823.GA14256@pc.aurel32.private>
In-Reply-To: <20040421222823.GA14256@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> what I meant is that if the true fan readings are usually  4111,4221,
> and 4309, for example, you'd expect to see a "stairstep" type of plot
> where only those values are shown and all the lines are vertical or
> horizontal; if there were interpolation, however, intermediate values
> would be plotted, which would make it appear that the fan sensor had
> more resolution than it actually did.

Oh OK, now I see what you mean. However, I don't see much added value in
knowing the resolution of the fan. RRD is meant to average the value,
it's a bit silly to use it and then complain about that ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
