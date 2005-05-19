From: rafael.espindola@gmail.com (Rafael =?iso-8859-1?q?=C1vila_de_Esp=EDndola?=)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: lsb in emc6d102 and adm1027
Message-Id: <200503201236.33120.rafael.espindola@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The attached patches add support for reading the lsb from the emc6d102 and 
change how they are read from the adm1027.

The lm85_update_device function decodes the LSBs to temp_ext and in_ext. This 
strategy was suggested by Philip Pokorny.

The patch also changes some macros to use the SCALE macro. I think that they 
become more readable this way.

Rafael

Signed-off-by: Rafael ?vila de Esp?ndola <rafael.espindola@gmail.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: emc6d102-sensors.patch
Type: text/x-diff
Size: 3048 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050320/5216c415/emc6d102-sensors.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: emc6d102-kernel.patch
Type: text/x-diff
Size: 7526 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050320/5216c415/emc6d102-kernel.bin
