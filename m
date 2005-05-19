From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: [RFC PATCH] Re: [OOPS] w83781d during rmmod (2.5.69-bk17)
Message-Id: <20030602172040.GC4992@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030524183748.GA3097@earth.solarsys.private> <3ED8067E.1050503@paradyne.com> <20030601143808.GA30177@earth.solarsys.private>
In-Reply-To: <20030601143808.GA30177@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Sensors <sensors@stimpy.netroedge.com>, "Mark D. Studebaker" <mds@paradyne.com>

On Sun, Jun 01, 2003 at 10:38:08AM -0400, Mark M. Hoffman wrote:
> 
> This fixes the oops during w83781d module removal by putting the
> subclient registration back in.  While I was in there, I split
> w83781d_detect in half in an attempt to reduce the goto madness.
> 
> So, the /sys tree looks like this, where 48 & 49 are the subclients.
> There are no entries (besides name & power) for the subclients.
> 
> /sys/bus/i2c/
> |-- devices
> |   |-- 0-002d -> ../../../devices/pci0/00:02.1/i2c-0/0-002d
> |   |-- 0-0048 -> ../../../devices/pci0/00:02.1/i2c-0/0-0048
> |   `-- 0-0049 -> ../../../devices/pci0/00:02.1/i2c-0/0-0049
> `-- drivers
>     |-- i2c_adapter
>     `-- w83781d
>         |-- 0-002d -> ../../../../devices/pci0/00:02.1/i2c-0/0-002d
>         |-- 0-0048 -> ../../../../devices/pci0/00:02.1/i2c-0/0-0048
>         `-- 0-0049 -> ../../../../devices/pci0/00:02.1/i2c-0/0-0049
> 
> Also, I fixed a bug where this driver would request and release an
> ISA region, then poke around in that region, then finally request
> it again.
> 
> This patch against 2.5.70 works for me vs. an SMBus adapter.  It needs
> re-testing against an ISA adapter since my particular chip is SMBus only.

I've applied this and will send it off to Linus in a bit.

thanks,

greg k-h
