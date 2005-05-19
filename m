From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [patch] gcc-3.2 problems: i2c local vs. kernel headers
Message-Id: <20030507101605.64831aec.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030319172417.GC14159@westend.com>
In-Reply-To: <20030319172417.GC14159@westend.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Please read this:
> 
> http://www.tldp.org/LDP/lfs/html/chapter06/kernel.html#AEN2385
> 
> Slackware and RedHat (glibc-kernheaders) are doing the right thing.
> 
> 
> When compiling a program, you want the system headers to match
> those which were used to compile your glibc, *not* the currently
> running kernel itself.  So, the RH package glibc-kernheaders
> installs the headers into /usr/include/{asm,linux} which were
> used to build glibc.

I find Linus' speech particularly unclear. He seems to keep the
"original" headers in /usr/src/linux, whereas we are discussing about
having them in /usr/include *instead* of having symlinks there, pointing
to *newer* headers at /usr/src/linux. I think I get the main idea though
(that is, one should use the original headers unless he/she is building
kernel modules.

> So after all that, here's a fix as diff from 2.7.0.  It produces the
> correct include order (first of 3 above).  This works fine with stock
> RedHat 9, keeping glibc-kernheaders intact.  I tested with RedHat 8.0
> too.
> 
> Jean, could you please test this with Slackware?  Any other comments
> before I check it in?

Sorry for the delay. I just tested your patch on Slackware (almost) 8.1
(with the symlinks trick) and 9.0 (with copied kernel headers). It works
well for both. Great job :)

It's unrelated with your patch, but I noticed new warnings, probably due
to the fact I'm using gcc 3.2.2.

lib/data.c: In function `sensors_parse_chip_name':
lib/data.c:117: warning: deprecated use of label at end of compound
statement
lib/data.c:151: warning: deprecated use of label at end of compound
statement

Should we fix them? I could take care of this.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
