From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: helping
Message-Id: <20031205220404.1a062eea.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Great, grab one of the i2c chip drivers that is not ported to 2.4 from
> the cvs tree, read the docs on how to port the drivers, and then send
> me a patch against the latest 2.6 kernel with the new driver :)

Greg of course means "that is not ported to 2.6". Especially the lm80
and lm87 drivers would need porting. If possible, don't pick lm90 nor
adm1025 since I plan to port them soon myself (in this order).

For documentation on porting, get the three following patches:
http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.6/linux-2.6.0-test9-i2c-doc-porting-clients.diff
http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.6/linux-2.6.0-test9-i2c-doc-sysfs-interface.diff
http://www.ensicaen.ismra.fr/~delvare/devel/i2c/linux-2.6/linux-2.6.0-test9-i2c-doc-writing-clients.diff
and apply them to your 2.6 kernel tree. 

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
