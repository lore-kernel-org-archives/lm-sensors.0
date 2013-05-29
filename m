From: SZENTE Balint <balint@szentedwg.ro>
Date: Wed, 29 May 2013 13:30:13 +0000
Subject: Re: [lm-sensors] Configuration file for Intel D2500CC mini-ITX board
Message-Id: <20130529163013.1ee5ab1a@obraro.integrasoft.ro>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130529150440.4e021553@obraro.integrasoft.ro>
In-Reply-To: <20130529150440.4e021553@obraro.integrasoft.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean!


Thanks for your observations. Please find my answers below.

On Wed, 29 May 2013 14:31:03 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> [...]
> > chip "w83627uhg-*"
> > 
> >     ignore  intrusion0
> 
> If this feature missing on the board itself, or only on your chassis?
> If it is present on the board then we don't want to ignore it in the
> configuration file present in the wiki.

I think it is actually missing from the board itself. I did not find
any connector on the mainboard itself. Similar to the second fan input.
I kindly ask you to verify it:
<http://www.intel.com/support/motherboards/desktop/d2500cc/sb/CS-032623.htm>
Chapter 1.10.1 -- Hardware Monitoring

> [...]
> >     # Processor Vcc
> >     label   in0            "Vcore"
> >     set     in0_min        0.40
> >     set     in0_max        1.60

Vcore is special. I noticed that it changes with SpeedStep (for
example on D2800). However D2500 does not have SpeedStep. It is
constantly on 1.19V. In case of D2800 for example it varies
between 0.85V and 1.07V depending on the load.
What would you recommend for min/max?

> > 
> >     # +3.3V
> >     label   in1            "+3.3V"
> >     compute in1            3.2*@, @/3.2
> >     set     in1_min        3.00
> >     set     in1_max        3.60
> > 
> >     # +5.0V
> >     label   in3            "+5V"
> >     set     in3_min        4.60
> >     set     in3_max        5.40
> > 
> >     # +12.0V
> >     label   in4            "+12V"
> >     compute in4            12*@, @/12
> >     set     in4_min        10.20
> >     set     in4_max        13.80
> 
> These +3.3V, +5V and +12V limits are way beyond the +/- 5% specified
> by ATX.

I fully agree with you. I take these limits from the BIOS factory
default values. Also without giving the min/max, the default range form
the driver is almost the same. Please fix the wiki and write for all of
them to <nominal value> *0.95 and *1.05, as you said.

> > 
> >     # Memory Vcc
> >     label   in5            "Vdimm"
> >     set     in5_min        1.00
> >     set     in5_max        2.00
> 
> These limits make no sense, it's hardly better than having no limits
> at all. If the board is using DDR3 memory modules, you should use:
> 
>     set     in5_min        1.5 * 0.95
>     set     in5_max        1.5 * 1.05

Yes it is DDR3. See the above for explanation. Please apply your
correction to the wiki page.

> >     # +5.0V Standby
> >     label   in7            "5VSB"
> >     set     in7_min        4.60
> >     set     in7_max        5.40
> > 
> > # Fans
> > 
> >     label   fan1           "System Fan"
> >     set     fan1_min       250
> >     ignore  fan2

Fan 2 is missing from the board, so I ignored it.

Thank you.

Regards,
Balint

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
