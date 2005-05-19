From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: strange i2cdetect output
Message-Id: <20021124192046.032bbab5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021116181757.3c4ab409.khali@linux-fr.org>
In-Reply-To: <20021116181757.3c4ab409.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I have come accross a very strange i2cdetect output. The machine is
> > a Sony Vaio GR114EK.
> (...)
> The adapter is broken or the bus is hung.
> Reboot. 
> Also, if an algo_bit adapter, rmmod i2c-algo-bit and then insmod
> i2c-algo-bit bit_test=1.
> 
> Perhaps error handling in whatever adapter you are using could be
> improved.

I finally figured out why. The adapter driver user (i2c-philips-par) was
wrong, the system needs the i2c-i801 driver. As the i2c-philips-par
adapter isn't detectable, there's nothing to improve.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
