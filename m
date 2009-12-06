From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Dec 2009 15:59:41 +0000
Subject: Re: [lm-sensors] Zotac itx-f sensor i2cdump
Message-Id: <20091206165941.3a575f68@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <45354d3e0912020755s5c8f2c00rc9c5611c204ae719@mail.gmail.com>
In-Reply-To: <45354d3e0912020755s5c8f2c00rc9c5611c204ae719@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Sun, 6 Dec 2009 16:51:43 +0100, MC Matti wrote:
> 2009/12/3 Jean Delvare <khali@linux-fr.org>:
> > You might as well take your chance and force the lm90 driver to treat
> > your chip as a lm86:
> >
> > modprobe lm90 force_lm86=0,0x4c.
> >
> > Now if your house burn, I'm not responsible, OK? ;)
> >
> :)
> I couldn't resist.
> Up to now the MoBo hasn't exploded or catched fire etc...
> But it may happen.
> Heres what I did:
> 
> root@localhost:~# modprobe lm90 force_lm86=0,0x4c
> root@localhost:~# dmesg | tail -2
> [   18.363869] i2c /dev entries driver
> [   22.060013] eth0: no IPv6 routers present
> 
> root@localhost:~# sensors
> lm86-i2c-0-4c
> Adapter: SMBus nForce2 adapter at 4d00
> temp1:       +44.0°C  (low  = -40.0°C, high = +70.0°C)
>                       (crit = +85.0°C, hyst = +75.0°C)
> temp2:       +57.9°C  (low  = -40.0°C, high = +70.0°C)
>                       (crit = +110.0°C, hyst = +100.0°C)

Looks reasonable. temp1 is an internal sensor, so it gives you the
board temperature. temp2 is remote, that would be the CPU temperature.
Configuration file would be:

chip "lm86-i2c-*-4c"

   label temp1 "M/B Temp"
   label temp2 "CPU Temp"

Let us know if you notice anything wrong later. When we have proper
W83L771* support, we'll let you know.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
