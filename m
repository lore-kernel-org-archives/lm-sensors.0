From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:19 +0000
Subject: ISA check
Message-Id: <20030928004923.GG5084@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030927122942.54c4a7cd.khali@linux-fr.org>
In-Reply-To: <20030927122942.54c4a7cd.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 27, 2003 at 12:29:42PM +0200, Jean Delvare wrote:
> 
> Hi all,
> 
> In many (all?) of our i2c-only drivers, we have the following:
> 
> #ifdef DEBUG
>    if (i2c_is_isa_adapter(adapter)) {
>        printk
>            ("lm75.o: lm75_detect called for an ISA bus adapter?!?\n");
>        return 0;
>    }
> #endif
> 
> What's the idea? If the ISA addresses list is empty, is there a way we
> could be called for an ISA adapter anyway? And in that case, shouldn't
> we consider that the user knows what he/she's doing?

Good point, that should just be removed entirely.

Care to send me a patch? :)

thanks,

greg k-h
