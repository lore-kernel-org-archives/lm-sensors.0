From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lm_sensors2/prog/dump i2cbusses.c
Message-Id: <20031129201741.36f52fe5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FC6898D.DF9ECF07@paradyne.com>
In-Reply-To: <3FC6898D.DF9ECF07@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The 2.6 i2c-dev bus numbers don't necessarily match i2c-adapter bus
> numbers.
> If you rmmod and re-insmod a bus driver, the driver seems to get its
> old i2c-dev bus number back. But the i2c-adapter number increments.
> Don't know why. It would be much better if they matched.
> 
> Most userspace tools need the i2c-dev numbers since they are going
> to use /dev/i2c-x devices to access the bus.
> 
> The bus numbers reported by libsensors apps are the i2c-adapter
> numbers. I think it has to be that way since we don't need i2c-dev and
> therefore can't count on it being installed.
> 
> So you can't take a bus number from 'sensors' and then take that
> number and use it in 'i2cdump', for example.

This is odd. Any idea how to correct this? I'm a bit lost, I don't even
understand how there can be two values, since it obviously represent the
same thing (i.e. a bus identifier).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
