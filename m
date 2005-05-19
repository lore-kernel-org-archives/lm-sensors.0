From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: [PATCH 2.6-bk] Update IXP4xx I2C bus driver
Message-Id: <20040502053703.GC31886@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040415180759.GA15522@plexity.net>
In-Reply-To: <20040415180759.GA15522@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Apr 15, 2004 at 11:07:59AM -0700, Deepak Saxena wrote:
> 
> Greg,
> 
> The 2.6 IXP4xx code has been cleaned up to change all references to
> IXP42x/IXP425 with IXP4xx. The following patch updates the I2C bits.
> Before applying, you need to 'bk move i2c-ixp42x.c ixp-4xx.c".

Hm, I think you meant:
	bk mv i2c-ixp42x.c i2c-ixp4xx.c
instead, as that is what your patch reflected :)

I've done that and applied your patch.

thanks,

greg k-h
