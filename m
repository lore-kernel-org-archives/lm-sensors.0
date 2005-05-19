From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: [PATCH 2.6] ADM1030 and Co sensors chips support for 2.6.7-mm1
Message-Id: <20040701023223.GC5247@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040622195209.77f852a6.alex@alexdalton.org>
In-Reply-To: <20040622195209.77f852a6.alex@alexdalton.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello:

> Quoting "Mark M. Hoffman" <mhoffman@lightlink.com>:
> > A recent driver core patch *necessitates* the trailing semicolon for
> > DEVICE_ATTR().

* Alexandre d'Alton <alex@alexdalton.org> [2004-06-30 09:33:01 +0200]:
> In fact, I already put the semicolons on the iner calls to DEVICE_ATTR(), but as
> when I "instanciate"
> the macros I put a semicolon, I thought that it was unnecessary on the last one.
> If you confirm that I have to add them, I'll be glad to do it.

No, you're right.  Sorry for the noise.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
