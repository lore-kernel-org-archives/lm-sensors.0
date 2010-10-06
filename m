From: Luca Tettamanti <kronos.it@gmail.com>
Date: Wed, 06 Oct 2010 20:06:58 +0000
Subject: Re: [lm-sensors] Asus P7p55D motherboard sensor issues
Message-Id: <AANLkTik1fdiArYcd7REJYx5bpLGQ+eaQRh3TzZmCZ=pB@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTin8LOmkZaGZyYLYKh71F4675M+_V_0=ytc_89z4@mail.gmail.com>
In-Reply-To: <AANLkTin8LOmkZaGZyYLYKh71F4675M+_V_0=ytc_89z4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Plaese use reply all :)

On Wed, Oct 6, 2010 at 9:42 PM, MrBill <cruznredrune@gmail.com> wrote:
> Thanks for the reply.
>
> Im running Suse 11.2 64 with the Asus P7P55D MB.
> The asus_atk0110.c file is from sept 2009.
> lsmod shows the asus_atk0110.c driver is loaded.
>
> Im seeing this in my messages file:  ATK0110 ATK0110:00: atk_read_value_new:
> ACPI exception: AE_BUFFER_OVERFLOW

Ah, that :) Yes, it's a known bug.

> In reading someone said to add acpi_enforce_resources=lax to my
> /boot/grub/menu.lst file.

No, that a different thing: it allows the user to load native drivers
(which potentially dangerous).

> You mentioned to take a copy of it from a newer kernel and compile.  I have
> not done that.  If you have any docs on that please let me know.
> I've seen many forums talking about this and wanted to know if you had any
> suggestions on this.

Grab the driver from a newer kernel and put it somewhere, then create
a simple Makefile:

obj-m += asus_atk0110.o

and compile with:

make -C /lib/modules/$(uname -r)/source O=/lib/modules/$(uname
-r)/build M=$(pwd)

You'll need the kernel sources installed (it should be either
kernel-default-devel or kernel-desktop-devel depending on which kernel
you're running).

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
