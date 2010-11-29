From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 29 Nov 2010 14:53:46 +0000
Subject: Re: [lm-sensors] hwmon: (w83793) Drop useless mutex
Message-Id: <20101129145346.GB19668@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101129141659.3429d849@endymion.delvare>
In-Reply-To: <20101129141659.3429d849@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Nov 29, 2010 at 08:16:59AM -0500, Jean Delvare wrote:
> This is the same case as fschmd, from which the code was copied as far
> as I can see. So the same clean-up applies:
> 
> The WDIOC_GETSUPPORT ioctl only needs a mutex because it operates on a
> static variable. There is no good reason to keep this variable static,
> so let's just make it non-static and drop the now useless mutex
> altogether.
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
