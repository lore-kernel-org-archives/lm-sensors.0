From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 29 Nov 2010 14:53:32 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (fschmd) Drop useless mutex
Message-Id: <20101129145332.GA19668@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101129131657.10d2a81c@endymion.delvare>
In-Reply-To: <20101129131657.10d2a81c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 29, 2010 at 07:16:57AM -0500, Jean Delvare wrote:
> As discussed one year ago, the WDIOC_GETSUPPORT ioctl only needs a
> mutex because it operates on a static variable. There is no good
> reason to keep this variable static, so let's just make it non-static
> and drop the now useless mutex altogether.
> 
> See the discussion at:
> http://marc.info/?l=lm-sensors&m5563869402323&w=2
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Hans de Goede <hdegoede@redhat.com>

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
