From: kai.svahn@nokia.com (Kai Svahn)
Date: Mon, 06 Mar 2006 08:57:33 +0000
Subject: [lm-sensors] i2c-core error messages
Message-Id: <20060306085733.GJ16281@six.research.nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060306071543.GE16281@six.research.nokia.com>
In-Reply-To: <20060306071543.GE16281@six.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

On Mon, Mar 06, 2006 at 09:33:56AM +0100, ext Jean Delvare wrote:
> Which version of the i2c-core.c file are you referring to, please? The
> file Linux 2.6.16-rc5 has an i2c_probe function which properly returns
> errors.
>
I have rc5 and I found a problem here
static int i2c_probe_address(struct i2c_adapter *adapter, int addr, int kind, 
			     int (*found_proc) (struct i2c_adapter *,int, int)

---line 664---
if (kind < 0) {
	if (i2c_smbus_xfer(adapter, addr, 0, 0, 0,
		I2C_SMBUS_QUICK, NULL) < 0)
		return 0;
	      }
---
Shouldn't it be something like, or have I misunderstood something here?

if (kind < 0) {
	if ((err = (i2c_smbus_xfer(adapter, addr, 0, 0, 0,
	I2C_SMBUS_QUICK, NULL)) < 0)
	return err;
	      }

Cheers,
Kai

