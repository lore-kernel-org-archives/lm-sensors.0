From: deant@hawaii.rr.com (Dean Takemori)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: sensors cgi patch  (Refresh the graph pages every 5 min)
Message-Id: <02F2CB78-8421-11D8-B5E0-000A95AF6760@hawaii.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Index: prog/rrd/sens_day.in
=================================RCS file: /home/cvs/lm_sensors2/prog/rrd/sens_day.in,v
retrieving revision 1.3
diff -u -2 -r1.3 sens_day.in
--- prog/rrd/sens_day.in        11 Aug 2003 08:47:15 -0000      1.3
+++ prog/rrd/sens_day.in        1 Apr 2004 21:08:24 -0000
@@ -4,4 +4,5 @@
  <HEAD>
  <TITLE>One Day Hardware Statistics for %%MACH%%</TITLE>
+<DEFANGED_meta http-equiv=refresh content='300'; url='sens_daily.cgi'>
  </HEAD>
  <BODY>
Index: prog/rrd/sens_week.in
=================================RCS file: /home/cvs/lm_sensors2/prog/rrd/sens_week.in,v
retrieving revision 1.3
diff -u -2 -r1.3 sens_week.in
--- prog/rrd/sens_week.in       11 Aug 2003 08:47:15 -0000      1.3
+++ prog/rrd/sens_week.in       1 Apr 2004 21:08:25 -0000
@@ -4,4 +4,5 @@
  <HEAD>
  <TITLE>One Week Hardware Statistics for %%MACH%%</TITLE>
+<DEFANGED_meta http-equiv=refresh content='300'; url='sens_week.cgi'>
  </HEAD>
  <BODY>
Index: prog/rrd/summ_week.in
=================================RCS file: /home/cvs/lm_sensors2/prog/rrd/summ_week.in,v
retrieving revision 1.3
diff -u -2 -r1.3 summ_week.in
--- prog/rrd/summ_week.in       11 Aug 2003 08:47:15 -0000      1.3
+++ prog/rrd/summ_week.in       1 Apr 2004 21:08:25 -0000
@@ -4,4 +4,5 @@
  <HEAD>
  <TITLE>One Week Summary Hardware Statistics for %%MACH%%</TITLE>
+<DEFANGED_meta http-equiv=refresh content='300'; url='summweek.cgi'>
  </HEAD>
  <BODY>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: text/enriched
Size: 1632 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040401/9880d359/attachment.bin
