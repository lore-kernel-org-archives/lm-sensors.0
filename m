From: donj@asaca.com (Don Jessup)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: xeontemp
Message-Id: <20031202143624.57255.qmail@web14522.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031202074706.7aded81e.khali@linux-fr.org>
In-Reply-To: <20031202074706.7aded81e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



  It is a dual 2.8 GHz Xeon 533 FSB.   

   1. xeontemp info 
   2. adm1021 info just for comparison.

   As you can see there both reporting the same cpu temp.

  

1.
###############################################################################

xeontemp-i2c-0-18
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
temp:        +30?C  (low  =    +0?C, high =   +85?C)

xeontemp-i2c-0-29
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
temp:        +29?C  (low  =    +0?C, high =   +85?C)


2.
################################################################################
max1617-i2c-0-18
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
Board:       +28?C  (low  =   -55?C, high =  +127?C)
CPU:         +30?C  (low  =    +0?C, high =   +85?C)

max1617-i2c-0-29
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
Board:       +28?C  (low  =   -55?C, high =  +127?C)
CPU:         +29?C  (low  =    +0?C, high =   +85?C)




--- Jean Delvare <khali@linux-fr.org> wrote:
> > Only caveat is I wrote the xeontemp module and can't test it,
> > and I've received zero reports about it, good or bad.
> 
> No wonder, it's not in sensors-detect and the adm1021 documentation
> doesn't mention it. So there's no way users can even suspect its
> existence.
> 
> This is the reason why I always add support for new chips to
> sensors-detect first, even before having a working driver.
> 
> Don, is your system a dual-Xeon one?
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> 
> 
> 
> 


==Don Jessup
Asaca/Shibasoku Corp. of America
400 Corporate Circle, Unit G
Golden, CO  80401
303-278-1111 X232
donj@asaca.com
http://www.asaca.com
