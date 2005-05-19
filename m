From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Fix fan speeds on ADM1026
Message-Id: <3EE8BB3E.C33EAEAD@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE7EEF7.1040803@penguincomputing.com>
In-Reply-To: <3EE7EEF7.1040803@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

doc/fan-divisors also has a good explanation

Philip Pokorny wrote:
> 
> Jean Delvare wrote:
> >>Jerome Hsiao @ Arima pointed out to me that the fan speeds from the
> >>ADM1026 driver were not consistent with other drivers.
> >>
> >>Seems that most (all?) drivers assume two pulses per rev from the
> >>fans.
> >>  I expected that users would need to use a "compute" directive to
> >>modify the fan speed for the number of pulses-per-rev of their fans.
> >>(All the fans I use are 4 ppr so I'm always having to "compute" a
> >>correct value.)
> >>
> >>But it's not consistent with the other drives...
> >>
> >>So here is a patch to fix the ADM1026 so it reports fan speeds
> >>consistent with the other drivers...
> >>
> >>This was done against CVS...
> >
> >
> > Well, that's what fanX_div is meant for. As far as I know, the number of
> > pulse/rotation depends mostly on the fan itself, not on the monitoring
> > chipset. That's why we let the users change the fanX_div value through
> > the config file.
> >
> > Maybe there's actually something to be fixed in the adm1026 driver, but
> > maybe this is just a matter of setting the right fanX_div for unregular
> > fans.
> 
> No, fan_div doesn't work that way in practice.
> 
> Most (all?) drivers include fan_div in the conversion from counts to
> RPM.  That means that when you change fan_div the RPM reading stays the
> same.
> 
> In practice, changing fan_div affects the minimum detectable fan speed
> and the precision of the measured fan speed.
> 
> With a 22.5kHz clock, and assuming 2 pulse/rev fans, you get the following:
> 
>                    RPM
>                 Min    Typ    Significant Bits in Count
>      Fan Div    254    153     3000   4400   10k 4ppr
>      -------- ------ ------   ------ ------  ---------
>         1      2657   4411     7.81   7.26     5.08
>         2      1329   2206     6.81   6.26     4.08
>         4       664   1103     5.81   5.26     3.08
>         8       332    551     4.81   4.26     2.08
> 
> At a fan_div setting of 8, the 10k, 4ppr fan is only gating 4 counts on
> average giving fan readings of:  14063 (3), 10547 (4), 8437 (5)
> depending on how many counts you got that sample.  Clearly, you want to
> set the fan_div as low as possible and still detect your fans.
> 
> :v)
> 
> --
> Philip Pokorny, Director of Engineering
> Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
> PENGUIN COMPUTING, INC.
> www.penguincomputing.com
