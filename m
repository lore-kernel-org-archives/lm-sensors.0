From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: probe order for 2.6 sensor chips
Message-Id: <20030811223057.GB18984@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030811204839.GA18442@kroah.com>
In-Reply-To: <20030811204839.GA18442@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 12, 2003 at 12:09:01AM +0200, Jean Delvare wrote:
> 
> > I have a port of smbus-arp to 2.6 in my local kernel tree, I just need
> > to clean it up to get it into shape to add to the main kernel.org tree
> > one of these days...
> 
> BTW what does this driver do? If I understand it correctly, it is meant
> to replace our blind bus scanning by proper querying of an ARP chip? Or
> am I just lost again?

I do not really know either.  I tried to see what it was doing and
couldn't easily determine it.  I have a laptop here that suposidly needs
it to get some other i2c driver to work, but I've never gotten it to
work properly yet on 2.6...

greg k-h
