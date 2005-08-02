From: ericb@aspsys.com (Eric J. Bowersox)
Date: Tue, 02 Aug 2005 21:10:37 +0000
Subject: [lm-sensors] [PATCH] lm93 driver for 2.6, second try
Message-Id: <1123009769.14749.9.camel@wiz.dev.aspsys.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122934191.32459.18.camel@wiz.dev.aspsys.com>
In-Reply-To: <1122934191.32459.18.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2005-08-01 at 16:09, Eric J. Bowersox wrote:
> I haven't tested this particular code yet, but that will happen shortly,
> once our production engineers find me an X6DHP box to tinker with.

Well, that's changed...I *have* tested it now on an X6DHP box running
SuSE Enterprise 9 with the 2.6.13-rc3-mm3 kernel (plus the lm93 driver)
and lm_sensors 2.9.1.  When loaded normally, the driver puts these
messages into the system log:

Aug  2 12:53:58 cr0219en kernel: i801_smbus 0000:00:1f.3:
I2C_SMBUS_I2C_BLOCK_READ not DB!
Aug  2 12:53:58 cr0219en kernel: lm93 0-002e: lm93: block read data
failed, command 0xf5.

(This gets repeated over and over, with the "command" value in the
message changing to values like 0xf9, 0xf6, 0xf7, and 0xf4.)

And, under these circumstances, the sensor readings are essentially
blank; all 0's for voltage, all -1's for fan speed, and all 0's for
temperature.

I unloaded the module and reloaded it with disable_block=1 (thank you
Mark for thinking of that option!), and the sensor readings looked more
reasonable.

Any idea what's going on here?  Obviously, the block operations in the
driver are hosed somehow, I'm just not sure where to look for the source
of the hosation...

					Eric

-- 
Eric J. Bowersox, Software Engineer     Aspen Systems, Inc.
<ericb@aspsys.com>                      3900 Youngfield Street
Tel: +01 303 431 4606 x113              Wheat Ridge, CO  80033, USA
Fax: +01 303 431 7196                   <http://www.aspsys.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050802/3b35d621/attachment.bin
