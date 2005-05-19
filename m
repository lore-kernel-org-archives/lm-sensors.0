From: grundler@parisc-linux.org (Grant Grundler)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: M7101
Message-Id: <20050207034219.GA5620@colo.lackof.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41DC59A4.1070006@web.de> <20050206152615.1ab7498c.khali@linux-fr.org>
In-Reply-To: <20050206152615.1ab7498c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Enrico Bartky <DOSProfi@web.de>, linux-pci@atrey.karlin.mff.cuni.cz, LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>, Maarten Deprez <maartendeprez@scarlet.be>, Greg KH <gregkh@suse.de>

On Sun, Feb 06, 2005 at 03:26:15PM +0100, Jean Delvare wrote:
> Maarten Deprez then converted it to the proper kernel coding-style:
> http://marc.theaimsgroup.com/?l=linux-kernel&m0726276414532
..
> Any chance we could get the PCI folks to review the code and push it
> upwards if it is OK?

I'm not the maintainer, but it looks fine to me except for use
of numeric constants (e.g 0x5f, 0x18) instead of adding #defines
to name the values. But if no one knows what those offsets are for
we'll just have to leave it.


> For reference, here are links to the original m7101 unhiding driver code
> and help file:
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/hotplug/m7101.c

Unfortunately, I didn't anything documenting 0x5f and 0x18.

Will m7101.c be modified once quirks enabling the device?

hth,
grant
