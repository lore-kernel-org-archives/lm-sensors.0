From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Fri, 06 Jul 2007 15:56:06 +0000
Subject: Re: [lm-sensors] Odp:  Sensors working on DL360?
Message-Id: <20070706175606.b42cb918.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <468e04f3cde05@wp.pl>
In-Reply-To: <468e04f3cde05@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 6 Jul 2007 15:57:22 +0200 (CEST)
"Bart van Kuik" <lmsensors@vankuik.nl> wrote:

> Hi Krzysztof,
> 
> Then compiled and installed with "make user && make user_install". But I
> don't get results:
> 
>     # sensors -c /etc/sensors.conf "thmc-*"
>     Specified sensor(s) not found!
> 

There is no thmc50 module in the 2.6.18 kernel. You need to download the patch from the
list and compile the kernel by yourself. If you need help, please email me directly.

> Also, can I visually identify this chipset somehow on the motherboard?
> I've tried to look for an IC marked "TI", but couldn't find it.
> 
I have a Compaq motherboard from the same era (dual Pentium3) and it uses ADM1022 chip
(which is also handled by thmc50 driver). A manufacturer marking is a small Analog
Devices logo (white square with black triangle) in the middle of the chip. The top line
says "1022" or "1022A" (it depends on chip revision). The chips are quite small about
6x4 mm and at least one should be located next to CPU slots (the one which controls CPU
temperature).

It would be great if you can confirm that the DL360 uses this chip type (or maybe not
use).

Regards,
Krzysztof

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
