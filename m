From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH 2.6] I2C: sysfs names: rename to cpu0_vid
Message-Id: <20050510183821.GA2368@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
In-Reply-To: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 10, 2005 at 08:30:31PM +0200, Jean Delvare wrote:
> Hi Grant,
> 
> > This small patch changes two drivers, adm1025 and adm1026, to 
> > report vid as cpu0_vid sysfs name as used by the other drivers.
> 
> This patch (alone) doesn't please me. For one thing, you should
> duplicate, not rename, the attributes, so as to not break compatibility.
> Tag the old ones as "to remove after <some date>". Also, a patch to
> libsensors to accept the new names is obviously needed.

Ok, I've now dropped this one.

thanks,

greg k-h
