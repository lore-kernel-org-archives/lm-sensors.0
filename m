From: ICMP Request <icmp.request.lists@gmail.com>
Date: Wed, 25 Aug 2010 05:53:20 +0000
Subject: Re: [lm-sensors] Disabling fan control under Linux
Message-Id: <4C74AFD0.8030202@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C74AD95.8030505@gmail.com>
In-Reply-To: <4C74AD95.8030505@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

  On 8/25/2010 2:43 AM, ICMP Request wrote:
>  Hello! I'm planning to install lm_sensors in my Linux platform using 
> Gentoo, but I've got a little worried when I've read the following 
> about lm_sensors on Gentoo Wiki:
>
> "Warning: Be careful when activating sensors, like i2c, in the kernel. 
> On some systems this might stop the fans from working and can disable 
> the ACPI system-overheat shutdown as well. This will cause your 
> computer to freeze at best, or may even cause serious hardware damage.
>
>     * See the lm_sensors website for a problematic hardware list.
>     * Using lm_sensors on IBM ThinkPads is especially not advised"
>
> Well, I believe my hardware is in the supported list, but to avoid any 
> problems, I would like to disable fan control under 
> Linux/acpi/lm_sensors and any application using sensors, so they 
> cannot turn my fan off. Fan would be purely controlled by hardware.
>
> Can it be done by simply disabling the "fan" as built-in or module 
> under ACPI?
>
> Under Linux 2.6 Kernel:
>
> Power management and ACPI options -> ACPI (Advanced Configuration and 
> Power Interface) Support -> Fan =n
>
> Or do I have to do something more complex?
>
> Thanks in advance!

Oh sorry, I've forgot to mention that I wish to disable turning my fan 
off but I still want to enable full acpi/lm_sensors to check my cpu 
temp/status, battery state, cpu freq scaling, etc. So is this possible 
to by doing what I mentioned above disable this single option but enable 
all the rest?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
