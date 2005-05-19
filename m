From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6.12-rc4 3/3] (dynamic sysfs callbacks) device_attribute
Message-Id: <20050511170600.GD15398@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705051100583c6b1ffb@mail.gmail.com>
In-Reply-To: <2538186705051100583c6b1ffb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org, Justin Thiessen <jthiessen@penguincomputing.com>

On Wed, May 11, 2005 at 03:58:35AM -0400, Yani Ioannou wrote:
> Hi,
> 
> This patch presents as an example one possible way to use the dynamic
> callbacks to clean up one of the i2c chip drivers, adm1026 (for more
> information please see
> http://archives.andrew.net.au/lm-sensors/msg31310.html).
> 
> The first patch defines a new macros like DEVICE_ATTR that also sets
> the attribute private data (Greg whats your opinion on defining a
> separate set of macros for this v.s. rolling it into one macro?).

We should make a __ATTR macro instead, right?

> The second patch changes adm1026 to pass the sensor index/number via
> the private data pointer. I can't test this patch (so you won't want
> to apply this) but I'm CCing it to the adm1026 maintainer.

One patch per email please...

thanks,

greg k-h
