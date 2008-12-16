From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 16 Dec 2008 10:07:41 +0000
Subject: Re: [lm-sensors] Problem with:
Message-Id: <20081216110741.2a948c04@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <494652C1.8060506@redhat.com>
In-Reply-To: <494652C1.8060506@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,

On Mon, 15 Dec 2008 14:24:48 +0100, Jean Delvare wrote:
> Hi Hans,
> 
> On Mon, 15 Dec 2008 13:51:13 +0100, Hans de Goede wrote:
> > I just realised there is an issue with the 
> > hwmon-f71882fg-11-separate-max-crit-alarm-and-beep.patch
> > patch.
> > 
> > It removes the temp#_alarm attributes (replacing them by temp#_max_alarm), 
> > which is fine for lm_sensors v3, but will cause a problem with lm_sensors v2, 
> > the "sensors" command from lm_sensors v2 will now give failed to read data for 
> > temp# for all 3 temps :(
> 
> Indeed. I admit I didn't think about lm_sensors v2 when reviewing your
> patch. This is probably a good reason to _not_ add support for new
> chips to lm_sensors v2. Owners of such recent hardware should really
> use lm_sensors v3 anyway.
> 
> > So it looks like we are sorta stuck with our past mistake of not doing separate 
> > alarms.
> > 
> > We could do separate alarms like this:
> > temp#_alarm
> > temp#_crit_alarm
> > 
> > This will work with both libsensors and with "sensors" from both v2 and v3.
> 
> It's a bit confusing due to the asymmetry, but I admit it should work
> fine in practice. Feel free to send an updated patch doing this.
> Including an explanation of why we do this, so that someone reading the
> code in 3 or 4 years can understand the idea behind it.

Do you have an update for this patch, please? I'd like to get all
f71882fg/f8000 patches sorted out today.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
