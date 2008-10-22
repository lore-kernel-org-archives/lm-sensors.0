From: Trent Piepho <tpiepho@freescale.com>
Date: Wed, 22 Oct 2008 18:48:32 +0000
Subject: Re: [lm-sensors] Using hwmon in-kernel
Message-Id: <Pine.LNX.4.64.0810221135140.14386@t2.domain.actdsltmp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081008003041.GA20169@srcf.ucam.org>
In-Reply-To: <20081008003041.GA20169@srcf.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 20 Oct 2008, Matthew Garrett wrote:
> Here's the patch I mentioned. Most of it is noise to update all the
> drivers, but the substantive portion is in the hunks modifying hwmon.c
> and hwmon.h. lm90.c has been updated to add the callbacks. This only
> scratches my own itch, so doesn't add voltage or fanspeed handling (or
> whatever) - adding those would be trivial if anyone needs them. Like I
> said, individual drivers can be updated piecemeal.

I wonder if there is a way to do this that makes more use of the existing
sysfs interface?

Maybe something like:

/* @dev:	device with attribute
  * @attr:	attribute name
  * @buf:	buffer where result is placed
  *
  * Return value is the length of the result or an error code, i.e.
  * the same as the attribute's show() method returns.
  */
int sysfs_show_attribute(struct device *dev, const char *attr, char *buf);

or maybe use a struct device_attribute * as an argument.

Then you could just call sysfs_show_attribute(hwmondev, "temp2_input", buf) or
whatever and get the value in the kernel.  It would would with all drivers
without adding a code to them.

Of course there is the conversion to and from acsii.  That's certainly ugly. 
It could be wrapped inside a function that just returns an int and deals with
finding a buffer and converting from ascii, but the conversion would still be
there.  Compared to rate sensor values change, it's not very expensive.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
