From: Paul Thomas <pthomas8589@gmail.com>
Date: Wed, 06 Oct 2010 18:13:59 +0000
Subject: [lm-sensors] local macro
Message-Id: <AANLkTi=t1ObqqZiamKdZGHxrWc6FEP-QqSxrsbordDTi@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm planning a rev of the ads7871 driver. I want to add in the ability
to set the gain on the chip as well as do differential reads. To do
this I'm adding a bunch of SENSOR_DEVICE_ATTR lines. Awhile ago I had
got a suggestion from Jonathan to use a local macro for these
statements. Would that be a macro that looped through calling the
other macro 8 times with values 0-7? Could someone point me to an
example where this is used?

thanks,
Paul

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
