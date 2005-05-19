From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Ticket 1564 (Can't access /proc file for writing); strace
Message-Id: <20040205191413.25b9bf20.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040205141827.GA3115@raw-sewage.net>
In-Reply-To: <20040205141827.GA3115@raw-sewage.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> No problem!  I thought that trace I sent before looked awfully similar
> to the one on the link. :)
> 
> Anyway, here it is with debugging enabled.  Please let me know if you
> need any more information!
> (...)
> getuid32()                              = 0
> geteuid32()                             = 0
> getgid32()                              = 0
> getegid32()                             = 0

This is the trap. I was expecting to see some non-zero value here (i.e.
not root, which would explain why the access is denied). This is not the
case. So whatever the problem is, it's not there.

One common point of all people reporting the problem is that they are
running either Debian or Gentoo. Both distributions are rather similar,
I think. And both come with heavily patched kernels.

Could you compile a kernel by yourself (vanilla sources + i2c patch from
http://delvare.nerim.net/i2c/) and see if the problem disappears? I
suspect that the Gentoo kernel includes additional security checks in
the kernel code, which would explain why the error only shows there.

I don't blame them for patching their kernel. If this catch some error
in our code, we want to fix it. But I admit I just don't know where to
look for it.

If a non-gentoo kernel on the same system make "sensors -s" work, I'll
start checking which patch Gentoo does include that could reveal the
problem. Maybe it'll give us an idea of where to look at.

Thanks for your assistance, sorry that I can't help you much at the
moment.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
