From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jan 2012 14:21:36 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] drivers/hwmon/lm80.c: added error
Message-Id: <20120105152136.5ab6db99@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Frans,

On Mon,  2 Jan 2012 12:03:22 +0100, Frans Meulenbroeks wrote:
> added error handling so if lm80_update_device fails
> an error is returned when reading the value through sysfs
> This is closely modeled after the way this is handled in ltc4261
> (...)

Are you really still using  LM80 chips? These are pretty old and I did
not expect anyone to be still using them. And certainly not for new
designs... The device (at least the incarnations that existed in
1998-2000) was not reputed for its reliability...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
