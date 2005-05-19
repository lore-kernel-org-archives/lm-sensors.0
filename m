From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH] Dead link in the FAQ
Message-Id: <20040320181110.GC20666@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

There is a dead link in the FAQ:
http://ultimatepc.fsn.net/techinfo/p2bthermistor/p2bthermistor.htm

I have tried to find if the site has moved to a new location, but I
haven't find any trace of it. That's why I propose to remove it. 

The attached patch against the current does that.

Cheers,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: doc/FAQ
=================================RCS file: /home/cvs/lm_sensors2/doc/FAQ,v
retrieving revision 1.41
diff -u -1 -b -p -r1.41 FAQ
--- doc/FAQ	18 Jan 2004 18:06:43 -0000	1.41
+++ doc/FAQ	20 Mar 2004 18:04:31 -0000
@@ -624,6 +624,2 @@ connected to the chip resulting in these
 
-   If you have an Asus P2B and want more information on adding thermal
-sensing capability, check out:
-`http://ultimatepc.fsn.net/techinfo/p2bthermistor/p2bthermistor.htm'
-
    In upcoming versions, you will be able to disable non-interesting
Index: doc/lm_sensors-FAQ.html
=================================RCS file: /home/cvs/lm_sensors2/doc/lm_sensors-FAQ.html,v
retrieving revision 1.10
diff -u -1 -b -p -r1.10 lm_sensors-FAQ.html
--- doc/lm_sensors-FAQ.html	18 Jan 2004 18:26:19 -0000	1.10
+++ doc/lm_sensors-FAQ.html	20 Mar 2004 18:04:31 -0000
@@ -941,5 +941,2 @@ to the chip resulting in these strange -
 
-   <p>If you have an Asus P2B and want more information on adding thermal sensing capability, check out:
-<a href="http://ultimatepc.fsn.net/techinfo/p2bthermistor/p2bthermistor.htm">http://ultimatepc.fsn.net/techinfo/p2bthermistor/p2bthermistor.htm</a>
-
    <p>In upcoming versions, you will be able to disable non-interesting
Index: doc/lm_sensors-FAQ.texi
=================================RCS file: /home/cvs/lm_sensors2/doc/lm_sensors-FAQ.texi,v
retrieving revision 1.9
diff -u -1 -b -p -r1.9 lm_sensors-FAQ.texi
--- doc/lm_sensors-FAQ.texi	18 Jan 2004 18:06:43 -0000	1.9
+++ doc/lm_sensors-FAQ.texi	20 Mar 2004 18:04:31 -0000
@@ -619,5 +619,2 @@ to the chip resulting in these strange -
 
-If you have an Asus P2B and want more information on adding thermal sensing capability, check out:
-@uref{http://ultimatepc.fsn.net/techinfo/p2bthermistor/p2bthermistor.htm}
-
 In upcoming versions, you will be able to disable non-interesting
