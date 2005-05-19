From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: Error loading lm93
Message-Id: <20050106222506.GC5303@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <41DDA457.3040502@earthlink.net>
In-Reply-To: <41DDA457.3040502@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again:

* Jean Delvare <khali@linux-fr.org> [2005-01-06 22:36:14 +0100]:
> Basically, the issue is caused by Mark Hoffman's drivers (asb100, lm93
> in your case) returning an error (-ENODEV) on misdetection, while the
> i2c core doesn't expect them. As a result, the core stops probing
> greater addresses. In your case, the LM87 has the lowest address, so it
> is scanned before the LM93. If the lm87 driver is loaded first, the low
> address is marked busy and not probed the lm93 driver. However, if the
> lm87 driver is not loaded, then the first address probed by the lm93
> driver is the LM87's one, not the LM93's one, causing the bug to
> trigger.
> 
> It can be discussed whether it is wise that the core interprets returned
> values that way, but as a matter of fact, all other drivers work that
> way. I personally think that this behavior shouldn't be changed in 2.4,
> but it could be in 2.6.

Agreed all around.  Remember I claimed I would rewrite i2c_detect for 2.6.
I have studied it some, but there's no code yet.  I've been really tight
on time lately.  It will be unfortunate to have 2.6 and 2.4 be subtly
different in this respect, but I think it's the right thing to do.

> The attached patch should solve the problem, but I'd like to hear Mark
> Hoffman about this before I apply it. The asb100 driver would need a
> similar patch.

Again, agreed.  Likely also lm78 and w83xxx...

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
