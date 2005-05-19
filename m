From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: 2.8.1
Message-Id: <20031104170123.GB28105@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F6484BA.24E78516@paradyne.com>
In-Reply-To: <3F6484BA.24E78516@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Oct 26, 2003 at 07:52:48PM +0100, Jean Delvare wrote:
> > > This patchset will be the base of the patch I'll post to the LKML
> > > for inclusion.
> > 
> > It needs to be a set of incremental patches, that do not break the API
> > for any current drivers.  Hm, it's also a bit late in the 2.4.23-pre
> > series to expect to get this in, but we can work on that.
> 
> Take a look at the above-mentioned page, the patch is splitted over
> logical units. I guess that's how you expect things to be.

Is it split up into small, incremental patches, each patch only doing
one thing?  That is what is going to be required if it will be accepted
into the kernel tree.

thanks,

greg k-h
