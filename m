From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 26 Apr 2010 14:44:15 +0000
Subject: Re: [lm-sensors] asus_atk0110 not detecting anything on P5LD2EB-DHS
Message-Id: <r2m68676e01004260744w4bcea1bl363903720410faa6@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <k2r68676e01004260718y3c0c397bpcf1892a7ae30b9f5@mail.gmail.com>
In-Reply-To: <k2r68676e01004260718y3c0c397bpcf1892a7ae30b9f5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 26, 2010 at 4:27 PM, Doru Petrescu <pdoru@evox.ro> wrote:
> atk0110 doesn't add anything in /sys/class/hwmon
> the only thing there (hwmon0) is provided by eeepc_laptop module.

Not good, it might indicate that the driver has been loaded but not
bound to any device.

> I will try a newer kernel.

BTW, the driver is fairly self contained, you should be able to
compile the driver from a newer kernel for your current one (without
installing the newer kernel) with something like:

make -C /lib/modules/$(uname -r)/source O=/lib/modules/$(uname
-r)/build M=$(pwd)
(with Makefile and driver source in the current directory)

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
