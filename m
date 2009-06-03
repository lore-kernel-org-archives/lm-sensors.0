From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 03 Jun 2009 15:05:04 +0000
Subject: Re: [lm-sensors] Power Supply Monitoring
Message-Id: <20090603170504.5f03636b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090602164941.uz55en9rms0okkg0@blastoid.drak.net>
In-Reply-To: <20090602164941.uz55en9rms0okkg0@blastoid.drak.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 03 Jun 2009 07:31:21 -0700, Mark E. Hansen wrote:
> On 06/02/09 20:09, Jacob Steinberger wrote:
> > I'm really just looking for a way to do a simple function check on the 
> > power supplies to detect when they're operational. Not necessarily to 
> > find out what voltage is going through, but to see if it's even working 
> > or not. For example, we have one power supply on grid, the other is on 
> > UPS - the easiest way to detect if there's a problem with UPS or grid 
> > power is to monitor the power supplies on the boxes. This would function 
> > as a dual monitor if there was ever an issue with just a power supply.
> 
> How do you expect software on a computer to tell you when the power
> supply on that computer has gone to zero volts?

Some computers have dual (or more) power supply units. On these
machines, as long as at least one PSU is still up and running, you can
monitor them all. However it is relatively rare that mainboards are
wired to monitor that kind of setup.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
