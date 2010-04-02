From: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
Date: Fri, 02 Apr 2010 15:47:50 +0000
Subject: [lm-sensors] regulator: regulator_get behaviour without
Message-Id: <1779783481.621270223270264.JavaMail.root@mail.savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <2122967437.461270223106350.JavaMail.root@mail.savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: lm-sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org

Hi,

Working on drivers/hwmon/sht15.c, I noticed it would return bogus temperatures in my case, where CONFIG_REGULATOR is not set.

This is due to the following section in drivers/hwmon/sht15.c:

/* If a regulator is available, query what the supply voltage actually is!*/
        data->reg = regulator_get(data->dev, "vcc");
        if (!IS_ERR(data->reg)) {
            ...

Looking at consumer.h, it appears that regulator_get() returns a pointer to its second argument when CONFIG_REGULATOR is not set.

What would be the proper way to determine if the returned value is a valid regulator ?
Would it be safe to check it against the 2nd argument ?

Regards
Jerome Oufella

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
