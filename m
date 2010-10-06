From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Oct 2010 16:10:35 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/3] hwmon: (lm90) Introduce chip
Message-Id: <20101006181035.2d0be736@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1286293108-28890-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1286293108-28890-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Oct 2010 08:30:21 -0700, Guenter Roeck wrote:
> On Wed, Oct 06, 2010 at 11:09:30AM -0400, Jean Delvare wrote:
> > On Wed, 6 Oct 2010 17:05:53 +0200, Jean Delvare wrote:
> > > I like this change a lot, even though it makes the binary module a
> > > little larger.
> > 
> > Err, scratch that, it doesn't. Not sure why I thought it did...
> > 
> At least it makes the source a bit larger.
> 
> One thought: Would it make sense to use initdata for the initialization code ?

Almost impossible for I2C device drivers, as you never know when
probe() will be called. For example, lm90 could be built into the
kernel, but the underlying i2c bus driver be loaded as a module...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
