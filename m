From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: [Fwd: i2c-proc correction]
Message-Id: <3D78E1D0.FB57803C@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Don't know - anybody?

Alexander Viro wrote:
> 
> On Thu, 5 Sep 2002, Mark D. Studebaker wrote:
> 
> > removed from i2c-proc.c. As the comments say, the code prevents module
> > unloading
> > if the /proc files are in use.
> 
> So does setting ->owner on them.
> 
> > Why is this a bad thing?
> 
> Because module has no business messing with its own reference count.
> 
> > Is there a better way to do it?
> 
> See above.

Does Al mean we already do the right thing in i2c-dev.c:89
static struct file_operations i2cdev_fops {
owner:  THIS_MODULE,

and i2c-dev.c:495 int __init i2c_dev_init
...
if (register_chrdev(I2C_MAJOR, "i2c", &i2cdev_fops))

If so, we need to find a method to verify his statement.
Oh, Linus applied the reverse patch for this to 2.5.34.
Albert
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net

=======================================================-------------- next part --------------
An embedded message was scrubbed...
From: "Mark D. Studebaker" <mds@paradyne.com>
Subject: Re: i2c-proc correction
Date: Thu, 05 Sep 2002 22:51:55 -0400
Size: 3956
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020906/5bb14f76/attachment.mht
