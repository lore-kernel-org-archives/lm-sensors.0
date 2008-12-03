From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 03 Dec 2008 15:37:00 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fschmd-watchdog-v4.patch
Message-Id: <20081203163700.2e78f29d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <493007E2.4070101@redhat.com>
In-Reply-To: <493007E2.4070101@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Wed, 03 Dec 2008 13:19:36 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > Hi Hans,
> > 
> > On Fri, 28 Nov 2008 16:01:54 +0100, Hans de Goede wrote:
> >> Hi Jean,
> >>
> >> Today I had access to my FSC test machine for the first time in a while. So 
> >> here is the latest version of my watchdog support for Siemens hwmon IC's patch. 
> >> This fixes the last 2 issues you spotted during review. Can you please queue 
> >> this for 2.6.29 ? If Wim comes up with anything during his review I'll fix that 
> >> with a follow up patch,
> > 
> > Applied, thanks. Now I'm waiting for the patch which deprecates fscher
> > and fscpos :)
> > 
> 
> Attached (to be applied on top of the previous 2 fschmd patches).

Looks good, with minor issues (which I fixed myself):

> Now that the new merged fschmd driver has gained support for the watchdog
> integrated into these IC's, there is no more reason to keep the old fscher and
> fscpos drivers around, so mark them as depcrated.

Typo: deprecated.

> -	  This is a new merged driver for FSC sensor chips which is intended
> -	  as a replacement for the fscpos, fscscy and fscher drivers and adds
> -	  support for several other FCS sensor chips.
> +	  This is a merged driver for FSC sensor chips replacing the fscpos,
> +	  fscscy and fscher drivers and adding support for several other FCS
> +	  sensor chips.

You certainly mean FSC not FCS.

Additionally, I think it would be a good idea to have an entry for this
in Documentation/feature-removal-schedule.txt, so that it doesn't get
overlooked. I suggest to schedule the removal in 6 months from now, so
June 2009. OK?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
