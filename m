From: Andre Prendel <andre.prendel@gmx.de>
Date: Thu, 06 May 2010 11:54:13 +0000
Subject: Re: [lm-sensors] 3.1.2 sensord duplicate RRD name problem
Message-Id: <20100506115413.GA4494@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <25a99abe1003040437t333b4007k76850b406911925d@mail.gmail.com>
In-Reply-To: <25a99abe1003040437t333b4007k76850b406911925d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 06, 2010 at 10:34:42AM +0200, Jean Delvare wrote:
> Hi Sergei,

Hi,
 
> On Thu, 4 Mar 2010 14:37:05 +0200, Sergey Kvachonok wrote:
> > sensord fails to start with the following messages:
> > 
> > sensord: Creating round robin database
> > sensord: Error creating RRD file: /var/log/sensord.rrd: Duplicate DS name: temp1
> > 
> > sensors output is like this:
> > 
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Core 0:      +26.0 C  (high = +76.0 C, crit = +100.0 C)
> > 
> > coretemp-isa-0001
> > Adapter: ISA adapter
> > Core 1:      +27.0 C  (high = +76.0 C, crit = +100.0 C)
> > 
> > it8718-isa-0290
> > Adapter: ISA adapter
> > Vcore:       +1.01 V  (min =  +0.00 V, max =  +4.08 V)
> > V_DDR2:      +1.90 V  (min =  +0.00 V, max =  +4.08 V)
> > +3.3V:       +3.38 V  (min =  +0.00 V, max =  +4.08 V)
> > in3:         +3.01 V  (min =  +0.00 V, max =  +4.08 V)
> > in4:         +0.38 V  (min =  +0.00 V, max =  +2.10 V)
> > in7:         +3.15 V  (min =  +0.00 V, max =  +4.08 V)
> > Vbat:        +3.18 V
> > CPU fan:     148 RPM  (min =   10 RPM)
> > System fan:    0 RPM  (min =    0 RPM)
> > temp1:       -55.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
> > temp2:        -2.0 C  (low  = +127.0 C, high = +127.0 C)  sensor = thermistor
> > MB temp:     +17.0 C  (low  = +127.0 C, high = +60.0 C)  sensor = thermal diode
> > cpu0_vid:   +3.300 V
> > 
> > I believe the problem is that different sensors provide results with
> > the same name 'temp1'.
> > Are there any solutions for this problem?
> 
> Thanks for reporting. this appears to be a regression in 3.1.2, as I am
> able to reproduce the bug with this version but not with 3.1.1 on the
> same machine.
> 
> Andre, a bisection points to the following change of yours:
> http://www.lm-sensors.org/changeset/5792/lm-sensors/trunk/prog/sensord
> Any idea?

I will take a look at this tonight.

Thanks,
Andre
 
> -- 
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
