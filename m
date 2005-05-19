From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: LM83 sensor
Message-Id: <20030701092551.55cd28d0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43612812.20030701105509@matrixc.ru>
In-Reply-To: <43612812.20030701105509@matrixc.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Please add code for NS LM83 chip to your project.
> I need it.

Which motherboard or device do you have that makes use of a LM83?

According to National, "the LM83 is pin for pin and register-compatible
with the LM84 and Maxim's MAX1617 and the Analog Devices ADM1021", for
wich we already have support. So adding support for the LM83 should be
rather easy.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
