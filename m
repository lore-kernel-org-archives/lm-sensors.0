From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: [rol@as2917.net: Need help for kernel 2.5.x ???]
Message-Id: <20030623133221.GA8108@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030622185659.GB2380@frodo.local>
In-Reply-To: <20030622185659.GB2380@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jun 23, 2003 at 09:01:44AM +0200, Paul Rolland wrote:
> Hello,
> 
> > The version is already built into the 2.5 kernel.  So select 
> > the i2c driver options in that kernel and see how well they work.
> > 
> Yes, I2C are present, and I have them available within sysfs.

Great, glad it's working for you.

> My mail was motivated by :
>  - I can't find anymore i2c within /proc/bus or anywhere else
>    within /proc and it seems that lm_sensors tools are still
>    looking for something there.
>  - the home page was related to libsensors.a and not to i2c sensors
>    and I was thinking that libsensors was the stuff that new where 
>    to get the details in the system (thus switching from /proc to 
>    sysfs should be in libsensors for user space application), and
>    I was ready to give it a try.
> 
> Sorry I badly understood.

No, you are correct, the lmsensors library doesn't currently support the
move to /sys.  We don't have a updated version yet, and the webpage is
asking for people to help out in doing that development.  Unfortunatly
there is nothing to help test out yet.

If you can do any development on the conversion, it would be greatly
appreciated.

thanks,

greg k-h
