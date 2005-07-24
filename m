From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 24 Jul 2005 16:28:27 +0000
Subject: [lm-sensors] Re: [PATCH 2.6] cleanup of i2c-nforce2
Message-Id: <20050724162811.587f11f1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42E24733.7010207@gmx.net>
In-Reply-To: <42E24733.7010207@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Hans-Frieder,

> attached is a small patch that removes unused code from i2c-nforce2
> and adds a single debug message. The patch is against 2.6.13-rc3-mm1.
> I have tested the patch with 2.6.13-rc3: compiles cleanly and works
> as without the patch (as expected).

Thanks for this cleanup patch, I like it. However, I would have a few
comments as I think we could clean up this driver even more.

1* The MAX_TIMEOUT constant doesn't seem to be used anywhere anymore, so
you could rip it.

2* There are a few more lines of code that are commented out:

265		/* case I2C_SMBUS_PROC_CALL: not supported */

270		/* case I2C_SMBUS_BLOCK_PROC_CALL: not supported */

288	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA /* |
289	    I2C_FUNC_SMBUS_BLOCK_DATA */;

Maybe you can rip them away as well (but see point 4*.)

3* This comment should be updated:

126 /* Return -1 on error. See smbus.h for more information */

There is no file named smbus.h.

4* The driver isn't very clear about what SMBus transactions it
supports. nforce2_func reports that only quick, byte, byte data and word
data transfers are supported, but nforce2_access seems to implement
block and i2c block transfers. If the block implementations work, they
should be advertised by nforce2_func. If not, they should be removed.

5* In nforce2_access, you have several cases for dealing with the
various transfer types that the driver doesn't support. As users should
check for advertised functionalities before they call nforce2_access, I
wouldn't bother detailing the errors with different error messages. The
default case should be enough.

May we have a similar patch for the Linux 2.4 version of the driver as
found in the lm_sensors CVS repository?

Thanks,
-- 
Jean Delvare
