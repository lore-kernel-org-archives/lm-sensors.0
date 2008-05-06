From: Romain Dolbeau <romain.dolbeau@caps-entreprise.com>
Date: Tue, 06 May 2008 13:06:10 +0000
Subject: Re: [lm-sensors] sensors.conf for the Supermicro X7DBE
Message-Id: <482057C2.7070309@caps-entreprise.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <481195AE.3070104@dolbeau.org>
In-Reply-To: <481195AE.3070104@dolbeau.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

> Given that the w83793 driver doesn't exist for Linux 2.4, I guess you
> really mean "as of linux 2.6.21"?

Yes, sorry for the typo. I've done those files a while ago and didn't
check them again before posting, sorry.

> That's a bit surprising though, as
> this driver didn't change in kernel 2.6.21 as far as I can see.

Bad wording ; my meaning was it had the problem in the kernel I was
using at the time, 2.6.21, had the problem. But the next quote solve the
real problem.

> Old
> versions of "sensors" didn't expect this, it was fixed in lm-sensors
> 2.10.2.

... and guess what? Debian-stable includes 2.10.1 ... So I guess that is
the problem, my config file should be updated to mention the fact in the
wiki (which is still uneditable, not even the sandbox... anyway to get
access to the motherboard/supermicro stuff so I can update them myself ?)

-- 
Romain Dolbeau
<romain.dolbeau@caps-entreprise.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
