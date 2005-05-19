From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Linux 2.6 and CONFIG_ISA
Message-Id: <20040116221218.GC3028@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074005072.400404506dd11@imp.gcu.info>
In-Reply-To: <1074005072.400404506dd11@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 16, 2004 at 07:15:02PM +0100, Jean Delvare wrote:
> Quoting myself:
> 
> > 1* Elektor depends on ISA.
> > 2* ELV and Velleman do not depend on ISA.
> > 3* i2c-isa is M by default, and has an additional help text
> > 4* via686a autoselects i2c-isa
> > 5* i2c-isa doesn't depend on ISA
> 
> Here's the patch:

Applied with a bit of editing to get around my previous change.

thanks,

greg k-h
