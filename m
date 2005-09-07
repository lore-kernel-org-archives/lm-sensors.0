From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 07 Sep 2005 09:09:31 +0000
Subject: [lm-sensors] lm78 on ep-61lxa-m not detected (#2042)
Message-Id: <kbE7sU4c.1126076480.7374120.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
In-Reply-To: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> root@silly:~# modprobe i2c_isa
> root@silly:~# sensors
> lm78-isa-0290
> Adapter: ISA adapter
> VCore 1:   +2.03 V  (min =  +0.13 V, max =  +0.77 V)   ALARM
> (...)

OK, that's great, but I still would like the output of:
isadump -y -f 0x290 8

So that we can fix the misdetection problem and you don't have to use
the force parameter in future revisions of the driver.

Thanks,
--
Jean Delvare
