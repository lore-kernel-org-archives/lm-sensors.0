From: ericb@aspsys.com (Eric J. Bowersox)
Date: Thu, 04 Aug 2005 00:36:28 +0000
Subject: [lm-sensors] [PATCH] lm93 driver for 2.6, third try [1/2]
Message-Id: <1123108550.19595.22.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1123108519.19598.18.camel@wiz.dev.aspsys.com>
In-Reply-To: <1123108519.19598.18.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is i2cblock-2.6.13-rc3-mm3.patch, against 2.6.13-rc3-mm3, which
reintroduces the i2c_smbus_read_block_data function into i2c-core,
because the lm93 driver needs it.

Signed-off-by: Eric J. Bowersox <ericb@aspsys.com>

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2cblock-2.6.13-rc3-mm3.patch
Type: text/x-patch
Size: 1872 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050804/2c916c0a/i2cblock-2.6.13-rc3-mm3-0001.bin
