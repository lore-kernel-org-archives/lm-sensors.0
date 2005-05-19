From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: [patch] it87.c patch for Shuttle SS51G and co
Message-Id: <20040302200945.GA3141@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Mar 02, 2004 at 02:11:12PM +0000, Michel Pollet wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> 
> 
> Hi Guys,
> 
> The included patch implements a it87 module parameter to enable/disable the 
> chip init when explicitely specified. The default is still "1".
> On Shuttle SS51G machines (and related) reseting the chip also resets the 
> "vario" speed of the fans, causing them to go at full speed thereafter until 
> the next reboot. Noisy :-)
> 
> The patch is against vanilla 2.6.3 i2c.

Hm, can you use the directions for patching that are found in
Documentation/SubmittingPatches (use -u and make the patch so it can be
applied from the base of the kernel tree with the -p1 option to patch.)

Also, you don't need to add your name and email address to the comment,
it will show up in the changelog entry instead.

Also, please post this to the sensors list (now CCed) so that the other
developers there can make comments on it.

thanks,

greg k-h
