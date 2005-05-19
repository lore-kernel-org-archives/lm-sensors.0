From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: [PATCH] sensors-detect and udev
Message-Id: <20040811191015.GA12506@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040810225714.GA2700@pc.aurel32.lan>
In-Reply-To: <20040810225714.GA2700@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-08-11 20:36:51 +0200]:
> Please use "&&" instead of "and". Also notice that !(A && B) is more
> efficient than (!A) && (!B), but I admit I am splitting hairs here ;)

I hope you meant !(A||B), or you better re-read DeMorgan. ;)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
