From: Andreas Radke <a.radke@arcor.de>
Date: Tue, 06 Jan 2009 16:00:53 +0000
Subject: Re: [lm-sensors] Aspire One Intel Atom's Motherboard support
Message-Id: <20090106170053.3d18f6f1@laptop64.home>
List-Id: <lm-sensors.vger.kernel.org>
References: <f4897e880807160553h3d8dacdfy20efdddfc8c4b476@mail.gmail.com>
In-Reply-To: <f4897e880807160553h3d8dacdfy20efdddfc8c4b476@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Wed, 16 Jul 2008 14:53:20 +0200
schrieb "Simon Depiets" <sdepiets@gmail.com>:

> Hi,
>  I've been recently offered an Acer Aspire One netbook and I wish to
> control the fanspeed manualy
>  I installed the lastest version of lm-sensors (3.0.2), when typing
>   $ sensors
>      i get
>   No sensors found!
> 
> This could be normal, so I did a
>   $ sudo ./sensors-detect
>       and the program wants to load the module
>   `i2c-i801`
>    I don't have such a module, but i have i2c-dev loaded, is i2c-i801
> different, mandatory ? How do I add it (I'm not a kernel building
> "fan"-boy yet sorry :p)
> 
>  My /proc/acpi/fan folder is empty, so it seems acpi support by my
> kernel is just partial (acpi_listen detects battery status io)
> 
> Here are my
>  - lsmod :  http://www.mmo-tools.com/acpi/lsmod.txt
>  - lspci : http://www.mmo-tools.com/acpi/lspci.txt
>  - modinfo i2c-dev : http://www.mmo-tools.com/acpi/modinfo_i2c-dev.txt
>  - modprobe coretemp (is this a mandatory module ?) :
> http://www.mmo-tools.com/acpi/modprobe_coretemp.txt
>  - sudo ./sensors-detect-stat.pl
> http://www.mmo-tools.com/acpi/sensors-detect-stat.txt
> 
> I'm looking forward for you help
> Thanks a lot and sorry for my poor frenglish


What's the state? Can we see full lm_sensor support in the near future?

-Andy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
