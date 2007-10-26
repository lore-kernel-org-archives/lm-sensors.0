From: Riku Voipio <riku.voipio@iki.fi>
Date: Fri, 26 Oct 2007 22:35:28 +0000
Subject: Re: [lm-sensors] hwmon/f75375s.c: buggy if()
Message-Id: <20071026223527.GA5787@kos.to>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071017195439.GD3778@stusta.de>
In-Reply-To: <20071017195439.GD3778@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Oct 26, 2007 at 11:15:55PM +0200, Jean Delvare wrote:
> > The surrounding code had wandered to another function, so it's suprising
> > it applied at all. Here's respin.

> Patch looks OK, thanks.

> Acked-by: Jean Delvare <khali@linux-fr.org>

> Riku, I have 14 patches posted to the lm-sensors list pending for
> review. Would you mind reviewing one of them? Thanks.

Sure. I reviewed just a obvious one. I'll look at reviewing something
more complicated on monday. Apart from the fintek, I have currently it87
and k8temp sensors to test, so any patches agains against those would
be preferred.

-- 
"rm -rf" only sounds scary if you don't have backups

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
