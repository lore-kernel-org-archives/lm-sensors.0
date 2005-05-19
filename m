From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: more 2.6 mapping issues
Message-Id: <4012F311.9040503@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

lm78, lm75 at least have
temp_input, temp_max, temp_hyst in sysfs,

but the mapping in lib/proc.c is
temp=>temp_input1
temp_hyst=>temp_hyst1
temp_over=>temp_max1

do we want to submit a driver patch to add the '1' suffixes
or add mappings in lib/chips.c?

To be in conformance with Documentation/i2c/sysfs-interface we should add the '1'.
