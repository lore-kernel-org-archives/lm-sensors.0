From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: i2c-2.8.0 : userspace applications using /dev interface
Message-Id: <20030913234949.6a96d6d8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000901c37841$38703170$154310ac@NBLASSAHN>
In-Reply-To: <000901c37841$38703170$154310ac@NBLASSAHN>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> We lack some understanding on how i2c-2.8.0 userspace applications
> using the/dev interface and ioctl()s have to be programmed (we tested
> with kernel 2.4.22).
> 
> It seem to be necessary to include i2c.h in addition to i2c-dev.h in
> order to get access to defines like I2C_SLAVE for the ioctl()s.
> 
> However, i2c.h can not be included by userspace applications because
> it uses kernel space typedefs and declarations.
> This is in agreement with your example in the LM Sensors project
> (prog/detect/i2cdetect.c). It uses I2C_SLAVE without including i2c.h.
> 
> Is there a way out here ?

I had a hard time understanding how it can work, and it turns out that
the trick is that there are *two* different versions of i2c-dev.h. The
version that comes with i2c is small and intended for internal use only.
The version that comes with lm_sensors is huge, and contains a large
part of i2c.h, so that usespace applications can include it and work as
intended. Use that second version, and everything should be OK. That is
how i2cdetect, among others, is doing.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
