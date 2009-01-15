From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 15 Jan 2009 15:22:45 +0000
Subject: Re: [lm-sensors] [PATCH 0/2] hwmon: (abituguru3) Partial DMI
Message-Id: <20090115162245.23e5c5ba@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1231865798-12187-1-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1231865798-12187-1-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alistair,

On Tue, 13 Jan 2009 16:56:36 +0000, Alistair John Strachan wrote:
> These patches have been compile and runtime tested.
> 
> The first patch implements the partial DMI matching we discussed, hopefully
> this method will prevent any further false negatives (thanks to Jean for
> his input on the method chosen).
> 
> The second patch adds a partial DMI board string for the IN9 32X MAX,
> enabling DMI board string matching. It depends on the first patch.
> 
> Both of these could go upstream; the first can definitely be considered a
> bugfix, the second is more dubious, but since I've rebased it on the first
> it could be applied later if required.

Yes, I will push these patches upstream later today.

> (One remaining question would be whether patch 1 should be CCed to -stable,
>  since there has been a regression introduced into 2.6.27 and present in
>  2.6.28 for some BIOS revisions of the IP35 Pro.)

Is there really a regression? If the DMI matching doesn't work, we fall
back to the old detection method, so I can't see how there would be a
regression. Care to explain?

(Which doesn't mean we can't push the patches to stable, as stable
isn't limited to regressions. Just trying to understand.)

Speaking of DMI matching... If DMI is disabled, we do:

static inline int abituguru3_dmi_detect(void)
{
	return -ENODEV;
}

And this error value causes abituguru3_init() to bail out. Unless I'm
missing something, the abituguru3 driver is simply useless without DMI
support at the moment. We should either make that official and make the
driver depend on DMI at Kconfig level, or change
abituguru3_dmi_detect() to return 1, so that we fallback to the old
detection method. Opinions?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
