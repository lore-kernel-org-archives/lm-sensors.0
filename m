From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:05 +0000
Subject: [PATCH 2.6] Documentation for i2c-parport
Message-Id: <20040708230633.GB20431@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040707081936.5f48db6a.khali@linux-fr.org>
In-Reply-To: <20040707081936.5f48db6a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 07, 2004 at 08:19:36AM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> At least, the i2c-parport gets some documentation. I heard several
> persons complaining that there was no sample electronics schema for
> building their own i2c-over-parallel-port, so I did just that, with the
> help of Sylvain Munaut. The documentation also includes the list of
> supported adapters, and a short comparison with other drivers using the
> parallel port to drive an i2c bus. At the end of the document I included
> an updated version of the i2c-velleman doc file (which I then deleted).

Applied, thanks.

> This also raises a question about Documentation/i2c/i2c-pport. Should we
> keep a document about a driver which is not in the kernel tree (and
> hasn't even been ported to 2.6 yet)?

No we should not.  Care to send a patch to delete it?

greg k-h
