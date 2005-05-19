From: ebs@ebshome.net (Eugene Surovegin)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [TRIVIAL 2.6] drivers/i2c/busses/i2c-piix4.c: kill duplicate
Message-Id: <20040420202730.GA7726@gate.ebshome.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040417230824.45f51061.khali@linux-fr.org>
In-Reply-To: <20040417230824.45f51061.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Apr 20, 2004 at 09:04:41PM +0200, Jean Delvare wrote:
> Sorry for the confusion, I was only refering to config.h, not just "all"
> headers. Is it OK if I provide a patch that removes unneeded config.h
> includes from all chip, bus and i2c core drivers?

Maybe I'm missing something but since when <linux/config.h> is not needed?

Are you sure this change will not break build on some archs/configs?

So far my experience has been (at least in 2.4) that usually header files don't 
include all required headers themselves, relying on *.c to include everything 
properly (maybe it's just on PPC though).

Eugene.
