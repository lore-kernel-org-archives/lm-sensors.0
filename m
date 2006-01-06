From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:38 +0000
Subject: [lm-sensors] [PATCH] i2c: update i2c_driver.command documentation
Message-Id: <1136585258722@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: update i2c_driver.command documentation

Document i2c_driver.command as being deprecated, and don't suggest an
empty implementation of this callback as it doesn't make any sense.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit fb687d73fa7685ffeed1a6b24fadb5f4db817783
tree 2e45a80aca89daa28ba27092175d860252a905f8
parent d564baee2984098c73fd0e55bc5c8a890878ef3b
author Jean Delvare <khali at linux-fr.org> Sun, 18 Dec 2005 16:51:55 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:26 -0800

 Documentation/i2c/writing-clients |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
index 27c425a..3a057c8 100644
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -492,17 +492,13 @@ Note that some functions are marked by `
 by `__init_data'.  Hose functions and structures can be removed after
 kernel booting (or module loading) is completed.
 
+
 Command function
 ========
 
 A generic ioctl-like function call back is supported. You will seldom
-need this. You may even set it to NULL.
-
-  /* No commands defined */
-  int foo_command(struct i2c_client *client, unsigned int cmd, void *arg)
-  {
-    return 0;
-  }
+need this, and its use is deprecated anyway, so newer design should not
+use it. Set it to NULL.
 
 
 Sending and receiving


