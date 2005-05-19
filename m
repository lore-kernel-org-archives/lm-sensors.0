From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: [PATCH] eeprom chip driver for 2.6
Message-Id: <1064477203.3f72a21356ab1@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030923232510.GB6265@kroah.com>
In-Reply-To: <20030923232510.GB6265@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Ah, yeah, that probably will not work now.
> 
> Oh well, we don't really need to worry about speed here :)

I do, but I am obviously the only one ;) (well, all I2C devices I have
in my laptop are two EEPROMS, that may be why). But I admit it is not
really important.

Still I believe that a slow eeprom driver means that we should not
handle eeproms in the sensors program. There are special scripts to
decode eeproms, that do a much better job.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
