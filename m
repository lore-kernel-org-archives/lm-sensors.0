From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 07 Jul 2005 21:26:44 +0000
Subject: [lm-sensors] W83792D & Overtemperature LED on Supermicro
Message-Id: <20050707212627.565d683a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
In-Reply-To: <1120167411.32695.31.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Eric,

> Yes, that was it, except I had to make a few minor adjustments to the
> driver file to get it to compile against the 2.6.5 kernel.  (Before
> you ask, yes, we *have* to use that kernel version; the customer wants
> SuSE Enterprise 9, and that's the most recent kernel version we have
> from SuSE with all their patches and whatnot.)  In addition, I made a
> teeny patch to the driver to change the dev_info() message that is
> logged every time the driver polls the chip to a dev_dbg() message,
> since our production engineer was concerned about the excessive log
> messages.  I am attaching the patch as I modified it for 2.6.5, and
> the second patch for the log messages (that works against either the
> 2.6.5 or 2.6.12 patches).

Another thing here, see these lines in the patch:

+	/* Start monitoring */
+	w83792d_write_value(client, W83792D_REG_CONFIG,
+			    (w83792d_read_value(client,
+						W83792D_REG_CONFIG) & 0xf7)
+			    | 0x01);

I believe that the mask should be 0x7e, rather than 0xf7. Could you
please change that and see if it helps?

Thanks,
-- 
Jean Delvare
