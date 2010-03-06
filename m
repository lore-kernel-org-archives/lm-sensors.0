From: =?UTF-8?B?w4lyaWMgUGllbA==?= <Eric.Piel@tremplin-utc.net>
Date: Sat, 06 Mar 2010 14:26:50 +0000
Subject: Re: [lm-sensors] [PATCH V2 0/6] lis3lv02d: click and threshold
Message-Id: <4B92662A.4080604@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1266318571-31083-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1266318571-31083-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Samu Onkalo <samu.p.onkalo@nokia.com>, Andrew Morton <akpm@osdl.org>
Cc: pavel@ucw.cz, daniel@caiaq.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Op 16-02-10 12:09, Samu Onkalo schreef:
> This patch set replaces my previous one.
> (see http://www.spinics.net/lists/kernel/msg994446.html)
> 
> Power control of the chip is dropped out since it requires more work.
> Runtime-pm support was requested and that takes some time to implement
> and test. I'll send it as a separate patch.
> 
> patches 1 - 3 are not touched compared to patch set 1 and they
> are marked as tested-by Daniel Mack <daniel@caiaq.de> and
> acked-by Éric Piel <eric.piel@tremplin-utc.net>.
> Patch 4 is marked as tested-by Daniel Mack <daniel@caiaq.de>.
> 
:
> 
> Samu Onkalo (6):
>   lis3: Add missing constants for 8bit device
>   lis3: Separate configuration function for 8 bit device
>   lis3: Introduce platform data for second ff / wu unit
>   lis3: Add skeletons for interrupt handlers
>   lis3: Interrupt handlers for 8bit wakeup and click events
>   lis3: Setup poll interval limits
(sorry for the delay, I was on holidays)

Just had a look at the patches and they seem fine, so here is my
Acked-by: Éric Piel <eric.piel@tremplin-utc.net>

Andrew, would you mind to pick this series of patches to replace the
dropped one yesterday?

Thanks,
Eric

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
