From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 08 Jul 2009 21:18:34 +0000
Subject: Re: [lm-sensors] [PATCH] Add support for Atom CPUs
Message-Id: <20090708231834.2169e6fb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A522794.1020507@assembler.cz>
In-Reply-To: <4A522794.1020507@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 08 Jul 2009 22:38:05 +0200, Rudolf Marek wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> >> +	/* if we dont use msr EE it means we are desktop CPU (with exeception of Atom) */
> > 
> > Line too long.
> 
> Well I thought the 80 lines limit is not so strict anymore.

Quoting CodingStyle:

"The only exception to this is where exceeding 80 columns significantly
increases readability and does not hide information."

Do you really believe that splitting this comment will hinder
readability?

> >> +	} else if (tjmax = 100000) {
> >>  		dev_warn(dev, "Using relative temperature scale!\n");
> >>  	}
> >>  
> > 
> > I think function adjust_tjmax() has reached its limit of readability. I
> > don't understand why it needs to be so complex. For example, the case
> > of the Atom is very simply always return 90 degree C. So why not just:
> 
> Yes right, but it is going to be complex for penryns. I will try to simplify it.
> 
> > 
> > 	/* Atoms seems to have TjMax at 90C */
> > 	if (c->x86_model = 0x1c)
> > 		return 90000;
> 
> Because of multiple returns? If you are OK with multiple returns I will fix it.

Last time I checked, the C language supported it ;) I see no point in
limiting yourself if this means your code becomes harder to read.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
