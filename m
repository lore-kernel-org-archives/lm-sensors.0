From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: [PATCH] i2c driver changes for 2.5.72
Message-Id: <20030624041943.GF10891@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <10559607053930@kroah.com>
In-Reply-To: <10559607053930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Philip Pokorny <ppokorny@penguincomputing.com> [2003-06-23 20:57:36 -0700]:
> Mark M. Hoffman wrote:
> >* Greg KH <greg@kroah.com> [2003-06-23 16:41:14 -0700]:

> >>Hm, so I can understand if we need to protect access to the hardware
> >>when we read two values in a row, like this:
> >>               res = i2c_smbus_read_byte_data(client, reg) & 0xff ;
> >>               res |= i2c_smbus_read_byte_data(client, reg+1) << 8 ;
> >>
> >>or the same thing when writing.
> >
> >
> >Good point.  The I2C core provides I2C/SMBus locking to prevent trashing
> >the bus itself, but that doesn't help the above.  Which brings about
> >another question... why wasn't i2c_smbus_read_word_data() used in that
> >case?  Philip?
> 
> I actually tried that, but it didn't work.  My original code had a 
> #define that would let you try and re-enable it, but I ditched it when I 
> didn't see any other drivers using read_word variants.
> 
> I should have spoken up that read_word seemed to be broken at the time.
> 
> But as I write this, I think I read in the chip data sheet that it 
> doesn't support SMBus word reads...  (Go figure...)  That was probably 
> the real reason I pulled the read_word code...

It's just as well... maybe some bus drivers don't support it either.  It
doesn't hurt to use lowest common denominator SMBus routines if possible.

> >And one last off-topic nit: data->fan_ppr is set but not used?
> 
> The fan_ppr features is only on the ADM1027 variant.  Perhaps Margit 
> didn't migrate that code?  Otherwise, there are calls to PPR_FROM_REG() 
> in the cvs code...

Maybe it was left out because there's no mention of what to do with it
in sysfs?  I have no suggestion for that; I don't know what PPR is.

Also btw, data->lock is never used.  There could be others.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
