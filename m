From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: i2cdetect -l is broken
Message-Id: <20040211230349.GA14924@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040211213013.19dccfee.khali@linux-fr.org>
In-Reply-To: <20040211213013.19dccfee.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Feb 11, 2004 at 09:30:13PM +0100, Jean Delvare wrote:
> Hi all,
> 
> i2cdetect -l is broken on drivers which handle more than a single i2c
> bus (radeonfb in my case). It'll print the same name for all busses, and
> shouldn't.
> 
> I took a look at the sysfs tree and I couldn't find any way to correct
> it. The fact that i2c-adapters and i2c-devs don't use the same numbering
> policy doesn't give us much chance.

But what about the linkages:

$ tree /sys/class/i2c-dev/
/sys/class/i2c-dev/
`-- i2c-0
    |-- dev
    |-- device -> ../../../devices/platform/i2c-0
    `-- driver -> ../../../bus/i2c/drivers/i2c_adapter

$ tree /sys/class/i2c-adapter/
/sys/class/i2c-adapter/
`-- i2c-0
    |-- device -> ../../../devices/platform/i2c-0
    `-- driver -> ../../../bus/i2c/drivers/i2c_adapter


You can match these devices up by looking at the 'device' symlink.  This
works no matter what numbering scheme there currently is, right?

> As far as I can tell, i2c-adapters numbering policy is to use N+1 for a
> new adapter, where N is the biggest number already use at the moment,
> while i2c-devs numbering policy is to use the lowest available.

I think this is the same for 2.4, meaning the same problem is there too,
right?  But for 2.4, you don't have the sysfs linkage to help you out.
How do you solve the problem there?

thanks,

greg k-h
