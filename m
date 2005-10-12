From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 12 Oct 2005 11:01:59 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.14-rc2-mm2] hwmon: add a new ID to SMSC
Message-Id: <qqYAVjft.1129107054.2982500.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051012032205.GA20051@jupiter.solarsys.private>
In-Reply-To: <20051012032205.GA20051@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

On 2005-10-12, Mark M. Hoffman wrote:
> This patch adds a new ID to the SMSC LPC47B397-NC hardware
> monitoring driver - for a chip that is claimed to be 100%
> compatible otherwise.
> (...)
> -	printk(KERN_INFO "smsc47b397: found SMSC LPC47B397-NC "
> -		"(base address 0x%04x, revision %u)\n", *addr, rev);
> +	switch (id) {
> +	case 0x6f:
> +		printk(KERN_INFO "smsc47b397: found SMSC LPC47B397-NC "
> +			"(base address 0x%04x, revision %u)\n", *addr, rev);
> +		break;
> +	case 0x81:
> +		printk(KERN_INFO "smsc47b397: found SMSC SCH5307-NS"
> +			"(base address 0x%04x, revision %u)\n", *addr, rev);
> +		break;
> +	}

This adds some redundancy. What about the following?

printk(KERN_INFO "smsc47b397: found %s "
       "(base address 0x%04x, revision %u)\n",
       id = 0x81 ? "SMSC SCH5307-NS" : "SMSC LPC47B397-NC",
       *addr, rev);

I would also appreciate an update to Documentation/hwmon/smsc47b397.

Thanks,
--
Jean Delvare
