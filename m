From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: bug report with kernel 2.4.23
Message-Id: <20031205184833.326f0472.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1070644029.8713.15.camel@equi-NoX.WORKGROUP>
In-Reply-To: <1070644029.8713.15.camel@equi-NoX.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have tried to install your kernel patch by doing:
> 
> cd /tmp/lm_sensors-2.8.1
> mkpatch/mkpatch.pl . /usr/src/linux > /tmp/sensors-patch
> cd /usr/src/linux
> patch -p1 -E < /tmp/sensors-patch

You are supposed to install the i2c patch before the lm_sensors patch.
You'll find that patch here:
http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.4.23/linux-2.4.23-i2c-2.8.1.patch

Install it first, then the lm_sensors patch, reconfigure your kernel and
it should be OK.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
