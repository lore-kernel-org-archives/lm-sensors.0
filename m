From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: [PATCH 2.6] New chip driver: pcf8591
Message-Id: <20040409230603.3c6e4389.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040328160717.GA32728@pc.aurel32.private>
In-Reply-To: <20040328160717.GA32728@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > BTW, wouldn't a "else return -1" make sense here? Silently ignoring
> > errors doesn't sound good to me.
> 
> Well make it a real error, like -EINVAL or something, so userspace has
> a chance to report it properly.  Not just -1.

Oh, I guess we want to correct it87.c and fscher.c in that way too then.

I had this to my todo list.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
