From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: LM83 driver
Message-Id: <20030723180958.649e4584.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030703194558.60bc8955.khali@linux-fr.org>
In-Reply-To: <20030703194558.60bc8955.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Zoleg,

Three weeks ago, you requested a driver for the LM83 you say you had on
your motherboard. I wrote the driver and told you about it, but we never
heard about you again. Why that? It's not very polite to you to make me
work for you and ignore me once the job is done...

Nevermind, I would need your help now. First I would like you to try the
driver. It's included in our latest release (2.8.0), or you can use CVS
for a slightly improved version. I'd really like to know if the chip is
detected by our sensors-detect script, and how the driver behaves.

Second, I would like you to unload the lm83 driver (rmmod lm83) and dump
the contents of your LM83 chip. You will need to find at which address
it is located (sensors-detect should tell you) and run the following
command:
  i2cdump 0 0x18
(replace 18 with the address given by sensors-detect; if the chip is
located on a second I2C bus, replace 0 with 1).

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
