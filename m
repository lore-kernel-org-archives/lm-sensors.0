From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Sun, 14 Jun 2009 07:45:26 +0000
Subject: Re: [lm-sensors] [PATCH 0/3] hwmon: (abituguru3) DMI probing on
Message-Id: <200906140845.26292.alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1244913674-9633-1-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1244913674-9633-1-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sunday 14 June 2009 08:22:27 Hans de Goede wrote:
> On 06/13/2009 07:21 PM, Alistair John Strachan wrote:
> > Salut Jean,
> >
> > These patches have been compile and runtime tested.
> >
> > They switch AB9, AB9 QuadGT and IX38 QuadGT mainboards over to using
> > the DMI probe method. The testers have been credited appropriately.
> >
> > (The driver currently supports 17 models, 7 are now using DMI.)
>
> Hi,
>
> All 3 look good to me, although I did notice 2 have a common prefix,
> we have some code to handle this in place, right ?

Yes, Jean pointed this out last time and now we just chop the bit we don't 
care about off (find first open bracket, trim any preceding spaces), and 
compare only exact strings (length must match, non case-sensitive strings must 
match).

Should all work fine, but I sent the strings separately in case there are 
regressions.

-- 
Cheers,
Alistair.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
