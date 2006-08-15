From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 15 Aug 2006 08:39:35 +0000
Subject: [lm-sensors] [PATCH] Update lm_sensors to handle more of the
Message-Id: <20060815103935.4f34fc11.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80608030056t16679db3ub2bc7fa0efa59ed1@mail.gmail.com>
In-Reply-To: <5bfe43f80608030056t16679db3ub2bc7fa0efa59ed1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles,

> I wrote an ugly little python script to cause each alarm to trigger
> one at a time (I can provide it if anyone is interested). Based on the
> script, what I found was that the documentation was completely correct
> for the values I tested (in0-9, temp1-3, fan1-5). My board doesn't
> have the pwm stuff and the driver doesn't have that support, so I
> didn't validate the tart1-3 alarms/enables, but since everything else
> was correct, it seems likely those are as well.
> 
> Sven - Can you confirm this result?

Maybe you can share your script with Sven so that he can test quickly.
A confirmation would indeed be welcome, as I know there are different
revisions of the W83791D chip.

> Based on this result and the comment earlier that the driver should do
> a pass through of the values, I will create a documentation only
> change for the 2.6 driver and clean up the lm_sensors patch that
> started this thread.
> 
> Does this sound reasonable?

Yes, sounds like a good plan to me. I'm waiting for your patches :)

-- 
Jean Delvare

