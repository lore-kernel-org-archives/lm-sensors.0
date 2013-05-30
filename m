From: SZENTE Balint <balint@szentedwg.ro>
Date: Thu, 30 May 2013 07:40:42 +0000
Subject: Re: [lm-sensors] Configuration file for Intel D2500CC mini-ITX board
Message-Id: <20130530104042.43354142@obraro.integrasoft.ro>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130529150440.4e021553@obraro.integrasoft.ro>
In-Reply-To: <20130529150440.4e021553@obraro.integrasoft.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean!

On Wed, 29 May 2013 17:05:47 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> > > [...]
> > > >     # Processor Vcc
> > > >     label   in0            "Vcore"
> > > >     set     in0_min        0.40
> > > >     set     in0_max        1.60
> > 
> > Vcore is special. I noticed that it changes with SpeedStep (for
> > example on D2800). However D2500 does not have SpeedStep. It is
> > constantly on 1.19V. In case of D2800 for example it varies
> > between 0.85V and 1.07V depending on the load.
> > What would you recommend for min/max?
> 
> As it depends on the CPU it is hard to say. The user will have to
> adjust them anyway so I'll leave the values above.

I have read the relevant parts from the Intel Atom Datasheet and I
believe now I figured out what should be the limits.

Table 4-30 from the "Intel Atom Processor D2000 and N2000 Series
Datasheet, Vol. 1" contains two voltage specifications
<http://www-ssl.intel.com/content/dam/doc/datasheet/atom-d2000-n2000-vol-1-datasheet.pdf>:

 VCC_HFM:
  - Vcc at Highest Frequency Mode (HFM)
  - Range 0.91V - 1.21V, depending on the calibrated individual
    voltage identification value (VID)

 VCC_LFM: only for CPUs with SpeedStep feature
  - Vcc at Lowest Frequency Mode (LFM)
  - Range 0.70/0.75 - 0.90V, depending on VID

The Intel D2500CC mini-ITX board has an Intel Atom D2500 soldered on
it which lacks the SpeedStep technology, so one can say that the proper
Vcore limits for this specific mainboard are:

label   in0            "Vcore"
set     in0_min        0.91
set     in0_max        1.21

Can you fix this on the Wiki page?

Thank you for your support.

Regards,
Balint

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
