From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 20 Sep 2011 16:35:01 +0000
Subject: [lm-sensors] [PATCH v3 0/2] hwmon: (coretemp) Fix threshold
Message-Id: <1316536503-26883-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

With commit c814a4c7c4aad795835583344353963a0a673eb0, the meaning of tempX_max
was changed. It no longer returns the value of the undocumented register
MSR_IA32_TEMPERATURE_TARGET, but instead returns the value of CPU threshold
register T1. tempX_max_hyst was added to reflect the value of temperature
threshold register T0.

As it turns out, T0 and T1 are used on some systems, presumably by the BIOS.
Also, T0 and T1 don't have a well defined meaning. The thresholds may be used
as upper or lower limits, and it is not guaranteed that T0 <= T1. Thus, the new
attribute mapping does not reflect the actual usage of the threshold registers.
Also, register contents are changed during runtime by an entity other than the
hwmon driver, meaning the values cached by the driver do not reflect actual
register contents.

To solve the problem, restore the old meaning of tempX_max to reflect the value
of MSR_IA32_TEMPERATURE_TARGET if it exists. Add new attributes tempX_threshold1
and tempX_threshold2 to reflect the values of T0 and T1. Do not cache the
attributes, but always read directly from CPU registers. Also add new attributes
tempX_threshold1_triggered and tempX_threshold2_triggered to report if the
temperature is equal or higher than the threshold, as reflected by the
THERM_STATUS_THRESHOLD[01] bits in the CPU status register.

v3: Updated documentation
    Split changes into two patches, one for 3.1 and one for 3.2.
    This reduces the risk for 3.1, and simplifies code review.
    Tested both patches on Xeon C5528 and Sandy Bridge
v2: Tested on i3/540 and Xeon C5528.
    Fixed double negation preventing tempX_max attribute from being generated.
    Added more detailed description.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
