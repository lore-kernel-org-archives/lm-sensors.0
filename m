From: adrian@humboldt.co.uk (Adrian Cox)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: [PATCH][2.6] Add command function to struct i2c_adapter
Message-Id: <1095868579.18365.105.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <414F111C.9030809@linuxtv.org>
	 <20040921154111.GA13028@kroah.com> <41506099.8000307@web.de>
	 <41506D78.6030106@web.de> <1095843365.18365.48.camel@localhost>
	 <20040922102938.M15856@linux-fr.org> <1095854048.18365.75.camel@localhost>
	 <20040922122848.M14129@linux-fr.org>
	 <9e47339104092208403d9de6f4@mail.gmail.com>
In-Reply-To: <9e47339104092208403d9de6f4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, sensors@stimpy.netroedge.com, Michael Hunold <hunold-ml@web.de>, Greg KH <greg@kroah.com>

On Wed, 2004-09-22 at 16:40, Jon Smirl wrote:

> Any DDC solution needs to leave the data visible in sysfs and
> accessible from user space. I'm trying to move the EDID parsing code
> out of the kernel.

Would it do for a display device to expose read-only EDID data through
sysfs, or do you need I2C level access to DDC from userspace?

- Adrian Cox
Humboldt Solutions Ltd.

