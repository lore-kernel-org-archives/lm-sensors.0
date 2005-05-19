From: frodol@dds.nl (Frodo Looijaard)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: [steve@wormley.com: Linux 2.6.2 i2c debug bug]
Message-Id: <20040205201625.GA13885@frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

----- Forwarded message from Steve Wormley <steve@wormley.com> -----

From: Steve Wormley <steve@wormley.com>
To: frodol@dds.nl
Subject: Linux 2.6.2 i2c debug bug
X-Spam-Status: No, hits=-5.0 required=5.0 tests=UNIFIED_PATCH version=2.20
X-Spam-Level: 

Apparently one of the dev_dbg in i2c_master_recv in i2c_core.c in
2.6.2 
has a little issue in that it's dereferencing the wrong element
(client->dev instead of client->adapter->dev)

Fix is below


diff -u stuff/linux-2.6.2/drivers/i2c/i2c-core.c linux-2.6.2/drivers/i2c/i2c-core.c
--- stuff/linux-2.6.2/drivers/i2c/i2c-core.c    Tue Feb  3 19:43:13 2004
+++ linux-2.6.2/drivers/i2c/i2c-core.c  Wed Feb  4 22:34:23 2004
@@ -598,7 +598,7 @@
                ret = adap->algo->master_xfer(adap,&msg,1);
                up(&adap->bus_lock);
 
-               dev_dbg(&client->dev, "master_recv: return:%d (count:%d, addr:0x%02x)\n",
+               dev_dbg(&client->adapter->dev, "master_recv: return:%d (count:%d, addr:0x%02x)\n",
                        ret, count, client->addr);
 
                /* if everything went ok (i.e. 1 msg transmitted), return #bytes



-Steve Wormley

----- End forwarded message -----

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
