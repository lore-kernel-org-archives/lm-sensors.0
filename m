From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 01 Feb 2012 17:52:05 +0000
Subject: Re: [lm-sensors] [RFC PATCH 3/3] hwmon: (hwmon-vid) Determine vrm during initialization, and add vrm
Message-Id: <1328118725.2261.91.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327495414-6256-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327495414-6256-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2012-02-01 at 11:19 -0500, Jean Delvare wrote:
> On Wed, 1 Feb 2012 08:06:31 -0800, Guenter Roeck wrote:
> > Another question: Several drivers read vid only once. That doesn't seem
> > to be correct; I thought the whole point of having vid is to have
> > dynamic voltage to the CPU. Should this be changed as well ? 
> 
> Congratulations Guenter, you just volunteered to convert all LPC-based
> hwmon drivers to the MFD framework! :D
> 
> Seriously, there can be two reasons why VID is read only once:
> * Old driver, predating frequency-scalable CPUs, and having never been
>   updated. Not sure if there are such drivers remaining.
> * LPC-based device with VID read from configuration space. Without
>   proper locking this is dangerous, so we only do it once at driver
>   load time. The only proper fix is to migrate the driver(s) to MFD
>   first.
> 
I think I'll rather leave that alone for now ;).

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
