From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 21 Nov 2011 16:52:43 +0000
Subject: [lm-sensors] [PATCH v3 0/2] hwmon: LM63 enhancements
Message-Id: <1321894365-24285-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for external temperature offset register, and add supportfoe LM96163.

v2: Updated documentation.
v3: Updated Kconfig headline
    Point to LM96163 product page instead of datasheet
    Include linux/types.h
    Check if unsigned temperature limits are enabled, and display warning if yes
    Drop checkpatch cleanup from patchset (already applied)
    Add suport for external temperature offset register

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
