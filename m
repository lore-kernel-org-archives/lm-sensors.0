From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Jul 2013 17:17:13 +0000
Subject: Re: [lm-sensors] 3.10: NCT6776F sensor question with Supermicro X9SRL-F motherboard
Message-Id: <20130703171713.GA26555@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <002901ce77e9$dfac4f20$9f04ed60$@lucidpixels.com>
 <20130703144201.GA10323@roeck-us.net>
 <007101ce7807$88cfb160$9a6f1420$@lucidpixels.com>
 <20130703163311.GB12506@roeck-us.net>
 <008001ce780d$0d1a79f0$274f6dd0$@lucidpixels.com>
In-Reply-To: <008001ce780d$0d1a79f0$274f6dd0$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, Jul 03, 2013 at 12:47:47PM -0400, Justin Piszcz wrote:
> 
> 
> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net] 
> Sent: Wednesday, July 03, 2013 12:33 PM
> To: Justin Piszcz
> Cc: linux-kernel@vger.kernel.org; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] 3.10: NCT6776F sensor question with Supermicro
> X9SRL-F motherboard
> 
> [ .. ]
> > 
> Can you install superiotool and run "sudo superiotool -V -e" ?
> I would like to see raw data from the superio chip.
> 
> # superiotool -V -e
> superiotool r6637
> ..
> Probing for Nuvoton Super I/O (sid=0xfc) at 0x164e...
> Found Nuvoton WPCM450 (id=0x1a11, rev=0x00) at 0x164e
> Probing for Nuvoton Super I/O at 0x2e...
> Found Nuvoton NCT6776F (C) (id=0xc333) at 0x2e
> 
Version is too old :(.

Can you try http://roeck-us.net/linux/bin/superiotool ?

> [ .. ]
> 
> You have to specify the raw attribute names, not the symbolic ones.
> You see the raw attribute names with "sensors -u".
> 
> # sensors -u
> PCH_CHIP_TEMP:
>   temp8_input: 0.000
> PCH_CPU_TEMP:
>   temp9_input: 0.000
> PCH_MCH_TEMP:
>   temp10_input: 0.000
> 
> Tried:
>     ignore PCH_CHIP_TEMP
>     ignore temp8_input
> 
> For some reason still can't get rid of it appearing:
> PCH_CHIP_TEMP:   +0.0 C  
> (..as well as the others)
> 
It has to be
	ignore temp8
	ignore temp9
	ignore temp10

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
