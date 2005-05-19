From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: [PATCH 2.4] i2c cleanups
Message-Id: <20031219190102.GB4468@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031213191258.2d78a9f7.khali@linux-fr.org>
In-Reply-To: <20031213191258.2d78a9f7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Dec 17, 2003 at 11:50:53PM +0200, Ky?sti M?lkki wrote:
> 
> For kernel 2.6: kobjects. This is the essentials of driver-model and
> sysfs allowing a tree-like topology of devices and drivers. Reference a
> device on the bus, and its driver and parent device are also referenced.
> In turn, this would obsolete .owner if driver-model gets more thoroughly
> implemented during 2.7 cycle. I have some compiling and running code for
> that, will post for review on holidays.

No, kobjects have _nothing_ to do with module references.  In fact,
that's the headache of module reference counts in a nutshell, kobject,
properly reference count the data structures, but the module reference
count is needed to properly protect the code itself from going away.

For files that users open within sysfs, kobjects now properly increment
the module reference count.  But for other modules that grab structures
from your module, you need to make sure the module reference counting is
correct.

Or just disable CONFIG_MODULE_UNLOAD, and not worry about it at all :)

thanks,

greg k-h
