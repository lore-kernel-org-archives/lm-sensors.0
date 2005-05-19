From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: probe order for 2.6 sensor chips
Message-Id: <3F47C32C.6010407@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030811204839.GA18442@kroah.com>
In-Reply-To: <20030811204839.GA18442@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is a demonstration/debugging driver I wrote to test SMBus 2.0 support.

Until we support Host Notify (host-as-slave mode),
we can't really support hotplugged I2C devices well.

I don't recommend submitting it to 2.6 unless somebody asks for it.


http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/doc/chips/smbus-arp

Greg KH wrote:
> On Tue, Aug 12, 2003 at 12:09:01AM +0200, Jean Delvare wrote:
> 
>>>I have a port of smbus-arp to 2.6 in my local kernel tree, I just need
>>>to clean it up to get it into shape to add to the main kernel.org tree
>>>one of these days...
>>
>>BTW what does this driver do? If I understand it correctly, it is meant
>>to replace our blind bus scanning by proper querying of an ARP chip? Or
>>am I just lost again?
> 
> 
> I do not really know either.  I tried to see what it was doing and
> couldn't easily determine it.  I have a laptop here that suposidly needs
> it to get some other i2c driver to work, but I've never gotten it to
> work properly yet on 2.6...
> 
> greg k-h
> 
