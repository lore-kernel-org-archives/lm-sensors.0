From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Jul 2013 16:33:11 +0000
Subject: Re: [lm-sensors] 3.10: NCT6776F sensor question with Supermicro X9SRL-F motherboard
Message-Id: <20130703163311.GB12506@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <002901ce77e9$dfac4f20$9f04ed60$@lucidpixels.com>
 <20130703144201.GA10323@roeck-us.net>
 <007101ce7807$88cfb160$9a6f1420$@lucidpixels.com>
In-Reply-To: <007101ce7807$88cfb160$9a6f1420$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, Jul 03, 2013 at 12:08:17PM -0400, Justin Piszcz wrote:
> 
> 
> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net] 
> Sent: Wednesday, July 03, 2013 10:42 AM
> To: Justin Piszcz
> Cc: linux-kernel@vger.kernel.org; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] 3.10: NCT6776F sensor question with Supermicro
> X9SRL-F motherboard
> 
> [ .. ]
> 
> This is surprising and might be where the alarm comes from. What output do
> you
> get if you load the coretemp driver ? 
> 
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +38.0 C  (high = +81.0 C, crit = +91.0 C)
> Core 0:         +36.0 C  (high = +81.0 C, crit = +91.0 C)
> Core 1:         +35.0 C  (high = +81.0 C, crit = +91.0 C)
> Core 2:         +35.0 C  (high = +81.0 C, crit = +91.0 C)
> Core 3:         +34.0 C  (high = +81.0 C, crit = +91.0 C)
> Core 4:         +37.0 C  (high = +81.0 C, crit = +91.0 C)
> Core 5:         +38.0 C  (high = +81.0 C, crit = +91.0 C)
> 
Can you install superiotool and run "sudo superiotool -V -e" ?
I would like to see raw data from the superio chip.

> > PCH_CHIP_TEMP:   +0.0 C  
> > PCH_CPU_TEMP:    +0.0 C  
> > PCH_MCH_TEMP:    +0.0 C  
> > intrusion0:    ALARM
> > intrusion1:    ALARM
> 
> Are those not connected ?
> 
> The intrusion headers are not connected, also, I have not dug into it but
> when you try to ignore the PECI or those PCH* lm_sensors seems to ignore the
> rule.
> 
> sensors3.conf:
>     ignore PCH_CHIP_TEMP
>     ignore PCH_CPU_TEMP
>     ignore PCH_MCH_TEMP
> 
You have to specify the raw attribute names, not the symbolic ones.
You see the raw attribute names with "sensors -u".

> $ sensors  |tail -n 4
> PCH_CHIP_TEMP:   +0.0 C
> PCH_CPU_TEMP:    +0.0 C
> PCH_MCH_TEMP:    +0.0 C
> 
> Ignoring intrusion works though:
>     ignore intrusion0
>     ignore intrusion1
> 
Does the board have intrusion detection headers ? If so, you could close
(bridge) the header(s) which should get rid of the alarm.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
