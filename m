From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [PATCH 2.6] I2C: sysfs names: rename to cpu0_vid
Message-Id: <20050511074911.GC10647@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
In-Reply-To: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 11, 2005 at 09:31:50AM +0200, Jean Delvare wrote:
> > > Tag the old ones as "to remove after <some date>". Also, a patch to
> > > libsensors to accept the new names is obviously needed.
> >
> > What sort of timeframe you suggest for remove after?
> 
> Hmm, 6 months after the original change maybe?

Just be sure to document it in
Documentation/feature-removal-schedule.txt and everyone will be happy :)

thanks,

greg k-h
