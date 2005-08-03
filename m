From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 03 Aug 2005 00:34:05 +0000
Subject: [lm-sensors] [PATCH] lm93 driver for 2.6, second try
Message-Id: <20050802223329.GA20614@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1122934191.32459.18.camel@wiz.dev.aspsys.com>
In-Reply-To: <1122934191.32459.18.camel@wiz.dev.aspsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Eric:

* Eric J. Bowersox <ericb@aspsys.com> [2005-08-02 13:09:29 -0600]:
> On Mon, 2005-08-01 at 16:09, Eric J. Bowersox wrote:
> > I haven't tested this particular code yet, but that will happen shortly,
> > once our production engineers find me an X6DHP box to tinker with.
> 
> Well, that's changed...I *have* tested it now on an X6DHP box running
> SuSE Enterprise 9 with the 2.6.13-rc3-mm3 kernel (plus the lm93 driver)
> and lm_sensors 2.9.1.  When loaded normally, the driver puts these
> messages into the system log:
> 
> Aug  2 12:53:58 cr0219en kernel: i801_smbus 0000:00:1f.3:
> I2C_SMBUS_I2C_BLOCK_READ not DB!
> Aug  2 12:53:58 cr0219en kernel: lm93 0-002e: lm93: block read data
> failed, command 0xf5.
> 
> (This gets repeated over and over, with the "command" value in the
> message changing to values like 0xf9, 0xf6, 0xf7, and 0xf4.)
> 
> And, under these circumstances, the sensor readings are essentially
> blank; all 0's for voltage, all -1's for fan speed, and all 0's for
> temperature.
> 
> I unloaded the module and reloaded it with disable_block=1 (thank you
> Mark for thinking of that option!), and the sensor readings looked more
> reasonable.
> 
> Any idea what's going on here?  Obviously, the block operations in the
> driver are hosed somehow, I'm just not sure where to look for the source
> of the hosation...

"Hosation" - that's a new one.  You from up north eh? ;)

CVS/lm93.c, line 450:

	result = i2c_smbus_read_block_data(client,

Your patch, at the equivalent place:

	result = i2c_smbus_read_i2c_block_data(client,

Those two aren't synonyms - you changed the transaction type.  Why?

(You also reminded me that i2c-i801.c in 2.6.x should get synced up
a bit with its twin in lm-sensors CVS.  I'll do that later.)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

