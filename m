From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH][I2C] Marvell mv64xxx i2c driver
Message-Id: <20050202012723.GA16465@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502020315.14281.adobriyan@mail.ru>
In-Reply-To: <200502020315.14281.adobriyan@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: "Mark A. Greer" <mgreer@mvista.com>, phil@netroedge.com, sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 03:15:14AM +0200, Alexey Dobriyan wrote:
 
> P. S.: struct mv64xxx_i2c_data revisited...
> 
> > +	uint			state;
> > +	ulong			reg_base_p;
> 
> Silly request, but... Maybe this should be changed to plain old "unsigned int"
> and "unsigned long". Please. I just don't understand why people use "uint",
> "u_int", "uInt", "UINT", "uINT", "uint_t" which are always typedef'ed to
> "unsigned int".

Not a silly request at all.  Please use the u32, u64 and so on values
instead.  That way we know what you mean, and it's portable.

thanks,

greg k-h
