From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: pb with 2.4.22
Message-Id: <20030930213329.10be7e04.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F7972E6.1000408@crans.org>
In-Reply-To: <3F7972E6.1000408@crans.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> i've just compiled a 2.4.22 kernel and i'd like to have sensors. With 
> the 2.4.19 kernal i had no pb to install them, but with the 2.4.22 
> kernel, when i apply this path :
> (http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.4.22/linux-2
> .4.22-i2c-2.8.0.patch) i don't have the busses and chips folders in 
> /usr/src/linux-2.4.22/drivers/i2c
> so i can't compile Hardware sensors mainboard support and Hardware 
> sensors chip support in my kernel ...
> 
> so is there another patch ?

Yes, there is. There are two separate parts in installing lm_sensors:
i2c and lm_sensors itself. The patch you mention only replaces the i2c
part. You still have to install lm_sensors (by patching your kernel
using mkpatch, or compiling off the kernel tree, at your option) as
usual.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
