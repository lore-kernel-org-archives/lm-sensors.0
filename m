From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: xeontemp
Message-Id: <20031202202229.12954948.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031202074706.7aded81e.khali@linux-fr.org>
In-Reply-To: <20031202074706.7aded81e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> It is a dual 2.8 GHz Xeon 533 FSB.

I'd like this as my personal server ;)

> max1617-i2c-0-18
> Adapter: SMBus PIIX4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> Board:       +28?C  (low  =   -55?C, high =  +127?C)
> CPU:         +30?C  (low  =    +0?C, high =   +85?C)
> 
> max1617-i2c-0-29
> Adapter: SMBus PIIX4 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> Board:       +28?C  (low  =   -55?C, high =  +127?C)
> CPU:         +29?C  (low  =    +0?C, high =   +85?C)

Look like real MAX1617 chips to me, with local limits left to their
default values (which basically means that local temp won't raise any
alarm). Feel free to change limits to match your own needs.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
