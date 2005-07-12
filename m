From: gregkh@suse.de (Greg KH)
Date: Tue, 12 Jul 2005 00:04:24 +0000
Subject: [lm-sensors] [PATCH] I2C: Documentation fix
Message-Id: <11211193783332@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11211193781619@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: jan@mind.be

[PATCH] I2C: Documentation fix

Fix documentation to match code in include/linux/i2c-dev.h

Signed-off-by: Jan Veldeman <jan@mind.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a68e2f4895070f3a449bfe5ae1174b73cc900642
tree 76f3e9e4da1f261687b51aad6c8be3534788e63f
parent 61f5809d3ebce9d5433b8696048e91405b681023
author Jan Veldeman <jan@mind.be> Fri, 01 Jul 2005 16:20:24 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 11 Jul 2005 14:10:37 -0700

 Documentation/i2c/dev-interface |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/i2c/dev-interface b/Documentation/i2c/dev-interface
--- a/Documentation/i2c/dev-interface
+++ b/Documentation/i2c/dev-interface
@@ -97,10 +97,10 @@ ioctl(file,I2C_PEC,long select)
 ioctl(file,I2C_FUNCS,unsigned long *funcs)
   Gets the adapter functionality and puts it in *funcs.
 
-ioctl(file,I2C_RDWR,struct i2c_ioctl_rdwr_data *msgset)
+ioctl(file,I2C_RDWR,struct i2c_rdwr_ioctl_data *msgset)
 
   Do combined read/write transaction without stop in between.
-  The argument is a pointer to a struct i2c_ioctl_rdwr_data {
+  The argument is a pointer to a struct i2c_rdwr_ioctl_data {
 
       struct i2c_msg *msgs;  /* ptr to array of simple messages */
       int nmsgs;             /* number of messages to exchange */

