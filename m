From: greg@kroah.com (Greg KH)
Date: Tue, 25 Oct 2005 19:27:33 +0000
Subject: [lm-sensors] Re: [patch 0/9] I2C: remove i2c_driver's .owner and
Message-Id: <20051025172645.GB20644@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051024212201.485176000@antares.localdomain>
In-Reply-To: <20051024212201.485176000@antares.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 25, 2005 at 03:13:07PM +0200, Jean Delvare wrote:
> 
> Hi Laurent,
> 
> On 2005-10-25, Laurent Riffard wrote:
> > i2c_driver and i2c_driver.driver both have "owner" and "name"
> > field.  One should go - there's no point needlessly duplicating
> > stuff like this.
> 
> Looks alright to me, I'll merge this in my tree and will send it to Greg
> quickly.
> 
> Greg, can you please confirm you are fine with this change?

Yes I am, I made the same changes to the usb-serial core last week :)

thanks,

greg k-h
