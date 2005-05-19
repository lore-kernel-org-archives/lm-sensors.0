From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Adding support for vt1211 in kernel 2.6
Message-Id: <20031202231054.6cb73a02.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <46951.192.176.33.6.1070287022.squirrel@firewall.isacson.dyndns.info>
In-Reply-To: <46951.192.176.33.6.1070287022.squirrel@firewall.isacson.dyndns.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It'll be for kernel 2.6.0-test11. Is it enough to just copy the vt1211
> file from the lm_sensors package and modify it as described in you
> patches?

Almost. You'll also have to edit the Makefile and Kconfig files to
integrate into the configuration and compilation process. See my patch
for the lm83 driver here:
http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.6/linux-2.6.0-test6-i2c-lm83.diff

Should give you a decent idea of how to do that.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
