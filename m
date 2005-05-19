From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.0-test2
Message-Id: <20030802095518.4c5630ef.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030802052904.GA9782@kroah.com>
In-Reply-To: <20030802052904.GA9782@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Greg,

> <nikkne:hotpop.com>:
>   o I2C: fix Kconfig info
> 
> <patrick:dreker.de>:
>   o I2C: add ncforce2 i2c bus driver
> 
> Benjamin Herrenschmidt:
>   o I2C: timer clean up for i2c-keywest.c
> 
> Daniele Bellucci:
>   o I2C: fixed a little memory leak in i2c-ali15x3.c
> 
> Greg Kroah-Hartman:
>   o I2C: remove devinitdata marking from i2c-nforce2.c as it's wrong
>   o I2C: consolidate the i2c delay functions
>   o I2C: minor cleanups to the i2c-nforce2 driver
> 
> Jan Dittmer:
>   o I2C: convert via686a temp_* to milli degree celsius

Does any of these apply to our CVS repository?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
