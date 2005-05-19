From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: bus scan removal
Message-Id: <20031223225845.12669963.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031221100543.28eaf2ff.khali@linux-fr.org>
In-Reply-To: <20031221100543.28eaf2ff.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> For systems that have a 64bit kernel, and a 32bit userspace, all
> ioctls in the kernel need a "thunking" layer in order to pass the data
> between the kernel and userspace properly.  Last I looked that layer
> did not contain any i2c ioctls, so i2c-dev will not work on those
> kinds of systems (ppc64, sparc64, mips64, amd64, ia64, etc...)

Take a look at 2.6.0-mm1's changelog. Didn't look at the code but it
looks like someone just implemented this. Greg, do you confirm it's the
same as what you're talking about?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
