From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: I2c and lm sensors 2.7.0 - sensors segmentation fault.
Message-Id: <20030406091243.3441e14e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000c01c2fbd9$840f5eb0$0300a8c0@dmp1800>
In-Reply-To: <000c01c2fbd9$840f5eb0$0300a8c0@dmp1800>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


[Reply to the list, not to me only.]

> Just tried to install i2c 2.7.0 and lm sensors 2.7.0 on a dual
> AMD MP2600+ machine running RH 8.0 with updates. Drivers load
> but when sensors command is run I get a segmentation fault.

Sounds like an old libsensors is lurking somewhere. To catch it, run:
/sbin/ldconfig -pv | grep libsensors

New libs are supposed to be in /usr/local/lib, so you should remove any
older lib in other places (such as /usr/lib).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
