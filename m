From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH 2.6] New chip driver: ds1621
Message-Id: <20040315211142.GA32636@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040314221228.GA16033@pc.aurel32.private>
In-Reply-To: <20040314221228.GA16033@pc.aurel32.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 14, 2004 at 11:12:28PM +0100, Aurelien Jarno wrote:
> Hello Greg,
> 
> The following patch against kernel 2.6.4-mm1 adds the ds1621 driver (an
> I2C sensor). I have ported it from the 2.4 version.
> 
> It has been reviewed by Jean Delvare, partly on IRC, and it is 
> "compliant" with Mark Hoffman's refactoring.

Looks nice, applied, thanks.

greg k-h
