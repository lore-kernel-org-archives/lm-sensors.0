From: Jean Delvare <jdelvare@suse.de>
Date: Sat, 06 Dec 2014 12:12:31 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm75) Strengthen detect function
Message-Id: <20141206131231.25f101d1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1417716250-14598-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1417716250-14598-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 5 Dec 2014 08:47:24 -0800, Guenter Roeck wrote:
> I was trying to run a module test for tmp421 while having the lm75 driver
> loaded. Loading the i2c-stub driver with address 0x4c caused lm75 detection
> to run, which detected the simulated chip at 0x4c as lm75 (because all
> registers in i2c-stub are initially set to 0) and instantiated it. This of
> course was a bit of a bummer when I tried to manually instantiate the tmp421
> afterwards, causing my module test to fail. So it wasn't a real chip, just
> an annoying side effect of trying to use i2c-stub while the lm75 driver
> was loaded.

Yes, I had the same problem with i2c-stub in the past while testing
multiple drivers. I've fixed detection functions each time it happened.
Feel tree to fix every i2c detection function which trips on all-zeroes.

> (...)
> Guess I'll apply the patch as-is. If anything I wonder if it would make sense
> to add the same test to sensors-detect (in addition to the comparison).

As you wish, I'm fine both ways.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
