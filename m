From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 19 Oct 2007 21:25:31 +0000
Subject: Re: [lm-sensors] svn commit: r4959 -
Message-Id: <20071019232531.3c767d99@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

>       Author: jwrdegoede
>         Date: Fri Oct 19 11:48:49 2007
> New Revision: 4959
>    Changeset: http://lm-sensors.org/changeset/4959
> 
> Modified:
>    lm-sensors/branches/lm-sensors-3.0.0/etc/sensors.conf.eg
> 
> Log:
> The new fschmd driver uses the standard scaling values from the datasheet, so no conversion should be done from sensors.conf

I am worried by this change, for two reasons. The first reason is that
the original comment was suggesting that the scaling resistors for the
Hermes were external and could change from one motherboard to the next,
while your new fschmd driver handles the scaling internally. If the
resistors are actually external, then your driver should not do the
scaling. Please clarify.

The second reason is that your change to sensors.conf.eg breaks the
original fscher driver. I understand that the two drivers are not
compatible in this respect (for now at least) so you can't have a
single default configuration file that works for both, but you really
should document the problem so that users have a chance to fix the
config file for use with the old fscher driver. In other words, instead
of deleting this section from the configuration file, you should have
commented it out and added a note that users of the old driver must
uncomment it again.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
