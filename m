From: <samu.p.onkalo@nokia.com>
Date: Thu, 25 Feb 2010 07:26:13 +0000
Subject: Re: [lm-sensors] [PATCH V2 0/6] lis3lv02d: click and threshold
Message-Id: <62697B07E9803846BC582181BD6FB6B8266706E432@NOK-EUMSG-02.mgdnok.nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1266318571-31083-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1266318571-31083-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: eric.piel@tremplin-utc.net
Cc: pavel@ucw.cz, daniel@caiaq.de, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org


Hi

>-----Original Message-----
>From: Onkalo Samu.P (Nokia-D/Tampere)
>Sent: 16 February, 2010 13:09
>To: eric.piel@tremplin-utc.net
>Cc: pavel@ucw.cz; daniel@caiaq.de; lm-sensors@lm-sensors.org; linux-
>kernel@vger.kernel.org; Onkalo Samu.P (Nokia-D/Tampere)
>Subject: [PATCH V2 0/6] lis3lv02d: click and threshold interrupts
>
>This patch set replaces my previous one.
>(see http://www.spinics.net/lists/kernel/msg994446.html)
>
>Power control of the chip is dropped out since it requires more work.
>Runtime-pm support was requested and that takes some time to implement
>and test. I'll send it as a separate patch.
>
>patches 1 - 3 are not touched compared to patch set 1 and they
>are marked as tested-by Daniel Mack <daniel@caiaq.de> and
>acked-by =C9ric Piel <eric.piel@tremplin-utc.net>.
>Patch 4 is marked as tested-by Daniel Mack <daniel@caiaq.de>.
>
>  lis3: Add skeletons for interrupt handlers
>No functional changes. Changed due to rebasing and power control
>removal.
>
>  lis3: Interrupt handlers for 8bit wakeup and click events
>As requested, BTN_ events are enabled only for 8 bit device and
>when click event is configured to the HW.
>Remapping of the BTN_ axis done according to platform data.
>
>  lis3: Setup poll interval limits
>Poll interval can now be set from 1 - 2000 ms and also to stopped state
>via input-dev sysfs.
>
>Tested in 2.6.32 based environment. Applies to 2.6.33-RC8
>
>
>Samu Onkalo (6):
>  lis3: Add missing constants for 8bit device
>  lis3: Separate configuration function for 8 bit device
>  lis3: Introduce platform data for second ff / wu unit
>  lis3: Add skeletons for interrupt handlers
>  lis3: Interrupt handlers for 8bit wakeup and click events
>  lis3: Setup poll interval limits
>
> drivers/hwmon/lis3lv02d.c |  245 +++++++++++++++++++++++++++++++++++---
>-------
> drivers/hwmon/lis3lv02d.h |   11 ++
> include/linux/lis3lv02d.h |   12 ++
> 3 files changed, 213 insertions(+), 55 deletions(-)

Any comments to these ones?

One thing which I just noticed. Now interrupts are configured all the time
so even if there is no device file open, interrupts are handled by the CPU.
However, there should not be that much interrupts that it causes problems.
This would be corrected by the power management patch (which I dropped),=20
but is not using runtime PM feature. I'm not sure if I have possibility to
implement and test runtime PM version in our environment.

-Samu





_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
