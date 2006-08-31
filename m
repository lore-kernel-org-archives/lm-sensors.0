From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 31 Aug 2006 16:25:45 +0000
Subject: [lm-sensors] [patch] hwmon: w83781d - check return code of
Message-Id: <44F70D89.30409@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


add 2 attr-file groups (for base and model-specific attrs respectively),
create the base group with single call to sysfs_create_group,
check the return code on individual calls to device_create_file for each
of the model-specific attr-files.

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>

This is compile-tested only, needs validation on hardware, or
very thorough inspection.

$ diffstat diff.w83781d-checkrc.txt
 w83781d.c |  192 
++++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 119 insertions(+), 73 deletions(-)


-------------- next part --------------
A non-text attachment was scrubbed...
Name: diff.w83781d-checkrc.txt
Type: plain/text
Size: 10002 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060831/1f312e73/attachment.bin 
