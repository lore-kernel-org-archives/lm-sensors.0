From: martin.bene@icomedias.com (Martin Bene)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Ticket # 1571: i2c_piix4 lockup with Dell Poweredge 1750
Message-Id: <FA095C015271B64E99B197937712FD020B0158@freedom.grz.icomedias.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


(lockup after module load with force=1 parameter)

> You could try "insmod i2c-piix4 fix_hstcfg=1".

Just tried it, sadly doesn't change the result. still locks up in same place.

	Do you want to scan it? (YES/no/selectively):
	Client found at address 0x00

No console output, system must be powered down.

Thanks for your help,

Martin


