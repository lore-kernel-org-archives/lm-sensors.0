From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 11 Feb 2008 12:04:10 +0000
Subject: [lm-sensors] PATCH: make lm_sensors init script return values LSB
Message-Id: <47B039BA.8020707@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030408040402080402030500"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030408040402080402030500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I've received the attached patch through Fedora's bugzilla. It fixes the return 
values of the various error exit cases to match the LSB spec:
http://refspecs.linux-foundation.org/LSB_3.2.0/LSB-Core-generic/LSB-Core-generic/iniscrptact.html

It looks sane to me, if there are no objections I'll commit it to svn.

Thanks & Regards,

Hans


--------------030408040402080402030500
Content-Type: text/x-patch;
 name="lm_sensors-lsb-retcode.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lm_sensors-lsb-retcode.diff"

--- lm_sensors.orig	2008-02-07 11:37:22.000000000 -0500
+++ lm_sensors	2008-02-07 11:41:04.000000000 -0500
@@ -40,15 +40,15 @@
 
 	# Don't bother if /proc/sensors still doesn't exist, kernel doesn't have
 	# support for sensors.
-	[ -e /proc/sys/dev/sensors ] || exit 0
+	[ -e /proc/sys/dev/sensors ] || exit 6
 
 	# If sensors was not already running, unload the module...
 	[ -e /var/lock/subsys/lm_sensors ] || /sbin/modprobe -r i2c-proc >/dev/null 2>&1
 fi
 
 CONFIG=/etc/sysconfig/lm_sensors
-[ -r "$CONFIG" ] || exit 0
-grep '^MODULE_' $CONFIG >/dev/null 2>&1 || exit 0
+[ -r "$CONFIG" ] || exit 6
+grep '^MODULE_' $CONFIG >/dev/null 2>&1 || exit 6
 
 # Load config file
 . "$CONFIG"
@@ -147,7 +147,7 @@
 	;;
   *)
 	echo "Usage: $0 {start|stop|status|restart|reload|condrestart}"
-	exit 1
+	exit 3
 esac
 
 exit $RETVAL

--------------030408040402080402030500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030408040402080402030500--
