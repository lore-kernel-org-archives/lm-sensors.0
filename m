From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: 2.6.3rc4 ali1535 i2c driver rmmod oops.
Message-Id: <20040224002703.GB24225@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218031544.GB26304@redhat.com> <20040218040153.GB6729@kroah.com> <20040221081953.60fe4165.khali@linux-fr.org>
In-Reply-To: <20040221081953.60fe4165.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@stimpy.netroedge.com
Cc: davej@redhat.com, linux-kernel@vger.kernel.org

On Sat, Feb 21, 2004 at 08:19:53AM +0100, Jean Delvare wrote:
> > Oh nevermind, that's just a dumb driver.  It's doing a release_region
> > on memory it didn't get.  Stupid, stupid, stupid...
> 
> While we're at it, what about fixing two other drivers that obviously
> have the same problem?
> 
> (BTW I didn't get an oops as I tried reproducing the problem, only a
> "Trying to free nonexistent resource" in dmesg.)
> 
> I'm backporting these fixes to the lm_sensors2 CVS repository at the
> moment, thanks for pointing them out.

Applied, thanks.

greg k-h
