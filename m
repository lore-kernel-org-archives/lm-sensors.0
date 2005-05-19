From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: Trouble with i2c and bttv
Message-Id: <3F06F7CF.5040005@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307042024.55272.tim.boneko@web.de>
In-Reply-To: <200307042024.55272.tim.boneko@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

no, I think we need to send it all at once, it's a stable kernel

Jean Delvare wrote:
>>that would be great.
>>See CHANGES in i2c.
>>For bus drivers, take out the inc_use and dec_use entries in struct
>>i2c_adapter, remove the associated functions, and add an owner
>>=THIS_MODULE in struct i2c_adapter. Make sure everything is C99
>>initializers. Make the same changes in struct i2c_driver (chip
>>drivers) Remove an argument in i2c_register_entry().
> 
> 
> I will try this next week for the zoran driver.
> 
> I guess that we should send a patch with the new I2C layer to Marcelo
> for the 2.4 kernel and wait for it to be applied before sending patches
> for non-kernel drivers such as this zoran driver?
> 
