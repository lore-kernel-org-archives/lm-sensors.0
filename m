From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: I2C driver for embedded Motorola PPC products
Message-Id: <20040310224453.GA24336@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <0AB9C6CD-72E3-11D8-B2B5-000393DBC2E8@motorola.com>
In-Reply-To: <0AB9C6CD-72E3-11D8-B2B5-000393DBC2E8@motorola.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Mar 10, 2004 at 04:34:07PM -0600, Kumar Gala wrote:
> All,
> 
> We are working on a driver for the I2C controller on the MPC8540 
> (should also run on MPC824x, and MPC10x) for linux-2.4.  I was 
> wondering who we should be submitting the driver to at this point.

For 2.6, send the patch to me and the sensors list (against the latest
2.6 tree).  For 2.4 try the sensors list only (against the latest cvs
tree)

thanks,

greg k-h
