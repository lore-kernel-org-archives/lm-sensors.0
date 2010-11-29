From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Nov 2010 16:00:22 +0000
Subject: Re: [lm-sensors] Testing LM-Sensor Support of SCH5127 in Acer
Message-Id: <20101129170022.2e1101ef@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
In-Reply-To: <57920.75.142.173.238.1291011644.squirrel@webmail.myamigos.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jeff,

On Mon, 29 Nov 2010 09:51:08 -0600 (CST), Jeff Rickman wrote:
> > On Mon, 29 Nov 2010 00:20:44 -0600 (CST), Jeff Rickman wrote:
> >> #    label temp2 "SIO Temp"
> >
> > This is an internal sensor, it should always be present and correct, so
> > why would you ignore it?
> 
> The value is high...very high. Does a flucuating value between 120 and 128
> Celsius make sense?

Indeed not. Juerg, you have the datasheet (I think?), I don't, can you
please check if temp2 is still internal on the SCH5127?

> >>     label temp3 "SYS Temp"
> >>
> >>     compute in0 (@ * 0.8), (@ / 0.8)
> 
> Removing this compute line shows a fairly stable in0 value of 1.78

Which I admit isn't very appealing. Make me wonder if the internal
scaling factors in the driver are correct. Again, Juerg, I have to
defer to you.

> > (...)
> > Assuming that your CPU does frequency and voltage scaling based on
> > load, you should try to put some load on the CPU and check which
> > voltage input raises. This would be Vcore (Vccp) and should require no
> > scaling. If you can figure that one out, it might help sort out the
> > rest.
> 
> I will need to find some type of CPU stress program. Even moving 250,000
> files (about 70+GB) between hard drives inside the chassis using Rsync
> only placed <5% load on the CPU.

I use "md5sum /dev/zero" for this.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
