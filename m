From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Oct 2007 15:36:05 +0000
Subject: Re: [lm-sensors] [PATCH] On n2100 systems,
Message-Id: <20071019173605.1cfcb233@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071016100857.GA25544@kos.to>
In-Reply-To: <20071016100857.GA25544@kos.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Riku, Lennert,

On Thu, 18 Oct 2007 11:56:04 +0300, Riku Voipio wrote:
> Redboot does not touch the fans. The problem is that the fanspeed
> reading isn't reliable. The "speed" mode tries to adjust pwm to get
> the fanspeed to match whatever is requested in "expect" registers,
> but never to enough to get the fans to run.

I see. I have to admit that it isn't very smart from Fintek to set the
"speed mode" by default on this chip. It would be safer to default to
full speed. OTOH the default speed target seems to be 4297 RPM if I
read the datasheet correctly, which is high enough. If the fan speed
reading isn't reliable (which admittedly is a bad thing to start with)
I'd expect the chip to set the fan output to the max. Isn't it the case?

> As Lennert mentioned, Software provided by Thecus
> does set the fans running by default (by combination of
> a kernel driver and userland scripts). It's not sold as a
> general purpose PC.
> 
> In my experience the risk of literal "frying" is very very low,
> but even with just one one disk inside and finnish cool weather,
> smartmontools have reported the hard drive going over the
> operating temperature limit (60c).
> 
> With, say, 2x10 rpm disks inside the case, I'd say the risk of
> disks breaking down prematurely is very real. And I do not
> want to take the responsibility of people reporting that "installing
> Debian caused my hardware to break down"

I see. But I can't think of a reason why this can't be simply solved in
user-space, as Thecus is doing in their own product. This would be much
easier than the kernel patches you've been sending.

> > Can I see a dump of the chip before the Linux driver is loaded?
>
> I'll grab it, but see the first paragraph I wrote.

I'm still interested.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
