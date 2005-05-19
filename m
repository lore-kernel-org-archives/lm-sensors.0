From: icampbell@arcom.com (Ian Campbell)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH 2.6] i2c-algo-bit should support I2C_FUNC_I2C
Message-Id: <1102353800.3215.260.camel@icampbell-debian>
List-Id: <lm-sensors.vger.kernel.org>
References: <1101807766.3215.103.camel@icampbell-debian>
In-Reply-To: <1101807766.3215.103.camel@icampbell-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2004-12-05 at 13:53 +0100, Jean Delvare wrote:
> Hi Ian,
> 
> Sorry for the delay, I have been encountering severe mail problems and
> lost 6 days worth of data, including your latest post about I2C_FUNC_I2C
> in i2c-algo-bit. I am copying your questions from the mailing-list
> archive.

No problem! I hope you got it sorted...

> First, note that all SMBus commands are valid I2C transfers.

I had an inkling that this might be the case, thanks for confirming it.

> Now, note that Russell is not quite correct in is assertion: "Do we
> really require SMBUS functionality, or is i2c functionality sufficient?"
> It's actually the other way around. SMBus puts restrictions on what a
> valid I2C transfer is. "Do we need the full I2C functionality or is the
> SMBus subset sufficient?" would make more sense.
> 
> As for the exact functionality you need to check, let's just see how you
> access the bus. As far as I can see (providing that the code below
> Russell's comments is still valid), you rely on:
>  * i2c_smbus_write_byte_data
>  * i2c_smbus_read_byte_data
>  * i2c_transfer
> 
> So yo *need* to check for the availability of I2C_FUNC_SMBUS_BYTE_DATA
> on the adapter (which is part of I2C_FUNC_SMBUS_EMUL so any bus driver
> using that, including any relying on i2c-algo-bit, will work with your
> client driver) for the first two. And you also need to check for
> I2C_FUNC_I2C for the third one.
> 
> Of course, any adapter with I2C_FUNC_I2C will be able to do SMBus byte
> data transfers, but since you do not use i2c_transfer to do them, you
> need to check the functionality separately (I think).
> 
> Also, I think that what you do with i2c_transfer is similar to
> I2C_FUNC_SMBUS_READ_I2C_BLOCK, which is supported by some SMBus
> (non-I2C) masters. If you convert your code to use
> i2c_smbus_read_i2c_block_data, then you don't rely on the full I2C
> capatbilities of the bus, which means that your chip driver will be
> useable on more plateforms. That said, note that this feature is
> unimplemented on most SMBus master drivers as of now, and broken on a
> number of others (but I guess we would start paying more attention to
> them if there were more users for this function).

OK I'll check out smbus_read_i2c_block and see if I can make use of it,
I reckon it looks pretty likely.

> As a side note... Did you know that we have a DS1307 driver for Linux
> 2.4 already?
> http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/kernel/chips/ds1307.c
> Looks like you started from scratch... Maybe you want to compare codes.

I started from a ds1307 driver from the 2.4 -rmk ARM Linux patches,
forward ported to 2.6 -- I don't know the relation with your 2.4 driver
-- I'll check it out though.

> You are right that i2c-algo-bit should declare itself I2C_FUNC_I2C
> capable. I even think that every bus being I2C_FUNC_SMBUS_EMUL capable
> is very likely to be I2C_FUNC_I2C capable. This means that other
> algorithms (ite, pcf, maybe pca) could most probably be declared
> I2C_FUNC_I2C capable as well. Can anyone confirm?

PCF and PCA both say "i2c" in the datasheets and don't mention smbus at
all, so I reckon I2C_FUNC_I2C would be appropriate. I'll put together a
patch tomorrow. 

I can't speak for the ite driver.

> I admit that the relationship between I2C and SMBus is somewhat tricky,
> it took me some time to get it and even then I am sometimes not sure to
> understand exactly what implies what ;) So we cannot blame you for not
> getting it at first. I hope I helped make things a little clearer. If
> not I welcome questions.

Very much clearer, thank you... If I have further questions I'll pester
you further, no doubt about that :-)

> Whether or not you change your code to use SMBus only in your driver to
> make it more widely useable, your patch to i2c-algo-bit is valid, I am
> signing it too and will apply it to the 2.4 version of the driver as
> well.

Cheers,
Ian.

-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road,                    Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom       Phone:  +44 (0)1223 411 200


_____________________________________________________________________
The message in this transmission is sent in confidence for the attention of the addressee only and should not be disclosed to any other party. Unauthorised recipients are requested to preserve this confidentiality. Please advise the sender if the addressee is not resident at the receiving end.  Email to and from Arcom is automatically monitored for operational and lawful business reasons.

This message has been virus scanned by MessageLabs.
