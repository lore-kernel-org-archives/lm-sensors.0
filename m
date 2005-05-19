From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [PATCH 2.6] I2C: Resolve resource conflict between i2c-viapro and
Message-Id: <4eDrWkNC.1106216679.6306440.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050115122555.087f9a7a.khali@linux-fr.org>
In-Reply-To: <20050115122555.087f9a7a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Greg,

> > Here comes the finalized version of our patch solving the PCI device
> > resource conflict between the i2c-viapro bus driver and and the via686a
> > chip driver. It is based on your original work and the IRC conversation
> > we had yesterday.
>
> What kernel tree is this against?  I get some rejects when trying to
> apply it.

Hm, that's odd. It is supposedly against 2.6.11-rc1-mm1 + your
PCI_DEVICE patch to via686a. I'll make a new one for 2.6.11-rc1-bk7
this evening.

Sorry for the trouble, I don't know what happened.

--
Jean Delvare
