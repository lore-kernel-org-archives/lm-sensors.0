From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 19 Dec 2007 14:54:12 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] : hwmon - new chip driver for TI
Message-Id: <20071219155412.4519fb43@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4754441F.1030405@linuxrealtime.co.uk>
	<20071212022550.d8d3b295.akpm@linux-foundation.org>
	<4768340C.60208@linuxrealtime.co.uk>
In-Reply-To: <4768340C.60208@linuxrealtime.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steve Hardy <steve@linuxrealtime.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Steve, Andrew,

Thanks for the review Andrew. I have some more comments, I'll reply to
the original post.

On Tue, 18 Dec 2007 20:56:44 +0000, Steve Hardy wrote:
> >> +static int ads7828_attach_adapter(struct i2c_adapter *adapter)
> >> +{
> >> +    if (!(adapter->class & I2C_CLASS_HWMON))
> >> +        return 0;
> > 
> > Can this happen?
> 
> Hmmm, this code exists in pretty much all of the other hwmon
> drivers, so I will leave it in.
> 
> I think it relates to I2C vs ISA connected devices, to avoid
> detecting something with the correct ID on the wrong bus?

Not at all ;) It relates to I2C buses being used in various devices
such as TV adapters, which do not have hardware monitoring chips and do
not like being randomly probed for I2C devices as most hardware
monitoring drivers do when you load them.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
