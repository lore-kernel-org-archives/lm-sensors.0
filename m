From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Winbond 792 source codes for lm_sensor
Message-Id: <qzxvhxKT.1108721946.6509280.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE0673FD@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Chunhao,

> As to the voltage factor, after a further study to the 792 data sheet
> and /etc/sensors.conf, I find that the interface vol_factor in /proc
> can really be removed from the 792 driver. The calculation has been
> transferred into /etc/sensors.conf, instead of in the 792 driver.
> (...)
> So, in my previous 792 driver, I had to calculate the voltage in
> the driver, instead of in /etc/sensors.conf
>
> But now, I find that as to in0-in6, the factors of voltage limit
> are the 4 times to the one of measured value.
> (...)
> And voltage factors for measured value are added into /etc/sensors.conf.

This is really good news! It is very great that you managed to have this
chip fit in the common model the other drivers follow for voltage
computations. This will make your code much easier to integrate and
it'll also make things easier for long-time lm_sensors users which
happen to have a W83792D on their new hardware - things will work the
same way they were used to!

Thanks a lot,
--
Jean Delvare
