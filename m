From: gregkh@suse.de (Greg KH)
Date: Fri, 17 Mar 2006 23:08:10 +0000
Subject: [lm-sensors] I2C-virtual and locking?
Message-Id: <20060317230810.GA3192@suse.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <6CCFFBB4-CDE0-4DC0-A4D7-A3E7398B2494@kernel.crashing.org> <7A19BA6C-6308-4DFC-B70D-A0AE0E144B59@kgala.com>
In-Reply-To: <7A19BA6C-6308-4DFC-B70D-A0AE0E144B59@kgala.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kumar Gala <kumar@kgala.com>
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org, linux kernel mailing list <linux-kernel@vger.kernel.org>

On Fri, Mar 17, 2006 at 03:16:58PM -0600, Kumar Gala wrote:
> 
> On Mar 17, 2006, at 12:54 PM, Kumar Gala wrote:
> 
> >I'm looking at porting the i2c-virtual code from 2.4 to 2.6.  One  
> >thing I'm not clear on is the use of i2c_add_adapter_nolock() by  
> >the old code.  The only reference I can find related to this is:
> >
> >http://archives.andrew.net.au/lm-sensors/msg31060.html
> >
> >I can't think of a reason why locking would be in issue when adding  
> >or removing of a virtual adapter.  Anyone have an additional ides  
> >on this?
> 
> Ok, so I figured out why the _nolock() versions exist.  In  
> i2c_driver_register we take the core_list lock.  Eventually we will  
> call i2c_probe() which should call driver->attach_adapter().  For a  
> virtual bus the driver's attach_adapter() will end up calling  
> i2c_virt_create_adapter() which will end up calling i2c_add_adapter()  
> which will never get the core_list lock.
> 
> So should we integrate the concept of virtual adapters into the i2c  
> core and have it such that i2c_virt_create_adapter()/ 
> i2c_virt_remove_adapter() expects the caller to have the core_list  
> lock already?

Possibly.  Jean, what do you think?

thanks,

greg k-h

