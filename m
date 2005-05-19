From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: Ref ticket 755 - an apology
Message-Id: <3C1FD73F.A273D506@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.21.0112161656550.7306-100000@axp0.ast.man.ac.uk>
In-Reply-To: <Pine.OSF.4.21.0112161656550.7306-100000@axp0.ast.man.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

you are right, you need 2443.
If you can't find an option in the BIOS for ACPI or something similar,
you are stuck. You sure there's no ACPI option?

Then your last alternative is to write a program
that will enable it  - this will be difficult - see prog/hotplug
for an example.

mds



Richard James wrote:
> 
> Since replying to your email concerning this ticket, I realised to my
> embarrassment that I had made a real tyro's error in that I had added
> devices in the wrong part of the i2c-i801.c file - actually in the comment
> section!  I can only apologise for being so stupid and hope that I have
> not wasted your time.
> 
> I have of course repaired this error but regret to say that it has made no
> difference to the outcome.  I inserted every pci device in the table in
> the static int supported[]  array.  Looking at the output of lspci -n and
> comparing with that of lspci it seems that all the pci devices are
> accounted for.  The missing device is 0x2443 - it must exist as the bios
> can find it, but I suspect that the bios not activating it.  I have of
> course flashed with the latest version (1005) of the bios but this had
> no effect.
> 
>                 Yours sincerely,
> 
>                         Richard James.
