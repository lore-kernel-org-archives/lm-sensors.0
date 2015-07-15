From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 15 Jul 2015 17:46:04 +0000
Subject: Re: [lm-sensors] support for IT8586E
Message-Id: <20150715194604.488f4673@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CANOLSHBWuQCpJTUT3aNi7_rqPwPT4QK7CkVxvhcuyfm4qqFw8g@mail.gmail.com>
In-Reply-To: <CANOLSHBWuQCpJTUT3aNi7_rqPwPT4QK7CkVxvhcuyfm4qqFw8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 15 Jul 2015 12:27:04 -0400, Dev Anand wrote:
> Thanks Jean and Guenter,
> 
> There is no /proc/acpi/fan or /proc/acpi/thermal_zone folder but, I do see
> /proc/acpi/button and /proc/acpi/wakeup.
> Is there any guide on how to setup the ACPI fan control?

In general there is nothing to setup by the OS, the environment
controller will do it all for you. That's why I suggested checking the
BIOS options. If there is any way to tweak the environment controller,
that's in the BIOS.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
