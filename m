From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: [PATCH 2.6-bk] Update IXP4xx I2C bus driver
Message-Id: <20040415204543.2828ad88.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040415180759.GA15522@plexity.net>
In-Reply-To: <20040415180759.GA15522@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The 2.6 IXP4xx code has been cleaned up to change all references to
> IXP42x/IXP425 with IXP4xx. The following patch updates the I2C bits.
> Before applying, you need to 'bk move i2c-ixp42x.c ixp-4xx.c".

Much noise with no apparent benefit IMVHO. What motivated such a change?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
