From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: [PATCH] ALI1563 SMBus driver fix
Message-Id: <20050412155547.GA14107@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050411081712.17417.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20050411081712.17417.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Apr 11, 2005 at 08:17:12AM -0000, R.Marek@sh.cvut.cz wrote:
> Hi Greg,
> 
> Following patch contains fixies to "grave" errors of ALI1563 SMBus driver.
> It removes checking for HST_STS_DONE bit, because this bit is raised
> only after finishing for block transfers in newer chips revisions. 
> Then it fixes missing "and" mask for transfer type settings. And to third it fixes
> the "continous byte mode" transaction, because command is not transfered
> in command register but in DAT0 register. Last thing it changes is error
> recovery and error messages. All was successfully tested with help
> of Chunhao Huang from Winbond.
> 
> I added my name to source because now I feel quite familiar with the chip. :)

Did you email Pat Mochel about these changes to make sure nothing breaks
on his hardware?

Also, I need a Signed-off-by: line (as the file
Documentation/SubmittingPatches states).

> diff -Naur a/drivers/i2c/busses/i2c-ali1563.c c/drivers/i2c/busses/i2c-ali1563.c
> --- a/drivers/i2c/busses/i2c-ali1563.c	2005-03-09 09:13:19.000000000 +0100
> +++ c/drivers/i2c/busses/i2c-ali1563.c	2005-04-08 21:55:19.000000000 +0200
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   *	i2c-ali1563.c - i2c driver for the ALi 1563 Southbridge
>   *
>   *	Copyright (C) 2004 Patrick Mochel
> @@ -13,6 +13,9 @@
>   *	with a little help from the ALi 1563 spec.
>   *
>   *	This file is released under the GPLv2
> + *
> + *	2005-04-08: Fixed SMBus mode setting, fixed byte data transactions 	 
> + *			Rudolf Marek <r.marek@sh.cvut.cz>
>   */

Please do not add change log information to a .c file, it is not needed,
and only gets old and stale.

thanks,

greg k-h
