From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 22 Oct 2010 20:08:16 +0000
Subject: Re: [lm-sensors] [PATCH 00/12] lis3 accelerator feature update
Message-Id: <1287778096.9690.401.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: "eric.piel@tremplin-utc.net" <eric.piel@tremplin-utc.net>, "khali@linux-fr.org" <khali@linux-fr.org>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, 2010-10-22 at 07:57 -0400, Samu Onkalo wrote:
> Changes are tested only with I2C interface using 8bit sensor since I don't
> have other possibilities. Some features are not enabled
> by default since I can't test them with all possible configurations.
> Platform data contains field which controls new features.
> 
[ ... ]
> 
> Samu Onkalo (12):
>   hwmon: lis3: pm_runtime support
>   hwmon: lis3: regulator control
>   hwmon: lis3: Cleanup interrupt handling
>   hwmon: lis3: Update coordinates at polled device open
>   hwmon: lis3: Power on corrections
>   hwmon: lis3: restore axis enabled bits
>   hwmon: lis3: New parameters to platform data
>   hwmon: lis3: Adjust fuzziness for 8 bit device
>   hwmon: lis3: use block read to access data registers
>   hwmon: lis3: Enhance lis3 selftest with IRQ line test
>   hwmon: lis3: Short explanations of platform data fields
>   hwmon: lis3: Release resources is case of failure
> 
>  drivers/hwmon/lis3lv02d.c     |  304 ++++++++++++++++++++++++++++++++++------
>  drivers/hwmon/lis3lv02d.h     |   18 +++
>  drivers/hwmon/lis3lv02d_i2c.c |  127 +++++++++++++++--
>  drivers/hwmon/lis3lv02d_spi.c |    2 +-
>  include/linux/lis3lv02d.h     |   50 +++++++-
>  5 files changed, 439 insertions(+), 62 deletions(-)
> 
Eric, can you Ack this series ?

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
