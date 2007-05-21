From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 21 May 2007 14:53:16 +0000
Subject: Re: [lm-sensors] want to have write access to the repository
Message-Id: <20070521165316.39387e6a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <292eb50d0705152156u4af4ce65xdc2ff676cdc91a77@mail.gmail.com>
In-Reply-To: <292eb50d0705152156u4af4ce65xdc2ff676cdc91a77@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Manoj,

On Wed, 16 May 2007 10:26:10 +0530, Manoj Palhade wrote:
> I want access to the latest sources of the i2c bus driver from their
> cvs-Serve.
> 
> Please allow me to access for above code

No. We've never heard of you, you come in and ask for write access to
our source code repository. You didn't serious think we would accept,
did you?

Please first explain who you are and what you are trying to do. Then
we'll see how we let you help us.

The I2C bus drivers in SVN on lm-sensors.org are for Linux 2.4 only.
They are in maintenance mode, no active development is made there.
Development on the Linux 2.6 I2C bus drivers happens directly in the
Linux kernel tree. I've set up a page describing the process if you are
interested:
http://khali.linux-fr.org/devel/linux-2.6/i2c.html

Lastly, if you are only interested in I2C drivers and not hardware
monitoring, then the i2c mailing list would be more appropriate than
the lm-sensors list:
http://lists.lm-sensors.org/mailman/listinfo/i2c

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
