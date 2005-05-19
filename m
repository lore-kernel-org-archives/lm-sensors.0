From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6.12-rc4 2/3] (dynamic sysfs callbacks) device_attribute
Message-Id: <20050511170428.GC15398@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <253818670505110057b96cf62@mail.gmail.com>
In-Reply-To: <253818670505110057b96cf62@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 03:57:29AM -0400, Yani Ioannou wrote:
> Hi,
> 
> This second patch removes the "initialization from incompatible
> pointer type" warnings resulting from the code using the old callback
> function signatures. It is mainly auto-generated (see inlined
> shell/perl scripts below), and is 308K so I'm linking to it:
> 
> http://osdn.dl.sourceforge.net/sourceforge/bmcsensors-26/patch-linux-2.6.12-rc4-sysfsdyncallback-deviceattr-nowarn.diff
> 
> Note that the diffstat # of changes (approx # of sysfs callbacks)
> gives you some idea of which drivers will most benefit from this
> patch.
> 
> Signed-off-by: Yani Ioannou <yani.ioannou@gmail.com>
> 

Sorry, but I need a real patch in email form so I can apply it.  I can
handle a 300K+ email :)

Or you can break it up into smaller pieces, like one per major part of
the kernel.  That is the preferred way.

thanks,

greg k-h
