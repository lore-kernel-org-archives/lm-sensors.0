From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 04 Oct 2006 09:59:46 +0000
Subject: [lm-sensors] [PATCH] PowerPC 4xx I2C driver - add
Message-Id: <20061004115946.4850c781.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061004032510.GA10354@gate.ebshome.net>
In-Reply-To: <20061004032510.GA10354@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Eugene,

Wrong maintainer, and wrong list. I am the i2c maintainer, Greg is no
longer, and there's a mailing list dedicated to i2c:
  http://lists.lm-sensors.org/mailman/listinfo/i2c

Please resend to this list, thanks.

> This small patch adds calls to the functions request_mem_region and
> release_mem_region.

That I can see by just reading the patch. A more useful description
would be _why_ this is needed.

-- 
Jean Delvare

