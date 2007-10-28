From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Oct 2007 19:03:52 +0000
Subject: Re: [lm-sensors] svn commit: r4959 -
Message-Id: <20071028200352.1fc445f1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071019232531.3c767d99@hyperion.delvare>
In-Reply-To: <20071019232531.3c767d99@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 28 Oct 2007 14:16:11 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > I'm not sure what exactly is parsed in the kernel. It seems that it's
> > only extracting a couple identification strings and specific data and
> > doesn't give you access to arbitrary record data. So you'll probably
> > have to add your own FSC-specific handler, and to find a way to export
> > the data. Not sure if that will be accepted upstream.
> 
> You are right, so of to userspace we go.
> 
> This brings us to 2 questions:
> 1) What to use as conversion / divider in the driver? I see 2 options:
>   a) Use the fscpos datasheet divider everywhere
>   b) Use the fscpos datasheet divider for the fscpos and others which lack
>      the DMI info, and use the old fscher divider / multiplier of 10 mv / step
>      for those with DMI data.
> 
>   I must say I do not have much preference a) leads to a somewhat simpler
>   driver, b) means that the old configs will stay working even when switching to
>   the fschmd driver. So which one will it be>

Option b) gets my favor. First reason is that it preserves compatibility
with the old drivers. Second reason is that you will otherwise have to
undo the scaling in user-space for the Hermes chip, before you apply
the one from the DMI table, which is a bit confusing.

One problem with this approach is that we need to know what to do for
the Heimdall and Heracles chips right now. Changing teh way we handle
them at a later point would only add to confusion.

I agree that it's not so nice. Really, too bad that you can't (easily)
get the DMI data from the kernel, that would have made things much
nicer. I'm wondering if it wouldn't be worth giving it a try anyway. If
dmi_scan_machine() was not __init and could take a record handler as a
parameter (as dmi_table does) then it would be possible to access and
process arbitrary DMI records from various kernel drivers even after
boot. I'm curious if other drivers would benefit from that or if your
fschmd driver is an isolated case.

> 2) How? I can write a specific utility to spit out the conversion formulas (I
>   guess that is where I'll start). But at the end we may want to include this in
>   sensors-detect. However currently sensors-detect does not touch sensors.conf,
> 
>   I guess its best to for now write a userspace utility which generates the
>   conversion formulas for users, and integrate this into sensors-detect when we
>   integrate dmi-based autoconfig into it.

Agreed. For now you can simply add a note in the default sensors.conf
file, pointing the user to your user-space tool for chips which need it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
