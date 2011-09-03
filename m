From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 03 Sep 2011 02:27:46 +0000
Subject: [lm-sensors] [PATCH 0/4] hwmon: PMBus patch series
Message-Id: <1315016870-10579-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Series of PMBus patches

This patch series was tested with the following chips:

ADM1275, ADM1276, BMR453, BMR454, LM5064, LM5066, LM25066, LTC2978, ZL2004,
ZL2008, ZL2105, ZL6100, ZL6105, MAX8688, MAX16064, MAX34441, UCD9240

Version log:

[PATCH v3 1/4] hwmon: (pmbus) Provide more documentation

v3: Added details about page parameter for byte access functions
v2: Added details about command execution by core PMBus driver

[PATCH 2/4] hwmon: (pmbus) Replace EINVAL return codes with more appropriate errors

[v1]

[PATCH v2 3/4] hwmon: (pmbus) Always call _pmbus_read_byte in core driver

v2: Be more careful with page validation for byte access functions.
    Specifically, always accept -1 as valid page number in device specific code,
    and don't select the page if the page number is -1.

[PATCH v2 4/4] hwmon: (pmbus) Add support for Intersil power management chips

v2: Be more careful with page number validation for byte access functions,
    and use improved id array walking code in probe function.
    Add warning to documentation to avoid access to certain command registers.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
