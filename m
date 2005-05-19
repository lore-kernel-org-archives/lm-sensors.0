From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Linux 2.6 and CONFIG_ISA
Message-Id: <20040116012012.GL23253@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074005072.400404506dd11@imp.gcu.info>
In-Reply-To: <1074005072.400404506dd11@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 13, 2004 at 03:44:32PM +0100, Jean Delvare wrote:
> Hi all,
> 
> After reading the following post on LKML:
> http://marc.theaimsgroup.com/?l=linux-kernel&m7377669427411&w=2
> I did some research about how ISA and I2C are supposed to interact
> through the different Kconfig files in Linux 2.6. Here are my
> conclusions, on which I'd like to have feedback and comments.

I just too the requirement for CONFIG_ISA off of i2c-isa so that x86_64
users can use that driver.  We might want to consider a rename of the
driver in the future...

thanks,

greg k-h
