From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6.12-rc4 3/3] (dynamic sysfs callbacks) device_attribute
Message-Id: <20050511170750.GE15398@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705051100583c6b1ffb@mail.gmail.com>
In-Reply-To: <2538186705051100583c6b1ffb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org, Justin Thiessen <jthiessen@penguincomputing.com>

On Wed, May 11, 2005 at 03:58:35AM -0400, Yani Ioannou wrote:
> -static ssize_t show_in(struct device *dev, char *buf, int nr)
> +static ssize_t show_in(struct device *dev, char *buf, void *private)
>  {
> +	int nr = *((int*)private);

What's wrong with a simple:
	int nr = (int)private;

thanks,

greg k-h
