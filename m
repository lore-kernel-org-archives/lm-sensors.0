From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 21 Mar 2007 15:24:45 +0000
Subject: [lm-sensors] [PATCH] ad7418 driver
Message-Id: <20070321162445.653fcec6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061112153724.3e630d32@inspiron>
In-Reply-To: <20061112153724.3e630d32@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alessandro,

On Mon, 19 Mar 2007 23:35:33 +0100, Alessandro Zummo wrote:
> On Sun, 24 Dec 2006 14:53:59 +0100, Jean Delvare wrote:
> > After reading the datasheet once more, I realize I was confused here:
> > you actually support the AD7417 (4 voltage inputs), and not the AD7418
> > (1 voltage input). My comment still holds, though.
> 
>   I took a bit of time and started applying your suggestions.
>  I tested the driver against both 18 and 17 and they look the same.
>  I haven't found a way to distinguish between them.

Well, what does the AD7418 return when you read a non-existing channel?

If these devices are used in embedded designs, you will be able to use
the new code contributed by David Brownell to explicitly instantiate
the devices, without hardware probing. This will solve the problem.

-- 
Jean Delvare

