From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 25 Sep 2006 17:05:04 +0000
Subject: [lm-sensors] [patch] hwmon:  fix unchecked returncodes in w83791d
Message-Id: <45180C40.7090809@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix unchecked return-status by replacing all unchecked calls 
to device_create_file with a single group declaration,
and one call to sysfs_create_group, and check that one return status.

Signed-off-by:  Jim Cromie  <jim.cromie at gmail.com>
---
$ diffstat pc-set/hwmon-unchecked-return-status-fixes-w83791d.patch
 w83791d.c |   83 +++++++++++++++++++++++++++++++++++++++++---------------------
 1 files changed, 55 insertions(+), 28 deletions(-)

---

Its impressive (or embarrassing) how much slop you detect.
I trust this comment is in right place for auto-strip to 
keep it out of Changelog.  Is any of this automated, and if so,
are we/I getting it right (or close) ?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: hwmon-unchecked-return-status-fixes-w83791d.patch
Type: text/x-patch
Size: 3292 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060925/26f34a04/attachment.bin 
