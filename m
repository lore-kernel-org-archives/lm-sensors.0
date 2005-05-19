From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Ticket 1319 - lm_sensors-2.8.0-cvs linux-2.4.20-smp-i386
Message-Id: <20030710095348.7aa74652.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030710085158.42e68c95.zdavatz@ywesee.com>
In-Reply-To: <20030710085158.42e68c95.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


[PLEASE DON'T REPLY TO ME ONLY. REPLY TO THE LIST INSTEAD.]

> Strange enough; If I do it with a Debian package everything install
> great, but no sensors are found. That is why I compile from cvs.
> 
> What else could I have done wrong?

Rather logical. Debian is shipping an old (and stable) version of our
package, which has less devices supported.

Please make sure you uninstall all Debian i2c and lm_sensors packages
before trying CVS. If you don't, there will be old i2c headers lying
around and lm_sensors may accidentally get those instead of ours when
you try to compile it. That too could explain the errors you get.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
