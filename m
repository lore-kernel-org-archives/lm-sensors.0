From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: System hanging using CSB5 chip with 2.8.1 - No longer
Message-Id: <20031201224703.77117c78.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
In-Reply-To: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(MDS, question for you below.)

> > Why did you use that force parameter? Was it suggested by
> > sensors-detect?
> 
> The adm1021 text file in lm_sensors2/doc/chips suggest to get Xeon
> support that I should use the force_adm1021 module parameter.  Is
> this correct ?  Should I just use the module without any
> parameters?

Probably something left from the past, I don't think it's true anymore.
Sensors-detect will detect these as MAX1617 chips, and the adm1021
drivers should load without the force parameter.

What's more, we now have another driver, xeontemp, which I think is the
right driver to use in this case. Read doc/xeontemp for details.

Looks like our adm1021 driver doc needs an update. Mark, if you confirm
my analysis is correct, I'll update the docs.

Also, Mark, sensors-detect doesn't know about xeontemp. Is it because
it's difficult to differenciate from the MAX1617? According to the docs,
the temperature readings are not exaclty the same, so maybe we could use
some heuristics?

> I have included 9 log files in this e-mail.
> This first file being the sensors-detect.log. The next 4 are
> i2cdump without force_adm1021 as a module paramter.  The next 4 are
> i2cdump with  the force_adm1021 as a module parameter.

The force parameter doesn't do anything here. This parameter skips
detection while loading a driver. I2cdump reads the chips directly, it
doesn't use the driver (actually you are supposed to unload chip drivers
before dumping their contents).

The chips at 0x18 and 0x29 could be MAX167 chips (or Xeon, if this is a
xeon system, in which case you should really give a try to the xeontemp
driver instead of the adm1021 driver).

The chips at 0x2d and 0x2e could be LM87 (I don't know that chip very
well but sensors-detect seems to be fairly confident).

All you have to do is load the drivers, run "sensors -s" and tweak
things to fix your needs, I think.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
