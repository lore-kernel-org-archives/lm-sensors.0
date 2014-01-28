From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Jan 2014 13:08:21 +0000
Subject: Re: [lm-sensors] Kernel 3.13 breaks pwmconfig and fancontrol
Message-Id: <20140128140821.51879555@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1390857566.34222.YahooMailNeo@web140002.mail.bf1.yahoo.com>
In-Reply-To: <1390857566.34222.YahooMailNeo@web140002.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 27 Jan 2014 23:46:31 -0800, Guenter Roeck wrote:
> On 01/27/2014 11:22 PM, Jean Delvare wrote:
> > It's not only noise, the problem is real. Thanks for reporting it early
> > so we have a chance to fix it before it hits too many users.
> >
> > Guenter, you did update quite a few hwmon drivers lately and as a
> > consequence their attributes moved from hwmonN/device to hwmonN. While
> > libsensors already knows how to deal with this, fancontrol does not. So
> > the change is likely to break many fancontrol user setups out there,
> > which is not good.
> >
> > I think we need to teach fancontrol about this change and have it look
> > at the new place automatically whenever referenced attributes are
> > missing at the old place.
> 
> You are right. There is a secondary problem, though: Depending on the system,
> hwmon modules may be loaded in different order. What is hwmon0 at one boot
> may be hwmon1 at the next boot. It would be nice if fancontrol could check
> for the name of a hwmon device instead of its path to fix that problem.

That's right. This can be worked around by using absolute device paths
in /etc/fancontrol, however pwmconfig still doesn't generate such paths
IIRC (http://www.lm-sensors.org/ticket/2388 is still open.) OTOH, with
absolute paths the workaround I just implemented doesn't work, so I'm
glad not too many users switched to that yet.

Note that fancontrol already checks the device names so that it detects
the module loading order problem. However it tells the user to run
pwmconfig again, which is only going to work until next reboot. Best
would be if it could adjust the configuration on the fly, as I just did
for the attributes move.

I suppose we will never get away with these problems until we use
libsensors (directly, or at least some libsensors-based helper.) But
really I don't have the time to look into this right now.

John, can you please test:
http://jdelvare.nerim.net/devel/lm-sensors/fancontrol
and confirm that it works fine with your old configuration file under
kernel 3.13?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
