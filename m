From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: M7101
Message-Id: <20050212195205.1d89f3d2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41DC59A4.1070006@web.de>
	<20050206152615.1ab7498c.khali@linux-fr.org>
	<20050207034219.GA5620@colo.lackof.org>
In-Reply-To: <20050207034219.GA5620@colo.lackof.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Enrico Bartky <DOSProfi@web.de>, linux-pci@atrey.karlin.mff.cuni.cz, LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>, Maarten Deprez <maartendeprez@scarlet.be>, Greg KH <gregkh@suse.de>

Hi,

> Will m7101.c be modified once quirks enabling the device?

m7101.c is for 2.4 kernels while the proposed quirk is to be merged into
2.6 kernels, so m7101.c will still be needed as is. That said, if
cleanups are made on the way to 2.6 and someone offers a patch that
ports these cleanups back to m7101.c, I'll be happy to apply it, of
course.

Thanks,
-- 
Jean Delvare
