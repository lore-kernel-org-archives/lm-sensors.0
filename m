From: rafael.espindola@gmail.com (Rafael =?utf-8?q?=C3=81vila_de_Esp=C3=ADndola?=)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: emc6d102 support
Message-Id: <200503201225.34187.rafael.espindola@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502011003.40803.rafael.espindola@gmail.com>
In-Reply-To: <200502011003.40803.rafael.espindola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The attached patchs add support for the extended precision ADC present in the 
emc6d102 and adm1027. The kernel patch also redefines some macros to 
explicitly use SCALE. This change makes then more readable.

Rafael
-------------- next part --------------
A non-text attachment was scrubbed...
Name: emc6d102-sensors.patch
Type: text/x-diff
Size: 3048 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050320/f030a8a0/emc6d102-sensors.bin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: emc6d102-kernel.patch
Type: text/x-diff
Size: 8505 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050320/f030a8a0/emc6d102-kernel.bin
