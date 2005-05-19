From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: remove 2.2 support?
Message-Id: <20021230094750.1b3bffb6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E0E709B.5000900@paradyne.com>
In-Reply-To: <3E0E709B.5000900@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> testing and fixing 2.2 support was a real pain at the end of the 2.7.0
> cycle. It also adds a lot of cruft in the drivers and adds to patch
> misery. What do you think of removing 2.2 support and making 2.7.0 the
> last 2.2-compatible release? For reference, we dropped 2.0 support in
> release 2.5.0, March 2000. mds

Though dropping support is something serious and I don't especially like
it, I think you're right. However, I'd prefer that we drop support only
on a .0 release. That way, there's still a possibility to release a fix
if something appears to go wrong. So, we'd better release the next
version as 2.8.0 if it doesn't support kernels 2.2, which will let us
have a 2.7.1 someday if the 2.7.0 release is to be known has having any
serious problem.

Any objection?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
