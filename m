From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH] I2C update for 2.6.10-rc1
Message-Id: <20041110052659.GA13479@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10999778552595@kroah.com>
In-Reply-To: <10999778552595@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Nov 10, 2004 at 02:04:56PM +1100, Rusty Russell wrote:
> On Mon, 2004-11-08 at 21:24 -0800, Greg KH wrote:
> > +static int init = 1;
> > +MODULE_PARM(init, "i");
> 
> You meant, of course, module_param(), or were you checking if my scripts
> were broken? 8)

Read on in the patch series...

Your scripts need to check for replacements too :)

greg k-h
