From: kumar.gala@freescale.com (Kumar Gala)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: example of using i2c chip inside 2.6 kernel
Message-Id: <fdddc08bc2ec010e813711002f8412b7@freescale.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3d3ac13c2e8cf7422590cc5cf08fff46@freescale.com>
In-Reply-To: <3d3ac13c2e8cf7422590cc5cf08fff46@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry,

I may not have been clear.  Was wanting to know if any other piece of 
code in the kernel used one of the drivers that existed in 
drivers/i2c/chips/*

- kumar

On Mar 3, 2005, at 11:41 AM, Greg KH wrote:

> On Wed, Mar 02, 2005 at 12:08:48PM -0600, Kumar Gala wrote:
>  > I was hoping someone could point me to an example of using an I2C 
> chip
> > driver inside the kernel (if such a thing exists).
>
> drivers/i2c/chips/* ?
>
> greg k-h
