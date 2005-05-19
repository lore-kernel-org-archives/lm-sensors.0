From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: Get in sync sensord.8 with sensord
Message-Id: <20050111225424.GA17553@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Since version 2.9.0, the loadavg in sensord is not scaled anymore. The
manpage has not been modified in consequence, so please find below a
patch to do that.

Bye,
Aurelien

Index: prog/sensord/sensord.8
=================================RCS file: /home/cvs/lm_sensors2/prog/sensord/sensord.8,v
retrieving revision 1.10
diff -u -1 -b -p -r1.10 sensord.8
--- prog/sensord/sensord.8      24 Jul 2004 18:58:56 -0000      1.10
+++ prog/sensord/sensord.8      11 Jan 2005 22:59:36 -0000
@@ -121,3 +121,3 @@ below for more details.
 .IP "-a, --load-average"
-Include the load average (multiplied by 10) in the RRD database. You should
+Include the load average in the RRD database. You should
 also specify this flag when you create the CGI script.
 

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
