From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:19:49 +0000
Subject: [lm-sensors] [PATCH resend 00/39] hwmon: Convert hwmon drivers to use devm_ functions
Message-Id: <1344352828-25143-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert most of the remaining hwmon drivers to use devm_ functions to reduce
code size and simplify the code.

The patches in this series were originally submitted for review in June. I got
review feedback for many of the patches submitted at that time. I did not get
feedback for the following set of patches (or I missed it - my apologies if that
is the case). Unless I get negative feedback, the patches will be queued in my
-next tree, for release with 3.7.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
