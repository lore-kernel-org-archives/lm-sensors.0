From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Hangs with w83781d
Message-Id: <20040221054342.5eaa3d3b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.53.0304082321580.3437@loki.albatross.co.nz>
In-Reply-To: <Pine.LNX.4.53.0304082321580.3437@loki.albatross.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > 2* Which value is present in the register 0x4C before you load
> > w83781d for the first time. (Load the bus driver and use i2cdump to
> > dump the chip contents.)
> 
> loki:~# i2cdump 0 0x4C
> (...)

Hm no, this isn't the correct command.

> loki:~# i2cdetect 0
>   WARNING! This program can confuse your I2C bus, cause data loss and
>   worse! I will probe file /dev/i2c-0
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: XX XX XX XX XX XX XX XX XX XX XX XX 0c XX XX XX
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX XX
                                             ^^
It is here!

So the correct command is "i2cdump 0 0x2d" (and then look at the value
at 0x4C in the output).

> > 3* The value present in the same register after you load and unload
> > the w83781d driver *with your modification* (i.e. we'll get the
> > value resulting from the reset operation).
> 
> This doesn't change.

Maybe it will now ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
