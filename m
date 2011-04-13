From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 13 Apr 2011 06:50:53 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/2] Use "request_muxed_region" in it87
Message-Id: <4DA547CD.60406@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302641290-30212-1-git-send-email-natg@google.com> <1302641387-30264-1-git-send-email-natg@google.com>
In-Reply-To: <1302641387-30264-1-git-send-email-natg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nat Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Mike Waychison <mikew@google.com>

Hi,

On 04/12/2011 10:49 PM, Nat Gurumoorthy wrote:
> 01 - Changes to it87 watchdog driver to use "request_muxed_region"
> Serialize access to the hardware by using "request_muxed_region" macro defined
> by Alan Cox. Call to this macro will hold off the requestor if the resource is
> currently busy.
>
> The use of the above macro makes it possible to get rid of
> spinlocks in it8712f_wdt.c and it87_wdt.c watchdog drivers.
> This also greatly simplifies the implementation of it87_wdt.c driver.
>
> Signed-off-by: Nat Gurumoorthy<natg@google.com>
> ---
>
> diff --git a/drivers/watchdog/it8712f_wdt.c b/drivers/watchdog/it8712f_wdt.c
> index 6143f52..51bfbc0 100644
> --- a/drivers/watchdog/it8712f_wdt.c
> +++ b/drivers/watchdog/it8712f_wdt.c
> @@ -51,7 +51,6 @@ MODULE_PARM_DESC(nowayout, "Disable watchdog shutdown on close");
>
>   static unsigned long wdt_open;
>   static unsigned expect_close;
> -static spinlock_t io_lock;
>   static unsigned char revision;
>
>   /* Dog Food address - We use the game port address */
> @@ -123,7 +122,11 @@ static inline void superio_select(int ldn)
>
>   static inline void superio_enter(void)
>   {
> -	spin_lock(&io_lock);
> +	/*
> +	 * Reserve REG and REG + 1 for exclusive access.
> +	 */
> +	(void) request_muxed_region(REG, 2, NAME);
> +

You shouldn't (void) this, there is a reason you get a warning
otherwise! request_muxed_region can still fail if some other driver
has done a none muxed request_region on the same region, and in that
case you should not continue with accessing the io-ports.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
