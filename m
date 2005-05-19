From: ebs@ebshome.net (Eugene Surovegin)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: [TRIVIAL 2.6] drivers/i2c/busses/i2c-piix4.c: kill duplicate
Message-Id: <20040420220353.GB7726@gate.ebshome.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040417230824.45f51061.khali@linux-fr.org>
In-Reply-To: <20040417230824.45f51061.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 20, 2004 at 10:53:51PM +0200, Jean Delvare wrote:
> > Maybe I'm missing something but since when <linux/config.h> is not
> > needed?
> > 
> > Are you sure this change will not break build on some archs/configs?
> 
> I am assuming that #include <linux/config.h> is needed if and only if
> the code makes use of any CONFIG_* value. Am I wrong?

Yes, but as I told a lot of headers don't include config.h but depend on 
CONFIG_XXX defines, at least in arch-specific code.

> > So far my experience has been (at least in 2.4) that usually header
> > files don't include all required headers themselves, relying on *.c to
> > include everything properly (maybe it's just on PPC though).
> 
> Such headers are broken and need fixing IMHO.

Maybe, are you going to fix them all _before_ changing i2c layer :) ?

I agree it's a mess, but removing config.h you might break code which is fine 
right now. Is such clean up worth it?

Eugene.
