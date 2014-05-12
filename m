From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 01:50:12 +0000
Subject: Re: [lm-sensors] [PATCH 0/3] First shot at a hwmon device name mapper
Message-Id: <537028D4.9070907@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20140509100104.3dcdb46d@endymion.delvare>
In-Reply-To: <20140509100104.3dcdb46d@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/09/2014 01:01 AM, Jean Delvare wrote:
> Hi all,
>
> As discussed lately on this list, here is a first shot at a helper
> binary that resolves libsensors chip names to kernel device names and
> back.
>
> This is really a proof of concept at this point. Everything can still
> be discussed and changed, just speak up if you see any problem or to
> ask for improvements. Specifically I have no preference for the tool's
> name or its command line interface, so if you can think of anything
> better, just let me know.
>

I tried with udev, but that doesn't work - if I understand corretly,
device rename support needs explicit kernel support per subsystem.
The networking subsystem does it with dev_change_name(). Other than that
there is device_rename(), which is hardly used.

So I guess we have no other choice than something like this, unless we go
radical and start using per-driver names (coretemp0 instead of hwmonX).
But I think even that would not be reboot-safe, for example on a system
with multiple sensors of the same type connected to different i2c busses.
Anyway, not sure if that would be a good idea to start with.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
