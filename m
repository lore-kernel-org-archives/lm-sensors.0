From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 22 Sep 2006 22:25:15 +0000
Subject: [lm-sensors] [patch] hwmon: w83781d - check return code of
Message-Id: <451462CB.3080201@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F70D89.30409@gmail.com>
In-Reply-To: <44F70D89.30409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Add 2 attr-file groups (for base and model-specific attrs respectively),
create the base group with single call to sysfs_create_group, and
check the return code on individual calls to device_create_file for each
of the model-specific attr-files.

Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>

---

all suggestions incorporated.

[jimc at harpo hwmon-stuff]$ diffstat hwmon-unchecked-return-status-fixes-w83781d.patch

 w83781d.c |  265 
++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 141 insertions(+), 124 deletions(-)


-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-unchecked-return-status-fixes-w83781d.patch
Type: text/x-patch
Size: 14593 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060922/9f119b79/attachment.bin 
