From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 02 Jan 2012 16:17:46 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] drivers/hwmon/ltc4261: set data->valid
Message-Id: <20120102161746.GA17788@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-1-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-1-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 02, 2012 at 06:03:20AM -0500, Frans Meulenbroeks wrote:
> if there is an error it is better to set data->valid to 0
> so the next call to ltc4261_update_device will always be
> executed
> 
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>

Makes sense. Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
