From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 10 Jan 2012 17:04:34 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] lm80.c: reset device if error occurred
Message-Id: <1326215074.2649.83.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326206976-7846-2-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1326206976-7846-2-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-01-10 at 09:49 -0500, Frans Meulenbroeks wrote:
> if an error occurs while updating (e.g. because the chip was
> disconnected) the device needs to be reinitialized in order
> to get back to 11 bit temperature and set the fan divider
> 
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>

Queued for -rc2, thanks.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
