From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 Sep 2012 13:49:23 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] hwmon: (ina2xx) Fix word size register read and write operations
Message-Id: <20120912154923.76ce48a6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347381259-14585-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1347381259-14585-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 12 Sep 2012 06:41:19 -0700, Guenter Roeck wrote:
> On Wed, Sep 12, 2012 at 10:24:41AM +0200, Jean Delvare wrote:
> > Agreed, down to 3.2 (when i2c_smbus_read/write_word_swapped were
> > introduced.) If anyone needs the fix for a kernel older than this, it
> > will have to be implemented differently.
> > 
> Fortunately, that driver was only introduced in 3.5 (and I didn't realize the
> be16 problem when reviewing it ;).

Doh, my bad, I was looking at the max1111 driver history :/ Doing too
many things at once...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
