From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Oct 2007 16:03:33 +0000
Subject: Re: [lm-sensors] hwmon/lm87: Add support for the Analog Devices
Message-Id: <20071009180333.381cecfe@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071009152222.0e4a51a3@hyperion.delvare>
In-Reply-To: <20071009152222.0e4a51a3@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Uwe,

On Tue, 9 Oct 2007 16:55:11 +0200, Uwe Hermann wrote:
> Untested, and I'm not an lm-sensors or kernel expert anyway, but here are
> some comments:
> 
> On Tue, Oct 09, 2007 at 03:22:22PM +0200, Jean Delvare wrote:
> > --- linux-2.6.23-rc9.orig/Documentation/hwmon/lm87	2007-10-09 08:42:48.000000000 +0200
> > +++ linux-2.6.23-rc9/Documentation/hwmon/lm87	2007-10-09 11:14:05.000000000 +0200
> > @@ -4,8 +4,12 @@ Kernel driver lm87
> >  Supported chips:
> >    * National Semiconductor LM87
> >      Prefix: 'lm87'
> > -    Addresses scanned: I2C 0x2c - 0x2f
> > +    Addresses scanned: I2C 0x2c - 0x2e
> 
> Is this intentional? Was the previous value incorrect?

Yes, this is intentional, the previous value wasn't in line with what
the driver actually does:

> /*
>  * Addresses to scan
>  * LM87 has three possible addresses: 0x2c, 0x2d and 0x2e.
>  */
> 
> static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };

Admittedly, in theory this should go to a separate patch, but it didn't
seem to be worth the effort this time.

> > @@ -686,11 +692,18 @@ static int lm87_detect(struct i2c_adapte
> >  
> >  	/* Now, we do the remaining detection. */
> >  	if (kind < 0) {
> > +		u8 cid = lm87_read_value(new_client, LM87_REG_COMPANY_ID);
> >  		u8 rev = lm87_read_value(new_client, LM87_REG_REVISION);
> >  
> > -		if (rev < 0x01 || rev > 0x08
> > -		 || (lm87_read_value(new_client, LM87_REG_CONFIG) & 0x80)
> > -		 || lm87_read_value(new_client, LM87_REG_COMPANY_ID) != 0x02) {
> > +		if (cid = 0x02			/* National Semiconductor */
> > +		 && (rev >= 0x01 && rev <= 0x08))
> > +			kind = lm87;
> > +		else if (cid = 0x41		/* Analog Devices */
> 
> I don't know how this is handled in the rest of the code, but personally I'd
> make them #defines, e.g. like this:

Depends on the driver, some do it the way you propose (lm85, adm1026,
dme1737) but most drivers use register values directly as I'm doing
here.

> #define COMPANY_ID_NATSEMI		0x02
> #define COMPANY_ID_ANALOG_DEVICES	0x41
> 
> (maybe even in some common header file which other drivers can use, too)

Not possible for Nat. Semi, as they smartly use different company IDs
depending on the device. It's 0x00 for the LM84, 0x02 for the LM87 and
0x01 for their other chips. The Analog Devices ID used here is the
standard one, however they used 0x23 for the ADM9240 for example (while
0x23 was the Genesys ID for their GL523SM). SMSC too has a standard ID
(0x55) but used a different one sometimes. So if you want to have such
definitions in a common header, you'll have to deal with exceptions.

> A lot more readable IMO, and you don't need any code comment anymore.

I'm seeing it the other way around: thanks to the comments, I don't
need the defines ;) I don't see much benefit in using defines in this
specific case.

Thanks for the review.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
