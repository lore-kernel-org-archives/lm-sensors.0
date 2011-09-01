From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 01 Sep 2011 03:10:37 +0000
Subject: [lm-sensors] HWMON and SYSFS dependency
Message-Id: <20110901031037.GA25052@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

the HWMON subsystem does not make much sense if SYSFS is not defined.
Is there a reason why it can be configured in that case,
or should we make it dependent on SYSFS ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
