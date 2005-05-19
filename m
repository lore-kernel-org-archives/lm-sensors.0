From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Usbvision/i2c-algo-usb port to 2.8.0
Message-Id: <20030806165022.617d4daf.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030730165206.M58081@bandos.homelinux.com>
In-Reply-To: <20030730165206.M58081@bandos.homelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I picked up most from the kernel patch
> (http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.4.21-i2c-2.8
> .0.patch), in which you also leave out algo_control in your patch for
> i2c-algo-bit.c;

(Just took a deeper look at the code.)

That's because it was unused for that particular algorithm. But it is
still used for two other algorithms: ibm_ocp and iop3xx (not build by
default). So if i2c-algo-usb was using it, I think we have to leave it
there.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
