From: ebs@ebshome.net (Eugene Surovegin)
Date: Wed, 04 Oct 2006 16:09:12 +0000
Subject: [lm-sensors] [PATCH] PowerPC 4xx I2C driver - add
Message-Id: <20061004160912.GA18451@gate.ebshome.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061004032510.GA10354@gate.ebshome.net>
In-Reply-To: <20061004032510.GA10354@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 04, 2006 at 11:59:46AM +0200, Jean Delvare wrote:
> Hi Eugene,
> 
> Wrong maintainer, and wrong list. I am the i2c maintainer, Greg is no
> longer, and there's a mailing list dedicated to i2c:
>   http://lists.lm-sensors.org/mailman/listinfo/i2c
> 
> Please resend to this list, thanks.

Oops, it was a long time since I sent any i2c patches. Frankly though, 
I don't understand your request to resend it to the other list as 
it seems it reached the right person anyway and patch is beyond 
trivial :).

> 
> > This small patch adds calls to the functions request_mem_region and
> > release_mem_region.
> 
> That I can see by just reading the patch. A more useful description
> would be _why_ this is needed.

Well, I let the author explain then.

Personally I don't care if this patch is accepted or not. Driver is 
working just fine without it.

-- 
Eugene

