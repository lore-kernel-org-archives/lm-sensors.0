From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Acquiring an i2c adapter.
Message-Id: <4038C70D.500@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4037FB21.20701@linuxmail.org>
In-Reply-To: <4037FB21.20701@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Perry Gilfillan wrote:
> Mark,
> 
> I'm still trying to sort out where the various flags fit in.
> 
> I know that the I2C_ADAP_CLASS_* will simplify things in the 2.6 kernel, 
> and there is a small but useful set of defines to work with.  The i2c 
> and ddc bus provided by the i2c-voodoo3 are covered here.  I've already 
> sent along a patch to Greg KH, and he has applied it.
> 
> In the 2.4 kernel, we have too many choices...  There is a plethora of 
> I2C_DRIVERID_* defines, yet none for the Voodoo3 yet.  My confusion may 
> be that I'm thinking of using a client driver id on the adapter?
> 
> Does the i2c_adapter->id indicate the algorithim?  Greg KH indicated 
> that I2C_HW_B_VOO was more correct than I2C_HW_SMBUS_VOODOO3, but that 
> this was not the place to distinguish the i2c from the ddc.
> 
> If I read right, the i2c_bit_add_bus function or's adap.id with 
> i2c_bit_algo.id yeilding I2C_HW_B_VOO | I2C_ALGO_BIT, which I test for 
> in my dummy driver attach function, and then do the strnicmp.
> 

That's the right way to do it now.
I was arguing for a second ID for the DDC bus but I guess
I need to understand Greg's objections.


> The other clients that attach to the i2c-voodoo3's adapters test for a 
> chip that responds properly, so the id is not so important.  The 
> exceptioon that I notice is that eeprom seems to see eight instances of 
> the ddcmon, at which point ddcmon can't find it's valid client chip.  I 
> recall reading that ddc chips are indestinguishable from eeproms? 
> Nevermind!  I see from expermentation that the checksum=1 option to 
> eeprom solves the problem!  Something for my HOWTO.
> 

Many monitors contain a really dumb eeprom that responds to all 8 addresses.
The eeprom driver latches on to all 8. The ddcmon driver only looks at 0x50.
Load ddcmon first, or don't load eeprom, or use the ignore parameter to eeprom.


> The v3tv is the ONLY client that can't tell the difference between the 
> i2c and ddc adapters.  So I don't think any action from your group is 
> needed, since only the 2.4 kernel would be affected.
> 
> I'm still curious to know what the i2c_get_adapter function intended 
> purpose is.  Could I use a derivitive of it, that tests the 
> adapter.class, and omit the dummy client when building the v3tv module 
> for the 2.6 kernel?  Would my module not have access to the adapters 
> list unless it were exported?
> 

Greg?


> Thanks,
> 
> Perry
> -----
> V3TV: http://gilfillan.org:8000/v3tv/
> VPX3224: http://gilfillan.org:8000/vpx3224/
> 
> 
