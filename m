From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 02 Jan 2012 16:54:28 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] drivers/hwmon/lm80.c: added error
Message-Id: <20120102165428.GE17788@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 02, 2012 at 06:03:22AM -0500, Frans Meulenbroeks wrote:
> added error handling so if lm80_update_device fails
> an error is returned when reading the value through sysfs
> This is closely modeled after the way this is handled in ltc4261
> 
> Note: if update gets an error, this error is returned for all
> registers and no further reads are done.
> If a register is not accessible most likely the whole device
> is broken or disconnected and it is definitely interesting to know.
> 
> Note2: I added a macro to read and handle errors. This was felt to
> be the simplest. If someone feels it should be done using a
> subroutine, be my guest.
> 
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>

Another note: checkpatch.pl reports 2 errors and 10 warnings on this patch.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
