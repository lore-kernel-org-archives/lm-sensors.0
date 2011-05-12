From: Luca Tettamanti <kronos.it@gmail.com>
Date: Thu, 12 May 2011 13:02:08 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <BANLkTi=Kdh=P-mOO+fejhML2hnxX70cpww@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Wed, May 11, 2011 at 7:59 PM, Jeff Rickman <jrickman@myamigos.us> wrote:
> [test results]
> load new i8k module
>
> modprobe -v i8k
> insmod /lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko
> FATAL: Error inserting i8k
> (/lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko): No such
> device
>
> from /var/log/messages
> May 11 12:39:11 XX kernel: [  263.320306] i8k: unable to get SMM Dell
> signature
>
> modprobe -v i8k force
> insmod /lib/modules/2.6.35.12-90.fc14.x86_64/kernel/drivers/char/i8k.ko
> force
>
> from /var/log/messages
> May 11 12:39:11 XX kernel: [  263.320306] i8k: unable to get SMM Dell
> signature
> May 11 12:40:52 XX kernel: [  365.019189] i8k: unable to get SMM Dell
> signature
> May 11 12:40:52 XX kernel: [  365.020148] i8k: unable to get SMM BIOS
> version
> May 11 12:40:52 XX kernel: [  365.027736] Dell laptop SMM driver v1.14
> 21/02/2005 Massimo Dal Zotto (dz@debian.org)
>
> I will guess that this detection issue is not due to the changes made by
> Jean and Luca. This module may be at a dead end for my hardware.

Hum, maybe my change is not correct. It should be possible to verify
to functionality of the patch on Harry's machine

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
