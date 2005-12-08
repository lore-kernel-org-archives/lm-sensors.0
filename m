From: mort@bork.org (Martin Hicks)
Date: Thu, 08 Dec 2005 15:25:27 +0000
Subject: [lm-sensors] lm75 on a ppc405
Message-Id: <20051208152527.GD25606@bork.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051207210919.GF3085@bork.org>
In-Reply-To: <20051207210919.GF3085@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Wed, Dec 07, 2005 at 11:14:23PM +0100, Jean Delvare wrote:
> 

[snip]

> We care in that some adapters do not want to be probed for random
> chips, for they know exactly which chips they can have. This is
> frequently the case for media/video devices. The class separation was
> introduced to prevent useless probing which was said to sometimes
> confuse chips and busses. We might move to a better approach in the
> future, but for now we'll just stick to this one as it works rather
> fine.
> 

Ah, that explains it pefectly.

> > Any insight or is this a correct patch?  With this patch I see the lm75
> > at 0x48 and the temperature it reports is reasonable.
> 
> The correct approach is to add I2C_CLASS_HWMON to i2c-ibm_iic's class
> flags. I'd take a patch doing that.

Excellent.  Tested against 2.6.11.9, and compile tested with Linus'
latest git tree.

Thanks
mh

-- 
Martin Hicks || mort at bork.org || PGP/GnuPG: 0x4C7F2BEE


[PATCH] i2c/ibm_iic - Add to HWMON class

Add the ibm_iic driver to the HWMON class so it will scan the
bus for connected hardware monitor sensors.

Signed-off-by:  Martin Hicks <mort at bork.org>

---

 drivers/i2c/busses/i2c-ibm_iic.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

applies-to: 75f680b437862b125cbce00709fcebf57f146b88
72522808f521cb378a1ed6ee490a9ea7c6e977f7
diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
index 1a58725..87fae93 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -725,6 +725,7 @@ static int __devinit iic_probe(struct oc
 	strcpy(adap->name, "IBM IIC");
 	i2c_set_adapdata(adap, dev);
 	adap->id = I2C_HW_OCP;
+	adap->class = I2C_CLASS_HWMON;
 	adap->algo = &iic_algo;
 	adap->client_register = NULL;
 	adap->client_unregister = NULL;


