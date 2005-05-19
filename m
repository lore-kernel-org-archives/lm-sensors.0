From: asterix@crans.org (asterix)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: pb with 2.4.22
Message-Id: <3F7972E6.1000408@crans.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hello,

i've just compiled a 2.4.22 kernel and i'd like to have sensors. With 
the 2.4.19 kernal i had no pb to install them, but with the 2.4.22 
kernel, when i apply this path :
(http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.4.22/linux-2.4.22-i2c-2.8.0.patch)
i don't have the busses and chips folders in 
/usr/src/linux-2.4.22/drivers/i2c
so i can't compile Hardware sensors mainboard support and Hardware 
sensors chip support in my kernel ...

so is there another patch ?

thank's a lot for help
Yann
