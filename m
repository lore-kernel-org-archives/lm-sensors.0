From: filip.tsachev@gmail.com (Filip Tsachev)
Date: Wed, 23 Nov 2005 15:05:46 +0000
Subject: [lm-sensors] +5V line... and Stdby fixable?
Message-Id: <ea9ff50b0511230605u22b5d9e5md02b3edf6c97670@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <ea9ff50b0511180346s58c38f67p465b9e2adad74bc@mail.gmail.com>
In-Reply-To: <ea9ff50b0511180346s58c38f67p465b9e2adad74bc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I really want to thank you guys (Jean, Rudolf), you were so helpful
and the work you're doing for non-profit is awesome!

About that "hddtemp" (http://freshmeat.net/projects/hddtemp/) tool,
can it be included somehow? I'm *not* fully aware of GPLs and stuff
but maybe it is a good idea to have it *build-in* when you type
sensors to show even hdd temp?

On 11/22/05, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Rudolf, Filip,
>
> > > +5V:       +4.22 V  (min =  +4.76 V, max =  +5.24 V)   ALARM
> Change the in3 compute line:
>
>     compute in3 ((10/10)+1)*@ ,  @/((10/10)+1)
>
> (10 instead of 6.8) and it should look better. A few Gigabyte boards
> seem to use this. I'll note this in our default configuration file.
>
> Also note that on this board, Vcore2 is really Vram, and -12V is Vagp
> (remove the compute line and it should read around 1.5V, then adjust
> the limit settings).
--
Cheers,
Filip
