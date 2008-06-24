From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 24 Jun 2008 06:59:40 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.26-rc] ACPI Thermal Zone driver breaks
Message-Id: <20080624085940.3ee3bf77@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <fa.4PGqX9CuLbgiTimfCcon+PlAMxk@ifi.uio.no>
	<fa.PWu620xEt5OlYdOezvRtQriuNjM@ifi.uio.no>
	<48605935.5070407@shaw.ca>
	<alpine.LFD.1.10.0806232004480.2926@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.10.0806232004480.2926@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Robert Hancock <hancockr@shaw.ca>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Rene Herman <rene.herman@keyaccess.nl>, Hans de Goede <j.w.r.degoede@hhs.nl>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Linux Kernel <linux-kernel@vger.kernel.org>

Hi Linus,

On Mon, 23 Jun 2008 20:07:15 -0700 (PDT), Linus Torvalds wrote:
> On Mon, 23 Jun 2008, Robert Hancock wrote:
> > Mark M. Hoffman wrote:
> > > 2) This patch is broken.
> > 
> > You didn't indicate what was wrong with the patch.
> 
> Yes. Leaving everybody wondering whether it's just an opinionated 
> expression of the former problem, or whether there is a real and 
> understandable reason why it was NACK'ed.

I guess Mark assumed that everybody had read the discussion thread Rene
referenced, where I explained why his patch was broken:

http://lkml.org/lkml/2008/6/23/175

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
