From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 25 Dec 2006 18:23:55 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <20061225192355.b4fca03e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Sun, 24 Dec 2006 20:58:48 -0800, David Hubbard wrote:
> > The 4 LSB of the Super-I/O chip ID (4 LSB of LPC register 0x21) are
> > subject to change in the future, which is why we mask them out when
> > checking for device ID.
> 
> I updated the comment and replaced the 4 LSB with zeros. There isn't
> room to note that the 4 LSB are ignored in the comment, but the
> implementation uses SIO_ID_MASK = 0xFFF0, so it should be correct. In
> w83627ehf_find(), I thought about masking val when printing the
> KERN_WARNING, but I prefer more information rather than less
> information. Also, I think the it is more readable to mask val in
> switch (val & SIO_ID_MASK).

Agreed, I'm fine with your implementation.

> > Strange choice. You store one specific difference between both chips
> > first, then deduce the chip name again based on this difference. A
> > saner approach would be to store the chip id (or kind) as a global, and
> > then in w83627ehf_detect(), use the value to set the number of voltage
> > inputs as a data structure member. It would be much more flexible that
> > the current approach. This will also make your job easier when
> > converting the driver to a platform driver.
> 
> I agree. I would prefer to store specific values in w83627ehf_data and
> detect the chips only once. However, I went with a compromise and so
> in w83627ehf_find() when I detect the 627ehf, 627ehg, or 627dhg, I
> store one value (w83627ehf_num_in) when I should be storing both
> num_in and name. I consider the creation of a global variable a poor
> solution, and I will change the implementation as quickly as possible.
> I don't want to detect things twice (once in w83627ehf_find() and
> later in w83627ehf_detect()).

Well, you do detect things twice in the current implementation too.
There's no way around it as long as the driver is based on i2c-isa.

> > You can take a look at the it87 driver, it does exactly this.
> 
> I will, in a future patch.

OK, I'm looking forward to it :) If you do it at the same time you
convert the driver to a platform driver, f71805f will be a better
example though.

> > This last paragraph isn't particularly helpful, "test" and "reserved"
> > really mean the same.
> 
> Yes, but I feel the information is still worth adding, for
> completeness. (It could be argued that all the information in this
> section isn't particularly helpful; one should just read the driver. I
> would argue that it is still worth having.) I have left it in the
> patch, but if you feel strongly about it, I'll delete it.

No, I don't. It's your patch after all ;)

So, your patch is applied, and will be in the next -mm kernel, and will
then go in kernel 2.6.21:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-w83627ehf-add-w83627dhg-support.patch

Thanks for your contribution.

-- 
Jean Delvare

