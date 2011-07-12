From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 12 Jul 2011 02:12:30 +0000
Subject: [lm-sensors] RFC: Moving pmbus drivers into hwmon subdirectory
Message-Id: <20110712021230.GA22766@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

since the number of PMBus slave/client drivers keeps getting larger,
I have been wondering if I should move them into a separate subdirectory,
most likely drivers/hwmon/pmbus/.

Any thoughts/comments about that ?

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
