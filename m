From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 19:01:42 +0000
Subject: [lm-sensors] [PATCH 0/9] hwmon: (emc1403) Various enhancements
Message-Id: <1399921311-9524-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

See individual patches for details.

Patches apply on top of the previously submitted patches by Jean Delvare
and Josef Gajdusek, which should be available in linux-next by tomorrow
and are available in the hwmon-next branch of
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git.

Caveat: Compile tested only, not ready for integration.
Especially min_hyst, max_hyst, and fault attributes need testing (not sure if I
interpreted the datasheets correctly), but also alarm and fault attributes
on EMC14x2. Plus of course the regmap conversion. I am sure I have a test board
somewhere, but can't find it right now, so testing may take a bit.
Josef, if you have time, would be great if you can give it a try.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
