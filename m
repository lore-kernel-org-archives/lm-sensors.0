From: Greg KH <greg@kroah.com>
Date: Tue, 11 Nov 2008 06:26:55 +0000
Subject: Re: [lm-sensors] [PATCH 2/5] i5k_amb: Load automatically on all
Message-Id: <20081111062655.GI13156@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081107185621.13022.61885.stgit@elm3a70.beaverton.ibm.com> <20081107185631.13022.59600.stgit@elm3a70.beaverton.ibm.com> <20081108120950.397a3165@hyperion.delvare>
In-Reply-To: <20081108120950.397a3165@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Kay Sievers <kay.sievers@vrfy.org>

On Sat, Nov 08, 2008 at 12:09:50PM +0100, Jean Delvare wrote:
> Hi Darrick,
> 
> On Fri, 07 Nov 2008 10:56:31 -0800, Darrick J. Wong wrote:
> > It turns out that we cannot create a pci_driver in this driver because PCI will
> > not call this module's probe function if the i5000-edac driver is already
> > loaded.
> 
> I seem to recall work in progress to let multiple drivers bind to the
> same PCI device. Greg, Kay, what's the status?

Hannes provided me with a bunch of patches, some of which applied, some
didn't.  I had to back some of them out as they were wrong, and I need
to revisit them when I get a chance :(

thanks,

greg k-h

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
