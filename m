From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Jul 2012 17:48:28 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (acpi_power_meter) Fix unintentional integer overflow
Message-Id: <20120708194828.7349a2ac@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1340287015-14008-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1340287015-14008-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 8 Jul 2012 09:50:47 -0700, Guenter Roeck wrote:
> On Sun, Jul 08, 2012 at 12:21:10PM +0200, Jean Delvare wrote:
> > No, I was. I hadn't seen the patch "hwmon: (acpi_power_meter) Cleanup
> > and optimizations" in your hwmon-staging tree. This indeed solves my
> > above concern.
> 
> Uh, sorry, I forgot about it too. On the other side I missed your Ack for it ...

Did you?

http://lists.lm-sensors.org/pipermail/lm-sensors/2012-June/036556.html

> (...)
> "real" as in actual limits as provided and/or determined by ACPI. Anyway, I may
> have been wrong with that, as apparently acpi_evaluate_integer() is not used to
> validate a value, but to set it (or both ?).

I think it can be used to both retrieve or set an integer value using
appropriate ACPI methods.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
