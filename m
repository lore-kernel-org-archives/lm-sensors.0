From: hidden@paradise.net.nz (Volker Kuhlmann)
Date: Tue, 20 Dec 2005 19:08:02 +0000
Subject: [lm-sensors] pwmconfig fails to find useful range
Message-Id: <20051220190802.GB7320@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The active range for the PWM values for an Athlon64 3200+ CPU fan is
<= 16, above that it's full speed. The gnuplot data from pwmconfig:

255 3125
...
30 3125
28 3068
26 3068
24 3068
22 3068
20 3068
18 3068
16 3068
14 3013
12 2960
10 2909
8 2909
6 2721
4 2518
2 2163
0 0

The BIOS defaults to 8, 12, and 80 for 3 different speed settings (none
quiet).

pwmconfig fails to find the useful range because the step size during
its tests is far too big, therefore apply the patch below.

I don't think fancontrol can really handle this either, the temp/speed
curve is far too steep. It assumes the active range goes up to 255. I'll
work on it later.

Now what would be really handy is some integrated
monitor/alarm/fancontrol/logging daemon...

Volker


--- /usr/sbin/pwmconfig.orig	2005-09-13 12:34:49.000000000 +1200
+++ /usr/sbin/pwmconfig	2005-12-20 23:47:34.000000000 +1300
@@ -188,7 +188,9 @@
 
 PLOTTER=gnuplot
 STEP
-PDELAY=2
+STEP2=2
+STEP2_BELOW1
+PDELAY=3
 
 function pwmdetail()
 {
@@ -256,6 +258,7 @@
 			fi
 			break
 		fi
+		test $pwm -lt $STEP2_BELOW && let STEP=$STEP2
 		let pwm=$pwm-$STEP
 	done
 	pwmdisable $P	

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.

