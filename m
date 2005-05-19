From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: linux-2.4/MAINTAINERS, i2c drivers
Message-Id: <1064476786.3f72a0728dbdb@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Dear Simon and Frodo,

I am planning to submit a patch to the MAINTAINERS files in Linux 2.4.
It seems that the "I2C DRIVERS" record is out of date. Frodo regularly
forwards mails to our mailing list. I haven't heard from Simon for
months. You both made remarkable work on Linux I2C layer, but maybe it's
time to update the record to point to active developers, lists and web
sites. It would ease communications between all actors, wouldn't it?

I volunteer to be the new maintainer of the i2c subsystem in 2.4. Greg
is already doing a great job in 2.6.

To the questions now:

Is a record update OK?

Are the following mailing list and web site still alive?
L:      linux-i2c@pelican.tk.uni-linz.ac.at
W:      http://www.tk.uni-linz.ac.at/~simon/private/i2c
Should they be kept in the record?

Here is my proposal of new record. Please tell me what you do think
about it:

I2C DRIVERS
P:      Jean Delvare
M:      khali@linux-fr.org
L:      sensors@stimpy.netroedge.com
W:      http://www.lm-sensors.nu/
S:      Maintained

Would it make sense to split the record into "I2C SUBSYSTEM" and "SENSOR
DRIVERS"? "I2C DRIVERS" doesn't really make sense, there are much more
I2C drivers in the kernel than just ours. On the other hand, we have
non-sensor drivers in our repository.

Comments welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

-------------------------------------------------
This mail sent through IMP: http://horde.org/imp/
