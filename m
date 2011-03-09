From: "Eibach, Dirk" <Eibach@gdsys.de>
Date: Wed, 09 Mar 2011 14:47:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ads1015) Make gain and datarate
Message-Id: <48D3D52125C49B43AE880038E2E5314BB5BE78@SRV101.gdsys.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299678760-4027-1-git-send-email-eibach@gdsys.de> <20110309144003.GA25609@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, w.sang@pengutronix.de, rdunlap@xenotime.net


> Hi Dirk,

Hi Guenter,

> ...
> > +Each channel can be configured indvidually:
> > + - pga ist the programmable gain amplifier
> > +    0: FS = +/- 6.144 V
> > +    1: FS = +/- 4.096 V
> > +    2: FS = +/- 2.048 V (default)
> > +    3: FS = +/- 1.024 V
> > +    4: FS = +/- 0.512 V
> > +    5: FS = +/- 0.256 V
> > + - data_rate in samples per second
> > +    0: 128
> > +    1: 250
> > +    2: 490
> > +    3: 920
> > +    4: 1600
> > +    5: 2400
> > +    6: 3300
> > +
> 
> I thought the data rate only applies for continuous mode, 
> which you don't use.
> What does it do in single shot mode ?

It affects the sigma delta integration time and as a result the
conversion time.

> Thanks,
> Guenter

Cheers
Dirk



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
