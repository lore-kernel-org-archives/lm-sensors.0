From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: [PATCH 2.4] Trivial changes to I2C stuff
Message-Id: <20031122180818.GA3378@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031122161510.7d5b4d20.khali@linux-fr.org> <20031122164907.GA3121@kroah.com> <20031122183617.18149a3d.khali@linux-fr.org>
In-Reply-To: <20031122183617.18149a3d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sensors@stimpy.netroedge.com
Cc: marcelo@cyclades.com, linux-kernel@vger.kernel.org

On Sat, Nov 22, 2003 at 06:36:17PM +0100, Jean Delvare wrote:
> > Woah, -rc3 is _way_ too late for patches such as this.
> 
> "Patches like this"? A patch could hardly do less (real) things than
> this one. What's the problem? I thought -rc were a perfect place for
> these kind of cleanup changes.

Only _critical_ fixes are allowed during the -rc cycle.  These are stuff
like bugfixes, not whitespace cleanups.

thanks,

greg k-h
