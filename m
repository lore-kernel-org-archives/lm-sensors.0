From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 22 Mar 2011 14:58:43 +0000
Subject: [lm-sensors] [PATCH 0/3] hwmon: (pmbus) PMBus bug fixes and code
Message-Id: <1300806192-1168-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following patches remove a stale variable, fix a bug in temperature sensor
code, and rewrite sensor detection code to be table based instead of hardcoded.

The first two patches will got into 2.6.39.

I am not sure about the infrastructure change. It does not change functionality
and reduces code size. Does that make it a candidate for 2.6.39, or should it
better wait for 2.6.40 ? Feedback is welcome.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
