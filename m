From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 28 May 2006 14:12:57 +0000
Subject: [lm-sensors] set lines in sensors.conf.eg
Message-Id: <20060528161257.631638d9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060511163115.7ca1d6a5.khali@linux-fr.org>
In-Reply-To: <20060511163115.7ca1d6a5.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Thus I am proposing that we comment out all "set" lines in
> > sensors.conf.eg. What do others think?
> 
> That sounds like a sane solution to me.

OK, I've done that. The only exception is when the chip monitors its
own supply voltage, we know for sure that it is present so we can leave
the set statements related to this. I did this for the pc87366 and
f71805f entries because I'm familiar with these. It probably applies to
a few other chips, patches restoring set statements for these are
welcome.

-- 
Jean Delvare

