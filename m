From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: 2.8.1
Message-Id: <20031026183222.GB2294@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F6484BA.24E78516@paradyne.com>
In-Reply-To: <3F6484BA.24E78516@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Oct 26, 2003 at 07:26:01PM +0100, Jean Delvare wrote:
> 
> Hi Axel, hi all,
> 
> I just uploaded new i2c patches for the Linux 2.4.22 kernel based on the
> freshly released 2.8.1 i2c.

Uploaded where?

Care to send it to the list (and cc me, as I'm not keeping up on my
sensors traffic due to Real Life stuff right now...)?

> This patchset will be the base of the patch I'll post to the LKML for
> inclusion.

It needs to be a set of incremental patches, that do not break the API
for any current drivers.  Hm, it's also a bit late in the 2.4.23-pre
series to expect to get this in, but we can work on that.

thanks,

greg k-h
