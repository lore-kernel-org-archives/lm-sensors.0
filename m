From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Driving non-smbus i2c chip given I2C_FUNC_SMBUS_EMUL adapter
Message-Id: <3F7CB5C2.12B5D9A4@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D01E65D91799784A816D515B4201AB82030B32@pluto3.stellcom.com>
In-Reply-To: <D01E65D91799784A816D515B4201AB82030B32@pluto3.stellcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Geoff Goldberg wrote:
> 
> Greetings,
> 
> I read through the docs and FAQ and some driver code but could not determine
> how to communicate with my i2c chip from my chip driver.
> 
> I'm working with an embedded system that has the following:
> 
> *       i2c adapter
> *       i2c device (not indicated to be smbus-compatible in the data sheet)
> *       i2c-algo-<arch>.o
> *       i2c-adap-<arch>.o
> 
> and I need to create chip drivers for the non-smbus i2c device.
> 
> Also given:
> 
> *       the existing bus driver functionality doesn't include I2C_FUNC_I2C
> (only I2C_FUNC_SMBUS_EMUL and a couple of other flags)
> *       In the adapter algo driver, master_xfer is implemented, smbus_xfer
> is NULL
> 
> My question is this:
> 
> Can my chip driver reliably use i2c calls (i2c_master_send,
> i2c_master_receive, etc)? 

no

> Can it reliably use i2c_smbus_xxx() calls?

yes, subject to the capabilities of the i2c device.
