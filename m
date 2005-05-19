From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Conversion guide for i2c chip drivers
Message-Id: <20030928165441.GA25879@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030927122451.191bb291.khali@linux-fr.org>
In-Reply-To: <20030927122451.191bb291.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Sep 28, 2003 at 03:15:07PM +0200, Jean Delvare wrote:
> 
> > > In the detect function, why is memset called on client data before
> > > it is filled?
> > 
> > Because the struct device burried in that structure needs to be set to
> > 0 before the register function is called.
> 
> This doesn't answer my question. I know what memset does. What I don't
> know is why this is done, or, to make my question more precise, why it
> is done in 2.6 and wasn't in 2.4.

Again, we have to initialize a struct device to 0 before register is
called, otherwise we oops the kernel.  2.4 does not have a struct device
in the i2c code (or anywhere actually...)

But hey, don't trust me, try not doing it and see what happens :)

> Mmm, maybe I get it now. You plan to introduce an i2c_set_clientdata
> function in 2.4, which will access client->data instead of client->dev
> as it is the case in 2.6. Is that it?

Yes, that's it.

> OK, I've made the requested changes, plus some others. Document
> attached.

Looks good, thanks for doing this.

greg k-h
