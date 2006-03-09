From: greg@kroah.com (Greg KH)
Date: Thu, 09 Mar 2006 16:09:11 +0000
Subject: [lm-sensors] [PATCH] Add voltage support to W83627EHF
Message-Id: <20060309160911.GA27795@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409700D.8010604@sh.cvut.cz>
In-Reply-To: <4409700D.8010604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 08, 2006 at 02:13:30PM +0100, Jean Delvare wrote:
> 
> The only data I am missing now is the memory used by each additional
> sysfs file we create. We need to know, as Hans objected that too many
> sysfs files could have a negative impact on memory consumption. I dug
> down the sysfs code yeterday evening to find out, but didn't find what
> I was looking for yet. I hope to get the answer this evening.

sysfs files are very light.  The "large" memory structures for a ram
based file system are the dentry and inode structures.  sysfs now
creates them on the fly when they are needed, and if we have memory
pressure on our internal kernel caches, they are freed.

So in short, don't worry about creating new sysfs files, it's not an
issue.  The people running 20,000 disks on a 31bit s390 system have
already done the hard work for you :)

thanks,

greg k-h

