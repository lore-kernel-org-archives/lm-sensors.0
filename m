From: adobriyan@mail.ru (Alexey Dobriyan)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: [PATCH][I2C] Marvell mv64xxx i2c driver
Message-Id: <200502040238.57048.adobriyan@mail.ru>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502020315.14281.adobriyan@mail.ru> <200502031556.59319.adobriyan@mail.ru> <4202779C.6010304@mvista.com>
In-Reply-To: <4202779C.6010304@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Greg KH <greg@kroah.com>, phil@netroedge.com, sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

On Thursday 03 February 2005 21:12, Mark A. Greer wrote:

> > >+		mv64xxx_i2c_fsm(drv_data, status);
> >
> >It can set drv_data->rc to -ENODEV or -EIO. In both cases ->action goes to
> >MV64XXX_I2C_ACTION_SEND_STOP and mv64xxx_i2c_do_action() will writel()
> >something. Is it correct to _not_ check ->rc here?
> 
> I think so.  It still needs to go into do_action even when rc != 0 (in 
> which case it'll do a STOP condition).

Ok. Thanks for the explanation. Agree, ->rc should be left as is.

> This patch is a replacement patch that should address your concerns 
> except maybe the mv64xxx_i2c_data.rc one.

> --- a/include/linux/i2c-id.h
> +++ b/include/linux/i2c-id.h

> +					/* 0x170000 - USB		*/
> +					/* 0x180000 - Virtual buses	*/
> +#define I2C_ALGO_MV64XXX 0x190000       /* Marvell mv64xxx i2c ctlr	*/

While I searched for typos and you're fixing them, au1550 owned 0x170000.
2.6.11-rc3 says:

	#define I2C_ALGO_AU1550 0x170000 /* Au1550 PSC algorithm */

So, I'd remove first two comments.

Oh, and the last note: current sparse and gcc 4 don't produce any warnings.

	Alexey
