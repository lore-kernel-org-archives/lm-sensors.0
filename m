From: xanni@glasswings.com.au (Andrew Pam)
Date: Wed, 05 Oct 2005 18:41:16 +0000
Subject: [lm-sensors] Myson MTP008 driver ported to 2.6 kernel
Message-Id: <20051005164010.GU7167@kira.glasswings.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051004125511.GI7154@kira.glasswings.com.au>
In-Reply-To: <20051004125511.GI7154@kira.glasswings.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 05, 2005 at 05:12:12PM +0200, Jean Delvare wrote:
> > /* Addresses to scan */
> > static unsigned short normal_i2c[] = {0x2c, 0x2e, I2C_CLIENT_END};
> 
> 0x2d is missing.

Is the chip ever actually implemented at that address?

It may be that all known implementations use 0x2c for a single chip
motherboard and 0x2c + 0x2e for a dual chip motherboard.

Regards,
	Andrew
-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Partner, Glass Wings
http://www.sericyb.com.au/                      Manager, Serious Cybernetics
