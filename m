From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6] I2C: sysfs names: rename to cpu0_vid, take 2
Message-Id: <20050511222559.GA12115@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
In-Reply-To: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 12, 2005 at 08:21:39AM +1000, Grant Coady wrote:
> On Wed, 11 May 2005 19:54:29 +0200, Jean Delvare <khali@linux-fr.org> wrote:
> 
> >> This small patch changes two drivers, adm1025 and adm1026, to 
> >> report vid as cpu0_vid sysfs name as used by the other drivers.
> >> 
> >> Added duplicated names and six month warning for old names to 
> >> be removed as requested.  Compile tested.
> >
> >The patch is fine but doesn't apply to my tree. Could you possibly
> >regenerate it against 2.6.12-rc4?
> 
> Yes, but no point including Documentation/feature-removal-schedule.txt 
> patch as that file way behind in 2.6.12-rc4 compared to rc3-mm3

What do you mean?  Who knows if those changes will make it into a later
kernel.  Patching against 2.6.12-rc4 allows me to accept the patch,
which will put it into the -mm tree.  Please do that.

thanks,

greg k-h
