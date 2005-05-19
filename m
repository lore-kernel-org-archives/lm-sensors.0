From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Missing download
Message-Id: <20040510205756.750971c4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <opr7rnlmpsk46x2i@localhost>
In-Reply-To: <opr7rnlmpsk46x2i@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I need the lm_sensors-2.8.5 for my kernel-2.6.3.9mdk and cannot find
> it  anywhere.

http://secure.netroedge.com/~lm78/archive/lm_sensors-2.8.5.tar.gz

> Get no temp or volt reading.
> I see that " Modules will not compile on 2.5/2.6 kernels." This is
> with  later version of lm_sensors.

This is because these modules are already in the Linux tree. This
doesn't mean that lm_sensors won't work. Just do "make user && make
user_install" and it should be just fine.

-- 
Jean Delvare
http://khali.linux-fr.org/
