From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Constant beep and ALARM warnings on ALI1535
Message-Id: <20040201173031.78206e83.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401311948.50570.juanpedro@fibertel.com.ar>
In-Reply-To: <200401311948.50570.juanpedro@fibertel.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Ok, but some indicators, like temp, seem to work pretty well and the 
> "i2c-ali1535" makes some sense provided that the k7ada uses an ALI
> chipset.

i2c-ali1535 is the bus driver and is obviously correct. lm78 is the chip
driver and I still believe it's not correct.

We already had two reports of Soyo k7ada users having problems with
lm78. A little web search pointed me to an ALi M1647 chip for your
board. We don't have support for this. If you can find a data sheet, we
may be able to write a driver.

> athos:/dev# i2cdump 0 0x2c
> Warning: no size specified (using byte-data access)
> Error: Could not open file `/dev/i2c-0' : No such device
> athos:/dev#
> 
> <quote> `/dev/i2c-0' exists in filesystem </quote>

You need i2c-ali1535 and i2c-dev loaded.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
