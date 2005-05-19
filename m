From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: i2c for Alpha
Message-Id: <20031027220238.0a7b281b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310121707.56799.jeff@jdfiles.org>
In-Reply-To: <200310121707.56799.jeff@jdfiles.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have located a block diagram for my server. It appears that the I2C
> bus hangs off the XBUS(?), whatever that is. Perhaps this is why I
> can't detect anything?
> (...)

Yes, that would explain why you don't detect anything useful. Unless you
are able to get a driver (or at least specs) for that XBUS thing, I fear
you won't be able to use our drivers at all on your system. And even
then, I wonder what kind of bus master you might have and how we'll make
it work through that XBUS.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
