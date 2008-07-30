From: David Brownell <david-b@pacbell.net>
Date: Wed, 30 Jul 2008 07:17:24 +0000
Subject: Re: [lm-sensors] [RESEND x9+ patch 2.6.26-git 1/2] lm75: cleanup
Message-Id: <20080730071724.ACADB9D3EB@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200807251523.28242.david-b@pacbell.net>
 <20080729233231.0ced6d9b.akpm@linux-foundation.org>
In-Reply-To: <20080729233231.0ced6d9b.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: mhoffman@lightlink.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, khali@linux-fr.org, juergh@gmail.com

> > Minor cleanup and reorg of the lm75 code.
>
> This patch (and the other) have been in Mark's tree for a month or so. 
> (linux-next <- useful!)

Good to know -- thanks.  Nobody on the hwmon list seemed to know
the status when I asked, which is why I reposted.  (These have been
pending for quite a while...)


> Mark has been pretty, umm, low-key lately.  I've attached the full
> git-hwmon changelog below and the authors of all those changes are
> cc'ed.
>
> Could people please confirm that what is in linux-next is still the
> latest and greatest version of their changes?  If so, I shall plan on
> fishing those changes out of there and getting them into -rc2.

There's one more LM75 patch from Jean that's not there ...  but it
looks like those two got in just fine, so Jean's update should apply
just fine.

- Dave


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
