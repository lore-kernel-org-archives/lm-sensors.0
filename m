From: xanni@glasswings.com.au (Andrew Pam)
Date: Thu, 06 Oct 2005 11:09:28 +0000
Subject: [lm-sensors] Myson MTP008 driver ported to 2.6 kernel
Message-Id: <20051006090800.GT7173@kira.glasswings.com.au>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051004125511.GI7154@kira.glasswings.com.au>
In-Reply-To: <20051004125511.GI7154@kira.glasswings.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 05, 2005 at 05:12:12PM +0200, Jean Delvare wrote:
> > #define TEMP_FROM_REG(val)	(					\
> > 				 (					\
> > 				  (val) > 0x80 ? (val) - 0x100		\
> > 					       : (val)			\
> > 				 ) * 1000				\
> > 				)
> 
> The conditional would not be needed if you were using an s8 to store the
> value rather than an u8.

Unfortunately two of the temperatures are stored in variables also
used for the voltage inputs, which are unsigned when being used for
that function.  Should these variables be a union of an s8 and a u8?

In fact, I may be missing something obvious, but why does the code
maintain all these variables and read all the chip registers every time
any value is read?  Wouldn't it be more efficient to just read the
register that was actually requested?

Thanks,
	Andrew
-- 
mailto:xanni@xanadu.net                         Andrew Pam
http://www.xanadu.com.au/                       Chief Scientist, Xanadu
http://www.glasswings.com.au/                   Partner, Glass Wings
http://www.sericyb.com.au/                      Manager, Serious Cybernetics
