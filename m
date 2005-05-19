From: rafael.espindola@gmail.com (Rafael =?iso-8859-1?q?=C1vila_de_Esp=EDndola?=)
Date: Thu, 19 May 2005 06:25:34 +0000
Subject: emc6d102 support
Message-Id: <200502011003.40803.rafael.espindola@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The attached patchs add support for the emc6d102. It already worked as a 
"generic lm85" so the patchs are mostly cosmetic.

The emc6d102 has a 10bits A/D converter. Do you think that it would be 
worthwhile to add support to it?

Rafael
-------------- next part --------------
A non-text attachment was scrubbed...
Name: emc6d102-kernel.patch
Type: text/x-diff
Size: 1320 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050201/b0c5d861/emc6d102-kernel.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: emc6d102-sensors.patch
Type: text/x-diff
Size: 3047 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050201/b0c5d861/emc6d102-sensors.bin
