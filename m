From: wik@blueyonder.co.uk (Rik Ryall)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: Asus P4C800-E Deluxe/Winbond W83627THF issue
Message-Id: <200502062244.27059.wik@blueyonder.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502022021.06992.wik@blueyonder.co.uk>
In-Reply-To: <200502022021.06992.wik@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

On Sunday 06 February 2005 20:58, Mark M. Hoffman wrote:
>
> * Rik Ryall <wik@blueyonder.co.uk> [2005-02-02 20:21:06 +0000]:
> > I'm running Suse 9.2 Pro with a 2.6.8 kernel (2.6.8-24.11-smp to be
> > precise) and whilst I've made /some/ progress with getting sensors to
> > work, I seem to be getting less positive results than I did on my
> > previous 2.4-based build.
>
> Looks like Jean already helped you to get the right versions.
>
> I have the very same mainboard, and here's my sensors(1) output:
> (Note: I have an external temperature probe on temp3, you may want to
> ignore)
>
> w83627thf-isa-0290
[snip]

Many thanks to you both for helping me out.  I'd managed to get pretty much 
the sensors.conf you have (albeit not as tidy!) by trial, error, reading and 
re-reading the docs and not a little bit of coaching from Jean.

Having your code has helped to validate my workings thus far for which I'm 
very grateful.

I'm still stuck with duff vid data as I can't currently compile lm_sensors -- 
GNU Make 3.80 stops when doing a "make user" with the following gripe:
make: *** No rule to make target
> > `/lib/modules/2.6.8-24.11-smp/build/include/linux/modversions.h',
> > needed by ?`kernel/chips/xeontemp.d'. ?Stop.

And it's got me stumped.  Jean did suggest I stop by the irc channel but I've 
simply not had the time, yet.

Meanwhile, my voltages are a way off 'cause of the vid problem but the temps 
and fan speeds have been nailed, so, my glass is half full.
:-)

Thanks for now.

Rik.
