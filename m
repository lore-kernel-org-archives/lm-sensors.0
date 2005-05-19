From: beejay@gentoo.org (Benjamin Judas)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Bug #1807: sensors with kernel 2.4, but not with kernel 2.6
Message-Id: <1099499265.11618.15.camel@antares.hausnetz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1099499003.11618.13.camel@antares.hausnetz>
In-Reply-To: <1099499003.11618.13.camel@antares.hausnetz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The modules themselves load properly, the directory in /sys/bus/i2c/drivers gets created:
> 
> antares /home/benni # cd /sys/bus/i2c/drivers/
> antares /sys/bus/i2c/drivers # ls -al
> insgesamt 0
> drwxr-xr-x  11 root root 0  3. Nov 16:54 .
> drwxr-xr-x   4 root root 0  3. Nov 2004  ..
> drwxr-xr-x   2 root root 0  3. Nov 16:54 asb100
> drwxr-xr-x   2 root root 0  3. Nov 2004  generic i2c audio driver
> drwxr-xr-x   2 root root 0  3. Nov 2004  i2c_adapter
> drwxr-xr-x   2 root root 0  3. Nov 2004  i2c msp3400 driver
> drwxr-xr-x   2 root root 0  3. Nov 2004  i2c tda7432 driver
> drwxr-xr-x   2 root root 0  3. Nov 2004  i2c tda9875 driver
> drwxr-xr-x   2 root root 0  3. Nov 2004  i2c tda9887 driver
> drwxr-xr-x   2 root root 0  3. Nov 2004  i2c TV tuner driver
> drwxr-xr-x   2 root root 0  3. Nov 2004  ir remote kbd driver

Sorry, what I forgot to mention is that asb100/ is *empty*.



-- 

Benjamin Judas

---------------------------------------------------------------------                                  
Gentoo-developer                        http://dev.gentoo.org/~beejay
Giessen, Germany                                http://www.gentoo.org

GPG-Key         : 0xC31DEDD8
Key-Fingerprint : 4E65 AAFE 785B 61D8 E4D9  1671 E017 87B7 C31D EDD8
Jabber          : beejay@im.gentoo.org


-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Dies ist ein digital signierter Nachrichtenteil
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041103/f73f8a4e/attachment.bin
