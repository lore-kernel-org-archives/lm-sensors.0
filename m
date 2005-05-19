From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: [PATCH 2.6] Fix w83781d temp
Message-Id: <1074073813.400510d5aba91@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040110140700.5b5ab705.khali@linux-fr.org>
In-Reply-To: <20040110140700.5b5ab705.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > This applies on top of the patches stack. In particular, the
> > asb100 patch needs to be applied before this one so that lm75.h is
> > present.
> 
> Actually, it only requires an earlier patch...
> http://archives.andrew.net.au/lm-sensors/msg05580.html

You're perfectly right. I don't know why I though that the lm75.h
addition was part of the asb100 patch. It wouldn't have fit well in the
"one patch, one thing" philosphy we try to stick too.

So I'm sorry for the trouble, the "w83781d temp" patch doesn't require
the "asb100" at all, only the "lm75.h" patch, and since that one is
already in Linux 2.6.1, it doesn't require anything at all.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
