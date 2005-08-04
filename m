From: ericb@aspsys.com (Eric J. Bowersox)
Date: Thu, 04 Aug 2005 17:07:46 +0000
Subject: [lm-sensors] [PATCH] lm93 driver for 2.6, third try [1/2]
Message-Id: <1123168023.23070.3.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1123108519.19598.18.camel@wiz.dev.aspsys.com>
In-Reply-To: <1123108519.19598.18.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2005-08-04 at 01:37, Jean Delvare wrote:
> I'm of course fine with the reintroduction of a standard smbus function
> you need, but I'd like you to fix formal issues this patch has:
> 
> * Please place the i2c_smbus_read_block_data function (and declarations)
> before i2c_smbus_write_block_data rather than after. All other pairs
> have read before write.
> 
> * There should be one space after each comma (except at line end). I know
> the original code you took from 2.6.5 wasn't correct in this respect,
> but as we are adding it back now, let's do it with standard coding
> style.
> 
> Can you please send an updated patch addressing these points?

All right.  Herewith an update of the patch
i2cblock-2.6.13-rc3-mm3.patch, which fixes the ordering (of the function
code as well as the header file and EXPORT_SYMBOL declarations) and the
comma spacing.  As with the previous version of this patch, it
reintroduces the function i2c_smbus_read_block_data to i2c-core, as it
is needed by the lm93 driver.

Signed-off-by: Eric J. Bowersox <ericb@aspsys.com>

					Eric

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2cblock-2.6.13-rc3-mm3.patch
Type: text/x-patch
Size: 1943 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050804/bd9a6a23/i2cblock-2.6.13-rc3-mm3.bin
