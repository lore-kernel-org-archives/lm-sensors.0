From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 19 Sep 2010 16:33:22 +0000
Subject: [lm-sensors] New/undocumented ABI attributes in w83795 driver
Message-Id: <20100919163321.GA30847@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I had a closer look into the w83795 driver - this time trying to ignore
coding style problems ;) - and noticed that there are several attributes
which are not defined in the ABI.

I don't mind extending the ABI - done it several times myself recently,
after all - but this is pretty much creating a new fan / pwm control ABI.
Or, after looking into other drivers, it is using and possibly extending 
undocumented ABI attributes defined in other drivers.

Are we ready for that, ie are you sure that the ABI extensions are sane 
and fit the requirements of other drivers ? If yes, should this ABI be documented ?

Also, do you plan to write Documentation/hwmon/w83795 ? That seems to be missing 
in your patchset.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
