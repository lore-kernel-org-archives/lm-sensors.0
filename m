From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 06 May 2011 19:13:20 +0000
Subject: Re: [lm-sensors] (no subject)
Message-Id: <1304709200.31666.498.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1304707960-10178-1-git-send-email-natg@google.com>
In-Reply-To: <1304707960-10178-1-git-send-email-natg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nat Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>, Wim Van Sebroeck <wim@iguana.be>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mikew@google.com" <mikew@google.com>

On Fri, 2011-05-06 at 14:52 -0400, Nat Gurumoorthy wrote:
> There are 3 different drivers that touch the it87 hardware registers.
> The 3 drivers have been written independently and access the it87 hardware
> registers assuming they are the only driver accessing it. This change
> attempts to serialize access to the hardware by using
> "request_muxed_region" macro defined by Alan Cox. Call to this macro
> will hold off the requestor if the resource is currently busy.
> The use of the above macro makes it possible to get rid of
> spinlocks in it8712f_wdt.c and it87_wdt.c watchdog drivers.
> This also greatly simplifies the implementation of it87_wdt.c driver.
> 
> 01 - Changes to it87 watchdog driver to use "request_muxed_region"
>  drivers/watchdog/it8712f_wdt.c
>  drivers/watchdog/it87_wdt.c
> 
> 02 - Chages to hwmon it87 driver to use "request_muxed_region"
>  drivers/hwmon/it87.c
> 
>  drivers/hwmon/it87.c           |   14 +++-
>  drivers/watchdog/it8712f_wdt.c |   60 ++++++++++----
>  drivers/watchdog/it87_wdt.c    |  165 +++++++++++++++++++++++----------------
>  3 files changed, 152 insertions(+), 87 deletions(-)
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> 
> Signed-off-by: Nat Gurumoorthy <natg@google.com>
> 
> Patch History:
> v8:
> - Return the error actually returned by superio_enter and not -EBUSY.

Hi Nat,

Your use of -EBUSY vs. the returned error code is still inconsistent,
for superio_enter() as well as for other functions returning an error
code.

Also, the following line split is really unnecessary.

-static inline void superio_enter(void)
+static inline int
+superio_enter(void)

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
