From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 27 Feb 2010 12:45:46 +0000
Subject: Re: [lm-sensors] adt746x hard shut question
Message-Id: <20100227134546.2863d3b4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <e871e9151002191538x4afa9f66y722ab33abd2aa5d6@mail.gmail.com>
In-Reply-To: <e871e9151002191538x4afa9f66y722ab33abd2aa5d6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Reimundo,

On Fri, 19 Feb 2010 17:51:00 -0800, Reimundo Heluani wrote:
> On Fri, Feb 19, 2010 at 3:38 PM, Reimundo Heluani <rheluani@gmail.com>wrote:
> > Hello list, I am running the module therm_adt746x on a powerbook g4 and the
> > module seems to be doing its thing right. I can set different limits writing
> > to /sys/devices/temperatures/limit_adjust and the fans seem to be responding
> > correctly to both temperature and load. The problem I have is that if I run
> > any compilation for more than a few minutes on performance governor, the
> > system hard shuts itself down. I was wandering if this is done at the
> > Hardware level, or if it's the module who's putting this limit. Also I'd
> > like to know what is this limit and if it's possible to change it. As of now
> > I can only compile things in powersave mode.
>
> Well, looking at the code for the module I see that there is a hardcoded
> limit of 65 degrees Celsius for the CPU. Then later there is a line of the
> form:
> /*Set sensor1 limit higher to avoid powerdowns*/
> and then set the limit to 65 + limit_adjust.
> 
> But my system (with a limit adjust of 0) powers down automatically at 70 C.
> Are these hardcoded limits too low or should I be looking to change the
> thermal paste + heatsink?

The therm_adt746x driver is a macintosh-specific driver not written nor
maintained by the lm-sensors group. I tried to look at the driver's
code but I have to admit I have no idea what they are doing with the
limits. I also don't know how the monitoring chip is wired on the
board. You should ask the macintosh people about your problems.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
