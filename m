From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: update_lock
Message-Id: <1080746019.406ae0233bf15@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040320184909.4c7d8d80.khali@linux-fr.org>
In-Reply-To: <20040320184909.4c7d8d80.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Selon Aurelien Jarno :

> You're right that it can cause some problems, on my system I need to
> load the ds1621 module before the pcf8591 otherwise my ds1621 chip
> is recognized as a pcf8591.

In case you didn't know that, you can add a line like this in your
/etc/modules.conf file:
options pcf8591 ignore=0,0x42
where 0 is the bus number and 0x42 the i2c address of your DS1621 chip.

Then you can load the driver modules in any order.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
