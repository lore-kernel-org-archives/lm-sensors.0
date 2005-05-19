From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: i2c for Alpha
Message-Id: <20031026102202.1585f262.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310121707.56799.jeff@jdfiles.org>
In-Reply-To: <200310121707.56799.jeff@jdfiles.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have successfully built i2c and lm_sensors on my alpha.
> Sensors-detect reports successfully identified the following-
> 
> i2c-velleman.o: i2c Velleman K8000 adapter module version 2.6.5
> (20020915) i2c-velleman.o: found device at 0x378.
> i2c-dev.o: i2c /dev entries driver module version 2.6.5 (20020915)
> i2c-dev.o: Registered 'Velleman K8000' as minor 0
> 
> No devices appear to be attached to the bus, though. Is there any
> other information I should make note of before trying to build 2.8 for
> this device?

Two things I'd try:
1* Get sensors-detect from CVS and give it a try. It knows much more
than the one in 2.6.5. Of course it will make reference to drivers that
you don't have, but just don't care. Feel free to send us the complete
output of sensors-detect, it might help us helping you.
2* If the above doesn't give any result, please run "i2cdetect 0" and
send us the output of that command.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
