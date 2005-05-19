From: gene_heskett@iolinc.net (Gene Heskett)
Date: Thu, 19 May 2005 06:23:38 +0000
Subject: gcc3.2
Message-Id: <3D6E55B0.5010501@iolinc.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Gentlemen;

I was in the process of converting my lm_sensors-2.6.4 tree to use the 
gcc3.2 versions of stddefs.h and stdarg.h when I ran into a brand new 
problem that started with the final release of kernel 2.4.19.

It seems that cpufreq.ver was removed from this release, and possibly 
all newer ones, causeing the make to exit when it can't find it.

2.4.19 built just fine with gcc3.2, and thats what I'm running.

I've never been able to get lm_sensors to run on this mobo, which has 
the Winbond 83791 (IIRC) on it.  Is it about ready, or do I have a mobo 
thatwill probably never be supported?

-- 
Cheers, Gene
gene_heskett AT iolinc DOT net
