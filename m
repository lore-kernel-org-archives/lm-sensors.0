From: mrenzmann@otaku42.de (Michael Renzmann)
Date: Tue, 27 Dec 2005 09:43:28 +0000
Subject: [lm-sensors] how to use the struct : i2c_client_address_data
Message-Id: <1135676608.4471.8.camel@gimli>
List-Id: <lm-sensors.vger.kernel.org>
References: <dfc7f2810512240116g7bb24a1cvf39d38a6e18b0317@mail.gmail.com>
In-Reply-To: <dfc7f2810512240116g7bb24a1cvf39d38a6e18b0317@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.

On Sat, 2005-12-24 at 17:16 +0800, herb wrote:
>       I think the struct   i2c_client_address_data   is used to probe
> a chip attached to the i2c bus,  but I can't see  how to set it
> properly.

I'm new to i2c, so take everything I say with a grain of salt.

Maybe having a look at how the probing is done with entries of this
struct helps to understand how it works. For example i2c_probe() in
drivers/i2c/i2c-core.c. In addition, the comments in include/linux/i2c.h
might add to the picture.

Hth.

Bye, Mike


