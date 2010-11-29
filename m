From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 29 Nov 2010 18:25:51 +0000
Subject: Re: [lm-sensors] ASRock board W83677HG-I
Message-Id: <1291055151.20815.123.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1274168639.7859.20.camel@eee51>
In-Reply-To: <1274168639.7859.20.camel@eee51>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

To follow up on the original post,

On Mon, 2010-11-29 at 13:14 -0500, no tellin wrote:

[ ... ]

> On Thu, Nov 25, 2010 at 3:38 AM, Andrea Rizzolo
> <andrea.rizzolo@gmail.com> wrote:
> > *bump*
> > Hi, any update? I have the same chip on my Intel DH57JG motherboard and I'm
> > playing with w83627ehf driver (2.6.36). if I load it with force_id=0xa510,
> > running sensors gives me some apparently working output:
> >
> > w83667hg-isa-0680
> > Adapter: ISA adapter
> > Vcore:       +0.93 V  (min =  +0.00 V, max =  +1.74 V)
> > in1:         +0.77 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> > AVCC:        +3.41 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> > +3.3V:       +3.41 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> > in4:         +1.26 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> > in5:         +0.78 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> > 3VSB:        +3.36 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> > Vbat:        +3.30 V  (min =  +0.00 V, max =  +0.00 V)   ALARM
> > fan1:          0 RPM  (min =    0 RPM, div = 2)  ALARM
> > fan2:          0 RPM  (min =    0 RPM, div = 2)  ALARM
> > fan3:          0 RPM  (min =    0 RPM, div = 2)  ALARM
> > fan5:          0 RPM  (min =    0 RPM, div = 2)  ALARM
> > temp1:       +29.0 C  (high =  +0.0 C, hyst =  +0.0 C)  ALARM  sensor > > diode
> > temp2:       +30.5 C  (high = +80.0 C, hyst = +75.0 C)  sensor = diode
> > temp3:       +23.0 C  (high = +80.0 C, hyst = +75.0 C)  sensor = thermistor
> > cpu0_vid:   +2.050 V
> >

Key difference between the W83677HG-I is fan register access, so the
result isn't surprising. Adding support for fans will be the tricky
part.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
