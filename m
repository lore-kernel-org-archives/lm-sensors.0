From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: KT400a / VT8235
Message-Id: <20040125182043.67bb08bc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075043549.1154.39.camel@flaptop>
In-Reply-To: <1075043549.1154.39.camel@flaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> this is my next problem, sorry ;-) :
> 
> [root@flaptop root]# lsmod|grep i2c
> i2c-proc                8400   0  [eeprom]
> i2c-viapro              5008   0  (unused)
> i2c-core               18916   0  [eeprom i2c-proc i2c-viapro]
> [root@flaptop root]# rmmod i2c-viapro
> [root@flaptop root]# rmmod i2c-core
> i2c-core: Device or resource busy
> [root@flaptop root]# rmmod i2c-proc
> i2c-proc: Device or resource busy
> [root@flaptop root]#

Well, isn't it obvious? You need to rmmod eeprom first, as it uses both
i2c-proc and i2c-core. Yes, it doesn't have "i2c" in its name. It's a
long time tradition that bus drivers do but chip drivers don't. Don't
ask me why ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
