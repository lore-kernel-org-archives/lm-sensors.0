From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Dec 2012 18:52:37 +0000
Subject: Re: [lm-sensors] ITE it8603e
Message-Id: <20121202195237.74906588@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
In-Reply-To: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2 Dec 2012 10:26:51 -0800, Guenter Roeck wrote:
> On Sun, Dec 02, 2012 at 06:57:28PM +0100, Jean Delvare wrote:
> > The information I was able to get from my contact at ITE:
> > 
> > * The IT8603E does supports hardware monitoring.
> > 
> > * The chip has a built-in 8-bit ADC, two thermal inputs with mode
> >   selection (thermistor / transistor), 5 external voltage inputs +
> >   3VSB, AVCC3 and VBAT measured internally. It features limits for all
> >   measured values (although probably not for VBAT) and fetching of
> >   external temperature values over SST/PECI/AMDSTI/PCH SM-Link.
> > 
> > * The IT8603E does support automatic fan speed control.
> > 
> > * The IT8603E is compatible to some degree with the IT87xxF family.
>
> Will that be good enough for us ? We know way more about IT8771E and IT8772E,
> mostly thanks to the code in coreboot and ohm, yet so far declined to add
> support for it because we don't have data sheets. Or is it time to add support
> for those chips as well, assuming they are compatible to IT8728F ?

I have no objection if you feel confident.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
