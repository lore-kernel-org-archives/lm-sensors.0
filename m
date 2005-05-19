From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: RFC: adm9240 sysfs names
Message-Id: <q0tq51dogaehvkvm4f6q15n4t1khe3jqo9@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings,

These are the sysfs names currently used by adm9240 driver, please 
let me know if any of the 'odd' ones need changing.

Complete crossref list for linux-2.6.12-rc2-mm3/drivers/i2c/chips 
is available from:
http://scatter.mine.nu/lmsensors/adm9240/cross-2.6.12-rc2-mm3/

Changes: fan1_div, fan2_div are read-only

adm9240.c    alarms         R
adm9240.c    analog_out     RW
adm9240.c    ci_clear       W
adm9240.c    cpu0_vid       R
adm9240.c    fan1_div       R
adm9240.c    fan1_input     R
adm9240.c    fan1_min       RW
adm9240.c    fan2_div       R
adm9240.c    fan2_input     R
adm9240.c    fan2_min       RW
adm9240.c    in0_input      R
adm9240.c    in0_max        RW
adm9240.c    in0_min        RW
adm9240.c    in1_input      R
adm9240.c    in1_max        RW
adm9240.c    in1_min        RW
adm9240.c    in2_input      R
adm9240.c    in2_max        RW
adm9240.c    in2_min        RW
adm9240.c    in3_input      R
adm9240.c    in3_max        RW
adm9240.c    in3_min        RW
adm9240.c    in4_input      R
adm9240.c    in4_max        RW
adm9240.c    in4_min        RW
adm9240.c    in5_input      R
adm9240.c    in5_max        RW
adm9240.c    in5_min        RW
adm9240.c    temp1_input    R
adm9240.c    temp1_max      WR
adm9240.c    temp1_max_hyst WR

Cheers,
Grant.
