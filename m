From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [PATCH] sensord: wrong error message with /proc or /sys not
Message-Id: <20050105220231.GD19356@bode.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050105212346.GA19356@bode.aurel32.lan>
In-Reply-To: <20050105212346.GA19356@bode.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 05, 2005 at 10:39:49PM +0100, Jean Delvare wrote:
> > BTW, on 2.6 kernels the sensors informations are in /sys and not
> > /proc. The message may be changed into:
> > 
> >   Error reading /proc or /sys; modules probably not loaded
> 
> True. I would certainly accept a patch that does this ;)
Attached. 

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: prog/sensord/lib.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensord/lib.c,v
retrieving revision 1.5
diff -u -1 -b -p -r1.5 lib.c
--- prog/sensord/lib.c	5 Jan 2005 21:44:57 -0000	1.5
+++ prog/sensord/lib.c	5 Jan 2005 22:10:15 -0000
@@ -82,3 +82,3 @@ loadConfig
         if (ret = -SENSORS_ERR_PROC)
-          sensorLog (LOG_ERR, "Error reading /proc; modules probably not loaded");
+          sensorLog (LOG_ERR, "Error reading /proc or /sys; modules probably not loaded");
         else
@@ -99,3 +99,3 @@ loadConfig
       if (ret = -SENSORS_ERR_PROC)
-        sensorLog (LOG_ERR, "Error reading /proc; modules probably not loaded");
+        sensorLog (LOG_ERR, "Error reading /proc or /sys; modules probably not loaded");
       else
