From: jeff@jdfiles.org (jeff@jdfiles.org)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: i2c for Alpha
Message-Id: <1227.10.0.0.5.1067120326.squirrel@secure.jdfiles.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310121707.56799.jeff@jdfiles.org>
In-Reply-To: <200310121707.56799.jeff@jdfiles.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have successfully built i2c and lm_sensors on my alpha. Sensors-detect
reports successfully identified the following-

i2c-velleman.o: i2c Velleman K8000 adapter module version 2.6.5 (20020915)
i2c-velleman.o: found device at 0x378.
i2c-dev.o: i2c /dev entries driver module version 2.6.5 (20020915)
i2c-dev.o: Registered 'Velleman K8000' as minor 0

No devices appear to be attached to the bus, though. Is there any other
information I should make note of before trying to build 2.8 for this
device?
