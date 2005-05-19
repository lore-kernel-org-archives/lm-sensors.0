From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Can't access /proc file for writing
Message-Id: <20031102105250.05391509.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1067739926.5304.28.camel@hahasiah.rozsas.xx.nom.br>
In-Reply-To: <1067739926.5304.28.camel@hahasiah.rozsas.xx.nom.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Anyone can you help me, please ?

I'll do my best.

> My system is a ASUS P4T, P4 1.4GHz, running RH9, with the last
> stable kernel 2.4.22 (from kernel.org), whith the
> linux-2.4.22-i2c-2.8.1.patch patch applied and
> lm_sensors-2.8.1.tar.gz installed.

Looks OK. Any additional patch (ACL, GRSEC) applied?

> Looking at /proc/bus I've noticed that i2c* are 0444 !

That's perfectly normal, see below.

> running just sensors, looks like fine (...almost...Why -12V and -5V
> readings are wrong ?):

Either because "sensors -s" failed, or because these voltages aren't
used on your system (most systems don't use these voltages anymore, so
some don't bother monitoring them).

> 1) Why the permissions for /proc/bus/i2c* are 0444 ?

This is normal. These files only advertise about existing busses. Real
files are in /proc/sys/dev/sensors.

> 2) Why the reading for-12V and -5V are wrong ?
> How can fix this ?

Move to /proc/sys/dev/sensors, and show us what "ls -lR" returns.

We have had half a dozen reports of problems similar to yours, and I
have to say we never really found what was causing the problem (so
couldn't solve it). If you system is specific in any way, please let us
know (of course, i's hard to say what "specific" means here, since we
don't really know what we're after).

> PS: Sorry any mistakes in my text. English isn't my native language.

It's not mine either, but we understand each other, isn't it? :)


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
