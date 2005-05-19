From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: [greg@kroah.com: Re: [patch] sensors/w83781d.c creates useless sysfs
Message-Id: <20031013201136.GA2071@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Greg KH <greg@kroah.com> -----

From: Greg KH <greg@kroah.com>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org, frodol@dds.nl,
	Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>
Subject: Re: [patch] sensors/w83781d.c creates useless sysfs entries
X-Spam-Status: No, hits=-3.8 required=5.0 tests=IN_REP_TO,TO_LOCALPART_EQ_REAL version=2.20
X-Spam-Level: 

On Sat, Oct 11, 2003 at 06:32:44PM +0200, Kronos wrote:
> Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz> ha scritto:
> > Hello,
> > 
> > here is a trivial fix for Winbond sensor driver, which currently creates 
> > useless entries in sys/bus/i2c due to missing braces after if statements 
> > - author probably forgot about the macro expansion.
> 
> IMHO it's better to fix the macro:

Thanks, I've applied this version.

greg k-h

----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
