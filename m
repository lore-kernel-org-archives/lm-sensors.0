From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:26 +0000
Subject: How do I get i2c-viapro kernel module
Message-Id: <3BFFF12B.235D49AC@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1006531457.32098.3.camel@astrolinux.com>
In-Reply-To: <1006531457.32098.3.camel@astrolinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


character devices -> hardware sensors -> via 596 a/b
assuming you patched with a recent lm_sensors
we are now at 2.6.2.

mds





Alex Duggan wrote:
> 
> Hi Guys
> 
> I'm having a bit of a problem that I think you can clarify.  I would
> like to use lm_sensors and I need the i2c-viapro kernel module.  I have
> tried kernel 2.4.10 and kernel 2.4.14 (latest stable) and I can't seem
> to find an option to build that module anywhere in 'make xconfig'.  What
> do I need to do to make this module???  I've tried patching with you
> mkpatch.pl script to no avail.  I noticed that the stock redhat
> kernel, which I don't use, has it included in it, what do I need to do
> to build this module into my kernel?
> 
> PS If I've sent this to the wrong email, who do I want to be contacting
> about this?
> 
> Thanks
> Alex
> --
>   ___  ____ ____       _____                      _____
>  / _ \|  __|  _ \
> | /_\ | |_ | | | |     Alex Duggan
> |  _  |  _|| | | |     alex@openup.com/aldug@openup.com
> | | | | |  | |_| |     http://darthvader.astrolinux.com
> |_| |_|_|  |____/      _____                      _____
