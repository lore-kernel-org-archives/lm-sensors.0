From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 04 Aug 2013 13:22:16 +0000
Subject: Re: [lm-sensors] [PATCH] iio: Add tmp006 IR temperature sensor
Message-Id: <51FE5588.4090204@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1375136888-19978-1-git-send-email-pmeerw@pmeerw.net> <51FE2F54.4050104@kernel.org>
In-Reply-To: <51FE2F54.4050104@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>

On 08/04/2013 03:39 AM, Jonathan Cameron wrote:
> On 07/29/13 23:28, Peter Meerwald wrote:
>> the TI TMP006 is a non-contact temperature sensor with I2C interface;
>> it measures the surface temperature of a distance object using a
>> thermophile to absorb IR energy emitted from the object
>>
>> the sensor has two channels: IR sensor voltage (16-bit) and reference
>> temperature of the chip (14-bit)
> Couple of nitpicks inline.
>
> I've cc'd lmsensors mostly to let them know I'm intending to take this into
> IIO.  It's clearly unconventional enough I would imagine it isn't going
> to get often used for hardware monitoring/
> Best to keep everyone informed (and check no one has strong views on
> this!)  We do have iio-hwmon these days if anyone does need that
> functionality.
>
Agreed.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
