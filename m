From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH] I2C fixes for 2.6.10-rc1
Message-Id: <11003020054093@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20041112232604.GA17203@kroah.com>
References: <11003020053782@kroah.com>
In-Reply-To: <11003020053782@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.2093, 2004/11/12 11:39:51-08:00, greg@kroah.com

I2C: fix up some out of date Documentation

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/i2c/dev-interface |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/Documentation/i2c/dev-interface b/Documentation/i2c/dev-interface
--- a/Documentation/i2c/dev-interface	2004-11-12 15:22:53 -08:00
+++ b/Documentation/i2c/dev-interface	2004-11-12 15:22:53 -08:00
@@ -3,7 +3,7 @@
 the /dev interface. You need to load module i2c-dev for this.
 
 Each registered i2c adapter gets a number, counting from 0. You can
-examine /proc/bus/i2c to see what number corresponds to which adapter.
+examine /sys/class/i2c-dev/ to see what number corresponds to which adapter.
 I2C device files are character device files with major device number 89
 and a minor device number corresponding to the number assigned as 
 explained above. They should be called "i2c-%d" (i2c-0, i2c-1, ..., 
@@ -19,7 +19,7 @@
 knows about i2c, there is not much choice.
 
 Now, you have to decide which adapter you want to access. You should
-inspect /proc/bus/i2c to decide this. Adapter numbers are assigned
+inspect /sys/class/i2c-dev/ to decide this. Adapter numbers are assigned
 somewhat dynamically, so you can not even assume /dev/i2c-0 is the
 first adapter.
 

