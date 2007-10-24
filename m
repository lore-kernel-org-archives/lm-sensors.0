From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 24 Oct 2007 20:48:23 +0000
Subject: Re: [lm-sensors] svn commit: r4959 -
Message-Id: <20071024224823.57425705@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071019232531.3c767d99@hyperion.delvare>
In-Reply-To: <20071019232531.3c767d99@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Wed, 24 Oct 2007 14:39:06 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > I am worried by this change, for two reasons. The first reason is that
> > the original comment was suggesting that the scaling resistors for the
> > Hermes were external and could change from one motherboard to the next,
> > while your new fschmd driver handles the scaling internally.
> 
> I don't know where the resistors are, as the "datasheet" which we have gives no 
> details on this.
> 
> > If the
> > resistors are actually external, then your driver should not do the
> > scaling. Please clarify.
> 
> There are 3 reasons to do the scaling in the driver:
> 1) The used scale values are taken 1 on 1 from the fscher "datasheet"

Do we really have the same datasheet? Mine states that the scaling
factor is computed from values present in the DMI table. Could you
please send me (in private) the output of dmidecode for your test
system? I'd like to take a look. The Poseidon datasheet OTOH indeed
lists hard-coded values.

What worries me a little is that your scaling actually differs from what
sensors.conf had for +12V for the fscher driver. You driver does *
14200 / 255, while the formula in sensors.conf does * 16170 / 255. This
suggests that different motherboards actually do need different scaling
factors. OTOH I admit I find it strange because the input measures the
same voltage (+12V) so I fail to see the point of using a slightly
different scaling factor from one board to the next, especially when
all boards are from the same manufacturer.

> 2) They are all we have, the old driver directly exported register values
>     which is not compliant with the sysfs interface

I agree that what the fscher driver was doing originally was probably
not correct: it would be surprising if the FSC chips' ADC had exactly a
10 mV resolution. OTOH, if we don't know the actual ADC resolution and
still want to do the scaling in user-space, that was about the only way.

> 3) The new unified driver behaves identical for the fscpos and fscscy as the
>     old drivers, the old fscher driver was the only fsc driver which didn't do
>     scaling (no scaling at all, as said it directly exported register values
>     which is not compliant with the sysfs interface)

The majority isn't always right ;)

The fscher wasn't exporting raw register values, rather it was
arbitrarily assuming a 10 mV ADC. But OK, that's about the same.

> > The second reason is that your change to sensors.conf.eg breaks the
> > original fscher driver. I understand that the two drivers are not
> > compatible in this respect (for now at least) so you can't have a
> > single default configuration file that works for both, but you really
> > should document the problem so that users have a chance to fix the
> > config file for use with the old fscher driver. In other words, instead
> > of deleting this section from the configuration file, you should have
> > commented it out and added a note that users of the old driver must
> > uncomment it again.
> 
> Agreed, I'll put it back in commented for the 3.x.x branch, and a comment that 
> the lines should be commented to the trunk sensors.conf

Great, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
