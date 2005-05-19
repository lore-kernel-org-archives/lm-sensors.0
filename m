From: jeff@jdfiles.org (Jeff Sacksteder)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: i2c for Alpha
Message-Id: <200310152152.21972.jeff@jdfiles.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310121707.56799.jeff@jdfiles.org>
In-Reply-To: <200310121707.56799.jeff@jdfiles.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I suspect that you tried to update lm_sensors to 2.8.0 but did not
> update i2c to 2.8.0 preliminarily. Do that and it should work OK. You

I built i2c outside the kernel using a package for my distribution.

> might want to take a look at our installation guide at
> http://www.ensicaen.ismra.fr/~delvare/devel/i2c/ since installing i2c
> 2.8.0 is somewhat tricky.

Is it still the case with 2.8.1, that you have to have the kernel patch 
applied to build? 
