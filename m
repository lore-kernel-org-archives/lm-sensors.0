From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:08 +0000
Subject: Usbvision/i2c-algo-usb port to 2.8.0
Message-Id: <20030731115058.52511603.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030730165206.M58081@bandos.homelinux.com>
In-Reply-To: <20030730165206.M58081@bandos.homelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Thanks! Will do, as soon as I can. I will also email the patch to the
> author(s) of the usbvision drivers, after I test it, ok?

Mhh, not necessarily. The patch is intended for users, not authors. If
the author was to apply this patch to his code right now, users that are
not using i2c-2.8.0 couldn't use usbvision anymore.

Once the new I2C has made it into the official kernel (should be 2.4.23)
we'll submit real patches to the authors that work for both pre-2.4.23
and 2.4.23 kernels.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
