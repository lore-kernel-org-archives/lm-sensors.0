From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: development list
Message-Id: <416304FB.5070405@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041004235838.GA12218@home.fluff.org>
In-Reply-To: <20041004235838.GA12218@home.fluff.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'll forward this on and add you to the list.


Phil

Ben Dooks wrote:
> On Tue, Oct 05, 2004 at 01:15:28PM -0700, Philip Edelbrock wrote:
> 
>>It looks like a microcontroller?  Is it running a Linux kernel and 
>>you've developed a i2c-bus driver for it?  Not sure what you are doing 
>>or what you are asking.
> 
> 
> I have written an i2c driver for linux 2.6.9 for it
> (i've done an lot of the s3c2410 support in 2.6).
> 
> It is an ARM920, designed for PDA use.
> 
> Our board is at http://www.simtec.co.uk/products/EB2410ITX/
> 
> I would like to get the  following registered with proper
> numbers in include/linux/i2c-id.h
> 
> I2C_ALGO_S3C2410
> 
> I2C_DRIVERID_BASTPMU
> 
> 	Power Management chip on the S3C2410
> 
> I2C_DRIVERID_TLV320AIC23
> 
> 	Audio (I2S) Codec
> 
