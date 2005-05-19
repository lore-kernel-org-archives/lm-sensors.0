From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: [PATCH] More i2c driver changes for 2.5.65
Message-Id: <20030325012923.GA10879@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10482950873871@kroah.com> <10482950921680@kroah.com> <20030325093550.GD1083@zaurus.ucw.cz>
In-Reply-To: <20030325093550.GD1083@zaurus.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

On Tue, Mar 25, 2003 at 10:35:50AM +0100, Pavel Machek wrote:
> Hi!
> 
> > +	.name		= "ADM1021-MAX1617",
> 
> Why dash here
> 
> > +	.name		= "LM75 sensor",
> 
> And space here? Also you should have 
> either 2x "sensor" or none at all. 

What do you mwan "2x"?  I just shortened that name up to fit within the
16 characters that we are allowed for driver names.  If you can come up
with some better ones, please let me know.

thanks,

greg k-h
