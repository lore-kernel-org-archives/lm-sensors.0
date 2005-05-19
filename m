From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: [PATCH] I2C update for 2.6.8-rc1
Message-Id: <20040715041055.GA18069@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10898500251206@kroah.com>
In-Reply-To: <10898500251206@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jul 14, 2004 at 08:15:12PM -0700, Philip Pokorny wrote:
> Is this right that we don't want to explicitly initialize the adm1031_id 
> counter?
> 
> Why is that?

Because the compiler/linker does it already for you :)

See the kernel janitor's list for more information about why this is a
good thing to change.

thanks,

greg k-h
