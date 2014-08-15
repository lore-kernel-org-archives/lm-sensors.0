From: Clemens Ladisch <clemens@ladisch.de>
Date: Fri, 15 Aug 2014 06:35:16 +0000
Subject: Re: [lm-sensors] [PATCH V3] hwmon, k10temp: Add support for F15h M60h
Message-Id: <53EDAA24.3080705@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1408058127-19374-1-git-send-email-aravind.gopalakrishnan@amd.com>
In-Reply-To: <1408058127-19374-1-git-send-email-aravind.gopalakrishnan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>, linux@roeck-us.net, jdelvare@suse.de, rdunlap@infradead.org, bp@suse.de
Cc: lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Aravind Gopalakrishnan wrote:
> This patch adds temperature monitoring support for F15h M60h processor.
>  - Add new pci device id for the relevant processor
>  - The functionality of REG_REPORTED_TEMPERATURE is moved to
>    D0F0xBC_xD820_0CA4 [Reported Temperature Control]
>    - So, use this to get CUR_TEMP value
>    - Since we need an indirect register access, protect this with
>      a mutex lock
>  - Add Kconfig, Doc entries to indicate support for this processor.
>
> Signed-off-by: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
> ---
> Changes in V3:
>  - Move helper function that protects indirect register access locally
>    until a time when others outside k10temp may need it
>
> Changes in V2:
>  - Prevent race with other code that may require indirect NB_SMU_REG access
>  - Fix some minor style issues
>
>  Documentation/hwmon/k10temp |  2 +-
>  drivers/hwmon/Kconfig       |  4 ++--
>  drivers/hwmon/k10temp.c     | 35 ++++++++++++++++++++++++++++++++---
>  3 files changed, 35 insertions(+), 6 deletions(-)

Acked-by: Clemens Ladisch <clemens@ladisch.de>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
