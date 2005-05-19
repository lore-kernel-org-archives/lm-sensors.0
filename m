From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Question about VID
Message-Id: <20031101121306.70c93593.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031031055903.GB20640@earth.solarsys.private>
In-Reply-To: <20031031055903.GB20640@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> just assume the vid pins are always there.
> If they aren't hooked up, it's no different than for any
> other chip or driver.

But if the pins are connected to something else, we'll be claiming a bad
VID value, which is IMHO worst that clearly stating that VID isn't
supported for that chip.

> vid is only used for calculation of limits in sensors.conf.
> how many people bother to program the correct "VRM" specification
> setting anyway, I don't know, probably isn't that high...

Maybe more than you think. From my own experience, few people read docs,
but much more do read and tweek config files. And I also guess that our
users are somewhat more experienced ans serious than the average. If
they made it through the installation process, which isn't an easy one,
and the detection process, and are finally getting some results, I think
they are very likely to try fixing incorrect values, either by
themselves or by asking for help on the mailing-list.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
