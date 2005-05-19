From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: [PATCH-2.5] w83781d i2c driver updated for 2.5.66-bk4 (with sysfs support, empty tree)
Message-Id: <20030402222209.GA3134@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <20030326202904.GK24689@kroah.com> <1048721671.7569.46.camel@nosferatu.lan> <20030326234601.GB27436@kroah.com> <1049028443.11721.40.camel@nosferatu.lan>
In-Reply-To: <1049028443.11721.40.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schlemmer <azarah@gentoo.org>
Cc: KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com

On Sun, Mar 30, 2003 at 02:47:24PM +0200, Martin Schlemmer wrote:
> Hi
> 
> This should have a working w83781d driver updated for 2.5.66-bk4.
> Currently sysfs support is working, and are according to the spec
> (sensors-sysfs) in the 'lm sensors sysfs file structure' thread.
> Thus I used 'temp_input[1-3]', as there was not final decision
> on having them temp_input[0-2] as well, for example.
> 
> This patch is against a 'vanilla' 2.5.66-bk4 (do not have w83781d.c
> from lm_sensors2 cvs present).  Retry, as previous did not go through
> due to size.

Thanks, I've applied this to my trees and will send it off to Linus in a
short bit.

greg k-h
