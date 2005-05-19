From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: Bug in (2.6) chips/w83781d.c
Message-Id: <1069056813.3fb8832d83cb7@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Greg,

Don't apply the latest patch I sent to you. The bug I thought I fixed in
chips/w83781d.c is only half-fixed and that makes thing worse than
before. Basically there are two variable names swapped (hyst and over
temp limits), which is a bad idea but doesn't hurt from a user's point
of view. I unswapped them in one place but not everywhere, so with my
patch the user will of course see a problem.

I'll send a better (that is, non-breaking) patch as soon as possible.
Sorry for the trouble.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
