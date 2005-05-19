From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: i2c-piix4 oops
Message-Id: <1080218722.4062d4621bc3c@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hello,
> Sorry if I'm wrong writing you.
> I have Fujitsu Lifebook based on I440MX, then I'm trying to use
> i2c-piix4 on kernel 2.6.4, it loads successfully, but then I'm
> testing it with for example i2cdetect from lm_sensors package it
> goes in oops like:

I guess you enabled "I2C Core debugging" when configuring your kernel.
There's a bug in there, which is causing this known oops:
http://bugzilla.kernel.org/show_bug.cgi?id!84

This is hopefully fixed in 2.6.5-rc2. In the meantime, just disable I2C
Core debugging and the oops should go away.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
