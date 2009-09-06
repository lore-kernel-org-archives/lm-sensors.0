From: Rune Svendsen <runesvend@gmail.com>
Date: Sun, 06 Sep 2009 15:05:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (abituguru3) Support multiple DMI
Message-Id: <1252249537.3565.16.camel@runescomp>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252170780-4141-1-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1252170780-4141-1-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
[snip]
> 
> There's a bit of history associated with the DMI message. Before I added DMI 
> support to the driver the legacy probe method (which doesn't really work at 
> all on IP35 Pro) was used to detect the other 20-or-so supported mainboards.
> On a lot of the boards in this list, this detection is reliable, and the 
> message I added was a useful helper to get people to send in their DMI info.
> 
> Unfortunately your case has fallen through the cracks of obscurity where both 
> DMI was broken (because of a bug) and legacy probing didn't work (because it 
> doesn't work on IP35 Pro). You board appears to the driver to be just like any 
> other unsupported hardware.
> 
> You're right that it's suboptimal there are no kernel messages displayed, but 
> consider the distro/script case where driver loading may be attempted 
> automatically on unsupported hardware. In this case it is customary for Linux 
> drivers to reject the modprobe with -ENODEV but *not* print a message. 
> Printing a verbose one about sending DMI info to the uguru maintainer would 
> certainly not be desirable!
> 
> So yes, it's not perfect, and maybe we could improve it a la "if it's an Abit 
> board, the message could be printed" but anything you do is really just a 
> heuristic.
> 
Ah, ok, I see what the problem is now. I didn't get the message because
for all abituguru3 knew, I didn't have an Abit motherboard. That makes
sense.
Well the good news would then be that by adding the IP35 Pro XE to pass
the DMI string test, there are no more IP35 Pro models left. So if the
legacy probing method is only non-functional for IP35 Pro boards, then
an Abit board should pass either of the two tests now.
(There are still several non-"Pro" "IP35" Abit boards left though: IP35,
IP35P, IP35V, IP35-E. But if it _is_ only the "Pro" models that are
incompatible with the legacy probing method, this issue should be
solved.)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
