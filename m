From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 24 May 2006 07:57:30 +0000
Subject: [lm-sensors] [PATCH 2.6.17-rc4] I2C: sis96x SMBus quirks cannot
Message-Id: <20060524095730.7b4763d2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060513182612.GB8642@jupiter.solarsys.private>
In-Reply-To: <20060513182612.GB8642@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

Sorry for the late reply.

> The sis96x SMBus PCI device depends on the order of two different
> quirks, which depends on link order.  But this is apparently not
> guaranteed, as seen on a recent FC4 kernel.  This patch fixes the
> quirk so that it works without depending on the link order.
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-April/015962.html
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id9719
> 
> This code was suggested by Jean Delvare; the patch was tested and
> should be considered for 2.6.17.

I'm happier with this patch than the previous one. However, I'm still
not really comfortable with it. Given that we don't understand why the
quirk order suddenly became untrustworthy, it's hard to justify that we
want this fix in 2.6.17, especially when vanilla kernels are not
affected by the problem as far as I know.

At any rate, this patch does belong to the pci tree and not the i2c
tree, so I am not the one who can push it. Please post this patch on
the linux-pci list and get it discussed there. Hopefully the people
there will be able to explain how the quirks sequencing works.

(Please put me in Cc, I'm interested in the answer.)

Thanks,
-- 
Jean Delvare

