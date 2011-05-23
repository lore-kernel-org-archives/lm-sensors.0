From: Jeff Rickman <jrickman@myamigos.us>
Date: Mon, 23 May 2011 14:15:50 +0000
Subject: Re: [lm-sensors] Updated emc6w201 driver
Message-Id: <4DDA6C16.7060108@myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110522102625.7e065405@endymion.delvare>
In-Reply-To: <20110522102625.7e065405@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 5/22/2011 3:26 AM, Jean Delvare wrote:
> Hi Harry, hi Jeff,
>
> I just updated the driver at:
>    http://khali.linux-fr.org/devel/misc/emc6w201/
>
> Changes in this version:
> * All limits can be changed.
>
> Basically this means you can now add "set" statements to your
> configuration file to adjust the limits as needed. If I remember
> correctly, voltage as well as high temperature limits were already good
> from the BIOS so you shouldn't have to change them. Fan limits were
> pretty low so you may want to adjust them, same for low temperature
> limits.
>
> Beware though: the monitoring chip may be configured and wired to take
> action on out-of-limits events. The low temperature limits may have
> been disabled by Dell on purpose, so that temperature alarms can only
> reflect over-temperature conditions and appropriate action can be
> taken (e.g. speeding up all fans, beeping or shutting the system down.)
> So you should be prudent when changing the limits.
>
> Feedback welcome. I intend to prepare a patch based on this version of
> the driver and submit it for inclusion in the upstream kernel.
>

No issues at all with setting "min" and "max" limits on voltages. I used 
the customary +/- 10 percent limits.

No issues setting "min" value of "0" on temperatures; defaults were 
negative values in some cases. Setting a "min" value between 10 and 20 
would be more reasonable for most PCs.

I did not try to set limits on fans, but I suspect they would work ;-)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
