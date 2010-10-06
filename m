From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 06 Oct 2010 19:20:19 +0000
Subject: Re: [lm-sensors] Asus P7p55D motherboard sensor issues
Message-Id: <AANLkTin8LOmkZaGZyYLYKh71F4675M+_V_0=ytc_89z4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 5, 2010 at 3:23 PM, MrBill <cruznredrune@gmail.com> wrote:
> 1123 ATK0110 HWMON DRIVER
> 1124 M:      Luca Tettamanti <kronos.it@gmail.com>
> 1125 L:      lm-sensors@lm-sensors.org
> 1126 S:      Maintained
> 1127 F:      drivers/hwmon/asus_atk0110.c
>
>
> I found this on the web as the person that updates this driver.

Yes, I'm the maintainer

>  Im currently running Suse 11.2 and have the issue about hardware monitoring.

What issue? Can you describe the problem?

> How do I go about updating the driver and getting my sensors to work with
> this OS and Motherboard.  Any help would be greatly appreciated.

The driver is fairly self-contained, you should be able to take a copy
of it from a newer kernel and compile it for your current kernel.

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
