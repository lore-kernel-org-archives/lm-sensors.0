From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 16 Mar 2011 21:04:14 +0000
Subject: Re: [lm-sensors] [RFC PATCH 0/3] Support for all SHT15 features
Message-Id: <1300309454.20292.112.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300301050-15529-1-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1300301050-15529-1-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2011-03-16 at 14:44 -0400, Vivien Didelot wrote:
> The SHT15 sensor supports several functionalities such as i/o
> checksumming, an embedded heater for dew point cross-validation, two
> resolution settings and a device-specific feature known as OTP reload.
> This set of patches brings the ability to use these features.
> 
> The first patch adds support for CRC calculation.
> 
> The second patch adds the ability to read the status register through
> several sysfs attributes.
> 
> The last one adds support to change the status register, through
> those individual sysfs attributes.
> 
> Jerome Oufella (1):
>   hwmon: sht15: add checksum validation support
> 
> Vivien Didelot (2):
>   hwmon: sht15: add support for reading the status register
>   hwmon: sht15: add support for writing the status register
> 
>  drivers/hwmon/sht15.c |  525 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 files changed, 499 insertions(+), 26 deletions(-)
> 
All those undocumented sysfs attributes ....

Two questions:
- Which of the new attributes are really expected to change during
  runtime ?
  If an attribute is not expected to change during runtime, it should be
  configured statically (eg with platform data or device tree), and not
  with a sysfs attribute.
- For any remaining attributes, does they really add value ?
  If they adds value, it may add value for other drivers as well and may
  warrant an ABI extension. If so, that should be discussed.

Either case, I would expect attributes to be documented. If that means
that driver documentation needs to be added in the first place because
it does not exist - maybe that should be first priority anyway before
adding new functionality to a driver.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
