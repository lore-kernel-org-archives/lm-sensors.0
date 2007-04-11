From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Apr 2007 11:56:14 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <20070411135614.4e325358@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 09 Apr 2007 14:50:03 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > On Sun, 08 Apr 2007 19:36:47 +0200, Hans de Goede wrote:
> >> (...) Last but 
> >> not least doing things this way allows me to always give a proper reading 
> >> without userspace needing to "guess" any further nescesarry calculations to get 
> >> from the reading to an actual measurement.
> > 
> > This is absolutely not different from all other hardware monitoring
> > drivers. And all other drivers handle it in user-space, because that's
> > the right design. I see no valid reason why it would be different for
> > your abituguru3 driver. All you need is one configuration file per
> > motherboard.
> 
> Oh and yet another thing, since when should all conversions be done in 
> userspace? I did exactly that with the abituguru 1/2 driver and there I had to 
> change it to give the return the actual pin values in Volts and not register 
> values, iow do the conversion in the driver. You are contradicting yourself!

What I really meant was that motherboard-specific conversions, such as
the ones accounting for voltage scaling resistors, belong to
user-space. The conversions from register values to standard units (mV,
RPM etc...) still belong to kernel-space in our model.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
