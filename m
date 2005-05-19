From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: System hanging using CSB5 chip with 2.8.1 - No longer
Message-Id: <20031202202922.1afb93ee.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
In-Reply-To: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I wrote the xeontemp driver as a one-temperature driver,
> since it was confusing to people using the adm1021 driver that they
> had to ignore the local temp and look at the remote temp.

Did you really write (I mean, cut and paste) a new driver just so that
people wouldn't have to add an ignore statement in their config file?
This is bad. A comment in both sensors.conf.eg and doc/chips/adm1021
should be sufficent.

> Khali, I'll update the docs myself using Philip's info,
> to make recommendations.

Maybe you could mention that dual-Xeon systems will have a second
adm1021-compatible chip at 0x29 or so?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
