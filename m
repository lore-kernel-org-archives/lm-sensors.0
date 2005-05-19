From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: Small fixes to sensord.8 and sensors.conf.5
Message-Id: <20040314182002.GA7183@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Please find attached two small patches against the current CVS to fix
some minor mistakes in manpages:
- sensord.8
  --rrd-cgi used instead of --rrd-file in an example
  
- sensors.conf.5
  This man page refers to itself in the SEE ALSO section

Cheers,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: prog/sensord/sensord.8
=================================RCS file: /home/cvs/lm_sensors2/prog/sensord/sensord.8,v
retrieving revision 1.7
diff -u -1 -b -p -r1.7 sensord.8
--- prog/sensord/sensord.8	23 Oct 2002 14:51:54 -0000	1.7
+++ prog/sensord/sensord.8	14 Mar 2004 16:42:01 -0000
@@ -305,3 +305,3 @@ sensord --log-interval 0 \\
   --load-average \\
-  --rrd-cgi /var/log/sensord.rrd
+  --rrd-file /var/log/sensord.rrd
 .fi
-------------- next part --------------
Index: lib/sensors.conf.5
=================================RCS file: /home/cvs/lm_sensors2/lib/sensors.conf.5,v
retrieving revision 1.2
diff -u -1 -b -p -r1.2 sensors.conf.5
--- lib/sensors.conf.5	24 Dec 1999 22:44:41 -0000	1.2
+++ lib/sensors.conf.5	14 Mar 2004 16:39:49 -0000
@@ -409,3 +409 @@ that one takes always precedence.
 lm_sensors-2.x
-.SH SEE ALSO
-sensors.conf(5)
