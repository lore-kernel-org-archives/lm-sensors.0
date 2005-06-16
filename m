From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 16 Jun 2005 10:31:09 +0000
Subject: [lm-sensors] fixing ticket #1944
Message-Id: <gjXT3Pml.1118910008.3723750.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050615222035.91224.qmail@web31003.mail.mud.yahoo.com>
In-Reply-To: <20050615222035.91224.qmail@web31003.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Hugo,

On 2005-06-15, Hugo Vanwoerkom:
> I have an Epox EP-8VTAI mobo and my situation is
> exactly that of ticket 1944, except I run kernel
> 2.6.10.
>
> I would like to remedy the situation, can someone
> suggest the steps to take? Given that I have kernel
> programming experience, but no hardware monitoring
> equipment.
>
> Am I way off base?

Looks so. The W83687THF is a rare chip, not listed on Winbond's site, we
have no datasheet for it, this explains why we don't support it.

We may add experimental detection support to sensors-detect if you
provide the output of the following command:

isadump -k 0x87,0x87 0x2e 0x2f 0x0b

You'll need a recent version of isadump (lm_sensors 2.9.1 or CVS). If it
doesn't seem to provide any useful information, try 0x4e 0x4f instead
of 0x2e 0x2f.

Chunhao, do you have information about the W83687THF chip? Could Winbond
release a datasheet for that chip? There's not much we can do without
that.

Thanks,
--
Jean Delvare
