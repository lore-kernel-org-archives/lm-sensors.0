From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 21 Jun 2005 11:43:47 +0000
Subject: [lm-sensors] RE: w83792d driver for the 2.6 kernel
Message-Id: <1VymmRpH.1119346742.1945350.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE5E7741@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Fabien,

> I used the daily snapshot as recommanded by Rudolf and had to :
>  - copy the etc/sensors.conf.eg to /etc/sensors.conf

This is true.

>  - run the sensors-detect from the lm_sensors distribution (the make
> user_install command did not install it)

This would be very surprising, please double-check. Remember that
everything is installed under /usr/local by default, and sensors-detect
is only usable by root so it's installed in /usr/local/sbin.

>  - run /usr/local/bin/sensors to make sure I did not run the Fedora
> version of sensors.

You should even uninstall the Fedora package entierly, else the new
sensors command may pick the old library and you won't get correct
results.

> I also removed the Fedora version but the sensors-detect script still
> failed to detect the 83792d. Could it be because it is not properly
> installed ? What commands should I issue in addition to "make user; make
> user_install" ?

These commands should be sufficient. Make sure that your kernel supports
the I2C Device Interface (i2c-dev driver), sensors-detect needs it (and
should have complained if it's not present). Also note that
sensors-detect cannot detect I2C chips for which you have a driver
currently loaded (because the probe would possibly confuse the driver).
If you can't figure it out, please send the complete output of
sensors-detect after unloading all i2c chip drivers.

--
Jean Delvare
