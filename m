From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6] I2C: sysfs names: rename to cpu0_vid
Message-Id: <20050511170059.GB15398@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
In-Reply-To: <hi6m71d93atlu1pci6jmqmt5ob58t6n0i8@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 11, 2005 at 09:50:18AM +0200, Jean Delvare wrote:
> 
> Hi Greg,
> 
> > > Hmm, 6 months after the original change maybe?
> >
> > Just be sure to document it in
> > Documentation/feature-removal-schedule.txt and everyone will be happy :)
> 
> I didn't know such a file even existed, but it sounds like a good idea.
> This shouldn't prevent us from tagging the lines in the driver itself,
> as I believe people (including us) are more likely to read it there.

We will notice it there.  But the "public" will not.  That is why we
created that file :)

thanks,

greg k-h
