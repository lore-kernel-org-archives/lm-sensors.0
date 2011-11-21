From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 21 Nov 2011 21:26:53 +0000
Subject: Re: [lm-sensors] [PATCH] Drivers: hwmon: it87: Add support for ITE
Message-Id: <20111121222653.5441b63f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1320381858.22997.YahooMailNeo@web161601.mail.bf1.yahoo.com>
	<1320688845.2309.122.camel@groeck-laptop>
In-Reply-To: <1320688845.2309.122.camel@groeck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: "Frank T. Lofaro Jr." <ftlofaro@yahoo.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Mon, 7 Nov 2011 10:00:45 -0800, Guenter Roeck wrote:
> On Fri, 2011-11-04 at 00:44 -0400, Frank T. Lofaro Jr. wrote:
> > This patch allows the ITE 8728 chip to be detected and used.
> > The chip appears to be compatible with the 8721.

Frank, can we see the output of "sensors" on your system with your
patch applied?

> Can anyone confirm that those chips are actually compatible ?

The datasheet is not publicly available, unfortunately. The info I have
is that temperature and fan parts are likely to be compatible. Not so
sure about the voltages, although the ADC resolution is the same (12
mV.)

> > @@ -1603,6 +1605,7 @@ static int __init it87_find(unsigned short
> > *address,
> >                 sio_data->type = it8720;
> >                 break;
> >         case IT8721F_DEVID:
> > +       case IT8728F_DEVID:
> >                 sio_data->type = it8721;
> >                 break;
> >         case 0xffff:    /* No device at all */

One thing for sure: I want to play it safe and introduce a separate
chip type for the IT8728F. Two advantages: we can tell who has an
IT8728F from user reports easily, and we can add chip tweaks later
easily without breaking user configurations.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
