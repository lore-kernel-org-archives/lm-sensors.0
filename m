From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 14 Aug 2013 03:02:22 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <520AF33E.4090500@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/13/2013 07:41 PM, Dev, Kapil wrote:
> Thanks again Guenter!
>
>
>
> On Tue, Aug 13, 2013 at 5:51 PM, Guenter Roeck <linux@roeck-us.net <mailto:linux@roeck-us.net>> wrote:
>
>     On Tue, Aug 13, 2013 at 05:11:31PM -0400, Dev, Kapil wrote:
>      > Thanks for the response Guenter!
>      >
>      > I put the system on load and I noticed their value hardly changes. To my
>      > surprise, I ran a benchmark for 3 minutes and none of temp*  values changed
>      > during execution. The highest reported temperature is always 48C.
>      >
>      > I was expecting that the internal temperature would have "sensor = thermal
>      > diode" or "sensor = core" as a keyword. I thought "sensor=thermistor" means
>      > the corresponding sensor is on the motherboard and not the internal
>      > die-sensor.
>      >
>     Sure, but who knows if they put a sensor below the CPU for some reason ...
>
>     I am not familiar with the A10 CPUs. Are those similar to K10 ?
>     If so, maybe the k10temp driver works or could be extended to support it.
>     Can you give it a try ?
>
>     If it does not work out of the box, can you send me the output of "lspci -nn" ?
>
>
> Kapil: I believe K10 corresponds to A8 seried, and A10 has Bulldozer architecture (http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html). I am not sure how different they are though. I tried K10, but it did not work out of the box. I am looking into k10temp.c driver now. Also,I am attaching the output of "lspci -nn" command herewith; you might have to open it using wordpad for proper formatting..
>

Your lspci output includes

00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1403]

which is supported by the latest k10temp driver. Support was added early last year.
What is your kernel version, and can you switch to a more recent version ?

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
