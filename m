From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 03 Jul 2009 10:29:02 +0000
Subject: Re: [lm-sensors] sensors.conf for im-645gse-a (msi9830)
Message-Id: <4A4DDD6E.5010409@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A4BA746.7050803@gmx.de>
In-Reply-To: <4A4BA746.7050803@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 07/01/2009 08:13 PM, Thomas Ettwein wrote:
> # lm_sensors configuration file for the MSI IM-945GSE-A motherboard
> # Atom N270, Dual Gigabit Intel 82574L controllers, VGA, DVI
> # 2009-07-01 Thomas Ettwein
>

Thanks, it has been added to the wiki:
http://lm-sensors.org/wiki/Configurations/MSI/IM-945GSE-A

Can you please also send me a private mail with the output of:
dmidecode

? We plan to use that in the future to automatically identify
motherboards and drop the right configuration in to place
(for those boards where we have a configuration file for).

Regards,

Hans


> chip "f71882fg-*"
>
> # Temperature
>       label temp1       "CPU"
>       label temp2       "Systemboard"
>       ignore temp3
>
> # Fans
>        ignore fan1 # no connector on board
>        label fan2 "CPUFAN1"
>        ignore fan3 # no connector on board
>        ignore fan4 # no connector on board
>
>
> # Voltage
>       label in0         "3.3V"
>       label in1         "Vcore"
>       label in2         "Vdimm"
>       label in3         "Vchip"
>       label in4         "+5V"
>       label in5         "12V"
>       label in6         "5VSB"
>       label in7         "3VSB"
>       label in8         "Battery"
>
> # never change the in0, in7 and in8 compute, these are hardwired in the chip!
>       compute in0       (@ * 2), (@ / 2)
>       compute in2       (@ * 2), (@ / 2)
>       compute in3       (@ * 2), (@ / 2)
>       compute in4       (@ * 5.25), (@ / 5.25)
>       compute in5       (@ * 12.83), (@ / 12.83)
>       compute in6       (@ * 5.25), (@ / 5.25)
>       compute in7       (@ * 2), (@ / 2)
>       compute in8       (@ * 2), (@ / 2)
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
