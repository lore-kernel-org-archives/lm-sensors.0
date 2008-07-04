From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 04 Jul 2008 13:07:32 +0000
Subject: Re: [lm-sensors] PATCH: abituguru3-fix-detect.patch
Message-Id: <20080704150732.7165eadf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4836D061.9080501@hhs.nl>
In-Reply-To: <4836D061.9080501@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 04 Jul 2008 14:02:26 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Hi Hans,
> > 
> > On Thu, 03 Jul 2008 22:18:51 +0200, Hans de Goede wrote:
> >> Alistair John Strachan wrote:
> >>> After updating my BIOS (from 16 to 17) the driver has stopped loading
> >>> again. This is with 2.6.26-rc8. The reason is that the command byte has
> >>> changed value to 0xFF (this is reproducible across cold and warm starts).
> >>>
> >>> The following diff fixes it, but the "probe" is now looking even more creaky..
> >>>
> >> Ah what fun, well luckily I've added the DMI based check so the detection 
> >> routine is less important now.
> >>
> >> Mark, please apply.
> > 
> > I have to object. 0xff is the value you would get without a chip at
> > this address. So the change is roughly equivalent to not testing the
> > port at all... Plus, if the possible values change with every BIOS
> > update, we have to admit that the detection method isn't reliable. What
> > about switching to a DMI-based check? Not only checking the board
> > manufacturer but also the board product name. The abituguru3 driver
> > requires board-specific data anyway, so that's not a big change. And
> > there's always the "force" parameter to bypass the check for new boards.
> > 
> 
> I understand where you're coming from, but I have to object to switching to DMI 
> based detection. I would be happy to make that switch if and when I've got DMI 
> strings for all currently supporting motherboards. I can start working on 
> collecting those, but without those, switching to DMI based detection would 
> cause regressions which IMHO is unacceptable.
> 
> I agree that the 0xff check is not pretty, but please keep in mind that:
> 1) This driver normally is never autoloaded, so it either has to be compiled in
>     or explicitly loaded by the user (this is something where dmi based
>     detection would be a win as dmi based autoloading is possible).
> 
> 2) If someone has either compiled the driver in and/or loads it deliberately it
>     will still only load (without the force parameter) on Abit motherboards.
> 
> 3) After this simple read check, the driver does some reads from the chip
>     (which involve isa writes) and if these fail the driver doesn't load. Note
>     that these reads will most likely fail if there is no uguru3, as the uguru3
>     has a quite complex handshaking scheme.
> 
> So move to DMI based detection in the future, sure. But for now I would like to 
> see this patch applied.

Hmm, OK. I thought that you had these DMI strings handy already. If
not, please start collecting them now, so that the driver can be
switched to DMI-based detection in the future.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
