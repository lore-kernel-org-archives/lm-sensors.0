From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: i2cdetect -l is broken
Message-Id: <20040213224615.GA16107@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040211213013.19dccfee.khali@linux-fr.org>
In-Reply-To: <20040211213013.19dccfee.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Feb 13, 2004 at 08:05:09PM +0100, Jean Delvare wrote:
> BTW: Now that I come to think of it, no, it doesn't work. It works in
> your specific case because this isn't a PCI adapter. See these trees
> with a PCI adapter instead:
> 
> i2c-dev
> |-- i2c-0
> |   |-- dev
> |   |-- device -> ../../../devices/pci0000:00/0000:00:04.4
> |   `-- driver -> ../../../bus/pci/drivers/vt596 smbus
> `-- i2c-1
>     |-- dev
>     |-- device -> ../../../devices/platform/i2c-1
>     `-- driver -> ../../../bus/i2c/drivers/i2c_adapter
> 
> 6 directories, 2 files
> i2c-adapter/
> |-- i2c-1
> |   |-- device -> ../../../devices/platform/i2c-1
> |   `-- driver -> ../../../bus/i2c/drivers/i2c_adapter
> `-- i2c-2
>     |-- device -> ../../../devices/pci0000:00/0000:00:04.4/i2c-2
>     `-- driver -> ../../../bus/i2c/drivers/i2c_adapter

Hm, good point.  Yeah, that's not nice :(

> > Ok, can you come up with a patch that might solve this?
> 
> I don't think I can. I don't know anything about sysfs, and I don't know
> anything about how the 2.4 drivers where handling the problem. I'm
> probably the less qualified among us all for that task.

It's not a sysfs issue, it's an issue with the following line in
i2c_add_adapter():
	adap->nr = nr++;

We need to be smarter about how to number our adapters instead of just
picking the next number.  Something that matches the logic in
get_free_i2c_dev() in i2c-dev.c.

Or we can modify i2c-dev.c to use the adapter number in it's device id.
But if we do that we will eventually run out of minor numbers if we
insert and remove adapters all of the time...

Any opinions on which would be better?

thanks,

greg k-h
