From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:36 +0000
Subject: [lm-sensors] [PATCH] I2C: fix typo in documentation
Message-Id: <1125956768434@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: fix typo in documentation

Fix a typo in the i2c documentation: the i2c bus scanning tool found in
lm_sensors is called i2cdetect, not i2c_detect.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 014e45380a3b96f2ebd8ff0d115b7a33c06d06d1
tree 3b9763099bb53f920ef492c931d2f660292106e0
parent 48edcb65ddcd93b6421831ad133599aacea9724a
author Jean Delvare <khali@linux-fr.org> Thu, 28 Jul 2005 23:08:43 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:16 -0700

 Documentation/i2c/functionality |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/i2c/functionality b/Documentation/i2c/functionality
--- a/Documentation/i2c/functionality
+++ b/Documentation/i2c/functionality
@@ -115,7 +115,7 @@ CHECKING THROUGH /DEV
 If you try to access an adapter from a userspace program, you will have
 to use the /dev interface. You will still have to check whether the
 functionality you need is supported, of course. This is done using
-the I2C_FUNCS ioctl. An example, adapted from the lm_sensors i2c_detect
+the I2C_FUNCS ioctl. An example, adapted from the lm_sensors i2cdetect
 program, is below:
 
   int file;

