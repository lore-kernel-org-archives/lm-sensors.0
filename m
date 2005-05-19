From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: i2c-i810.c bus driver
Message-Id: <20030915183358.GA11152@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030915183026.GA11108@kroah.com>
In-Reply-To: <20030915183026.GA11108@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Sep 15, 2003 at 11:30:26AM -0700, Greg KH wrote:
> Ugh, in looking over the bus drivers that are currently in the cvs tree,
> but not in the kernel tree, I ran accross this horrible bit of code in
> the i2c-i810.c driver:

Ugh, it's in the i2c-savage4.c and i2c-voodoo3.c drivers too :(

greg k-h
