From: Daniel Mack <daniel@caiaq.de>
Date: Fri, 05 Feb 2010 02:12:18 +0000
Subject: Re: [lm-sensors] [PATCH 0/6] lis3lv02d: Power management,
Message-Id: <20100205021217.GL28972@buzzloop.caiaq.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1265271848-26559-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1265271848-26559-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: eric.piel@tremplin-utc.net, pavel@ucw.cz, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Thu, Feb 04, 2010 at 10:24:02AM +0200, Samu Onkalo wrote:
> Lis3 accelerometer chip family changes for power management,
> click and threshold event handling.
> 
> Patch set adds interrupt handlers for click/tap events and threshold
> based events. Actual configuration which events are enabled
> is done via platform data. All the features cannot be used in parallel.
> Interrupts are implemented only for 8 bit device, since I'm not familiar
> with other devices and I don't have suitable testing environment.

I'll give these patches a test on my boards next week and get back to
you.

Thanks,
Daniel


> Changes:
> 
>   lis3: Add missing constants for 8bit device
> This is quite clear. Some click feature related register definitions
> were missing.
> 
>   lis3: Separate configuration function for 8 bit device
> Move platformdata based configurations for 8 bit device to
> separate function to keep common part little bit more readable.
> 
>   lis3: Introduce platform data for second ff / wu unit
> 8 bit device has two freefall / wakeup detection blocks. Add possibility
> to configure also the second unit. Change hipass filter configuration
> to platform data. Change is compatible with existing platform data.
> 
>   lis3: Power control for the chip
> This kind of feature has been in the driver earlier. It was removed
> because saving was so small in laptop environment. However, in smaller
> devices, even a small saving need to be implemented. When driver detects
> that no-one is really interested about the acceleration, chip is powered down.
> Input device, freefall device and sysfs are controlling this. By default,
> chip is powered on to keep functionality similar to current implementation.
> 
>   lis3: Add skeletons for interrupt handlers
> Interrupt handlers are added in two patches to keep changes cleaner.
> This first patch adds two dummy threaded interrupt handlers for 8 bit device. 
> 
>   lis3: Interrupt handlers for 8bit wakeup and click events
> This patch adds content to dummy handlers. Depending on the chip configuration,
> either click or ff/wu handling is called. For click event, BTN input event is
> sent separately for each axes. For threshold event, coordinates are updated
> immediatelly to input device. This allows input device to be used either in
> polled mode and / or interrupt driven mode. Polling can stopped from userspace
> by via input device sysfs.
> 
> Patch set applies to 2.6.33-RC6 tree.
> Tested with 2.6.32 environment for omap3
> 
> Samu Onkalo (6):
>   lis3: Add missing constants for 8bit device
>   lis3: Separate configuration function for 8 bit device
>   lis3: Introduce platform data for second ff / wu unit
>   lis3: Power control for the chip
>   lis3: Add skeletons for interrupt handlers
>   lis3: Interrupt handlers for 8bit wakeup and click events
> 
>  drivers/hwmon/lis3lv02d.c     |  308 +++++++++++++++++++++++++++++++++--------
>  drivers/hwmon/lis3lv02d.h     |   12 ++
>  drivers/hwmon/lis3lv02d_i2c.c |    8 +-
>  drivers/hwmon/lis3lv02d_spi.c |   12 +-
>  include/linux/lis3lv02d.h     |   12 ++
>  5 files changed, 287 insertions(+), 65 deletions(-)
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
