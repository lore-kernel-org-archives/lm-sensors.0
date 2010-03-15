From: <samu.p.onkalo@nokia.com>
Date: Mon, 15 Mar 2010 06:53:21 +0000
Subject: Re: [lm-sensors] [PATCH V2 0/6] lis3lv02d: click and threshold
Message-Id: <62697B07E9803846BC582181BD6FB6B826A7E4B586@NOK-EUMSG-02.mgdnok.nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1266318571-31083-1-git-send-email-samu.p.onkalo@nokia.com>
 <4B92662A.4080604@tremplin-utc.net>
In-Reply-To: <4B92662A.4080604@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: akpm@osdl.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eric.Piel@tremplin-utc.net

>> Samu Onkalo (6):
>>   lis3: Add missing constants for 8bit device
>>   lis3: Separate configuration function for 8 bit device
>>   lis3: Introduce platform data for second ff / wu unit
>>   lis3: Add skeletons for interrupt handlers
>>   lis3: Interrupt handlers for 8bit wakeup and click events
>>   lis3: Setup poll interval limits
>(sorry for the delay, I was on holidays)
>
>Just had a look at the patches and they seem fine, so here is my
>Acked-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
>
>Andrew, would you mind to pick this series of patches to replace the
>dropped one yesterday?
>

Hi,

This patch set was meant to replace the dropped ones

http://www.spinics.net/lists/kernel/msg998876.html


-Samu


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
