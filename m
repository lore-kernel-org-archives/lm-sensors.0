From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 02 Mar 2014 15:09:33 +0000
Subject: Re: [lm-sensors] LM73 chip access through userspace
Message-Id: <20140302160933.43c9e261@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAAi8uRy6EmTDvKavChvx6_bUZvcoVD3Et=Tt5R66h6NkkHAcUA@mail.gmail.com>
In-Reply-To: <CAAi8uRy6EmTDvKavChvx6_bUZvcoVD3Et=Tt5R66h6NkkHAcUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2 Mar 2014 07:03:22 -0800, Romanic Dean wrote:
> Thanks Jean for your kind response.
> 
> Yes I could see some entries under /sys/class/hwmon/hwmon0
> 
> hwmon0 is probed well at boot time but I couldn't see hwmon1 is probed at
> boot time?
> 
> Is it because of only one reg =<0x49> entry in dts file?

Yes. Each hardware monitoring device is represented by a hwmon class
device in the kernel. If you have a single LM73 chip in the system, you
get hwmon0 and that's it. If you have several LM73 chips, you must
declare all of them in the device tree.

> Also it would be great if you can point me out any example where  temp from
> lm73 sensor is read by sysfs?
> 
> I am sure some one has already worked on it.

You are asking the wrong question. There's really nothing specific
about lm73. All hwmon drivers implement a standard sysfs interface, so
it doesn't matter if you have an LM73 or any other temperature sensor
chip.

I already told you that you can use "sensors" to read the temperature
value, there's nothing more I can add, until you tell me why that isn't
suitable for your needs (or that it doesn't work, and you report enough
details about the failure so that we can help you figure it out.)

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
