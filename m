From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: CPU Fan on ASUS P4P800VM
Message-Id: <ayBZH21f.1106900245.2106100.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501272214.14608.schopen@medienlabor.de>
In-Reply-To: <200501272214.14608.schopen@medienlabor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Marcus,

> > Have you tried "set fan2_div 8"?
>
> jiippppppppppiiii! Now the output is fine :) This line should be part of
> doc/chips/w83627hf.

Except that it is not w83627hf-specific. This is documented in both our
FAQ and doc/fan-divisors.

--
Jean Delvare
