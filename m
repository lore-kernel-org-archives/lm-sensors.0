From: paul.aviles@palei.com (Paul Aviles)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: gs10
Message-Id: <002601c4aa5f$db1380c0$6424050a@avilespaxp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041003231641.M43741@palei.com>
In-Reply-To: <20041003231641.M43741@palei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hmm.. getting this..

[root@srv1 chips]# patch -p0 < pc87360.c.diff
can't find file to patch at input line 8
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|Index: kernel/chips/pc87360.c
|=================================|RCS file: /home/cvs/lm_sensors2/kernel/chips/pc87360.c,v
|retrieving revision 1.40
|diff -u -r1.40 pc87360.c
|--- kernel/chips/pc87360.c     3 Jul 2004 15:50:27 -0000       1.40
|+++ kernel/chips/pc87360.c     4 Oct 2004 21:30:09 -0000
--------------------------
File to patch: pc87360.c
patching file pc87360.c
Hunk #1 succeeded at 77 (offset -1 lines).
Hunk #3 succeeded at 233 (offset -5 lines).
Hunk #4 succeeded at 460 (offset -11 lines).
Hunk #5 succeeded at 475 (offset -5 lines).
Hunk #6 succeeded at 481 (offset -11 lines).
Hunk #7 FAILED at 489.
Hunk #8 succeeded at 515 (offset -5 lines).
Hunk #9 FAILED at 535.
Hunk #10 succeeded at 540 (offset -17 lines).
Hunk #11 succeeded at 1256 (offset -58 lines).
2 out of 11 hunks FAILED -- saving rejects to file pc87360.c.rej
[root@srv1 chips]#


-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.
