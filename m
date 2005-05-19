From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: Coucou !!
Message-Id: <20021216153028.02ae6a53.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021215180648.7146bf09.sesshoumaru@altern.org>
In-Reply-To: <20021215180648.7146bf09.sesshoumaru@altern.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Hmm...i'd like to install ml_sensors unfortunately i have
> some mistake.
> I installed first the i2c package successfully i think. but
> i compiled the kernel and i have this module name in 
> /lib/module... :
>   i2o_config.o  i2o_core.o  i2o_pci.o  i2o_proc.o
> 
> Normal ? (for the name).

These are I2O modules, completely unrelated with I2C. Sensors use I2C.
We don't care a bit about I2O.

> After that i compiled lm_sensors and when i type depmod -a i had
> this errors : 
>  *** Unresolved symbols in 
>   /lib/modules/2.4.19/kernel/drivers/sensors/(sensors_modules)
> 
> Hmmm...i have forgotten something ?

Using depmod -ae would be of some help, for both you and us.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
