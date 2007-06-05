From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 05 Jun 2007 18:51:48 +0000
Subject: Re: [lm-sensors] hwmon maintainer handoff
Message-Id: <20070605205148.091dca43@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070605122527.GD3273@jupiter.solarsys.private>
In-Reply-To: <20070605122527.GD3273@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Tue, 5 Jun 2007 08:25:27 -0400, Mark M. Hoffman wrote:
> I think my GIT trees are in order, finally.  How do you want to do this?

Ah, this is good news :)

> I see you still have a decent patch queue... are there any that you will send
> prior to 2.6.23?

No, everything which is in my queue right now is meant for 2.6.23-rc1.

> If not, I guess we could ask Andrew to start pulling from your queue *and*
> mine... eventually yours will get empty and he can drop it.  I would pull your
> queue into my release branch for Linus during the post-2.6.23 merge window.

This makes things unnecessarily complex for Andrew, given that my queue
is now read-only. I'd rather let you pick all "my" patches right now
and make them yours. Then I can just blast my own queue and be done
with it, and Andrew starts pulling from yours. Just give me one day to
sort everything out and make sure that everyone is properly credited.

> Also, I have a (more complete than yours) MAINTAINERS patch... I guess I should
> post it plain and let you pick it up to signal the handoff?  Or, I could push
> it to my testing branch for Andrew and let that be the signal.  Do you have a
> preference?

It's in my queue now, but it'll be up to you to send it upstream anyway.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
