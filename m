From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Aug 2012 23:42:49 +0000
Subject: Re: [lm-sensors] help with i2cdetect
Message-Id: <20120801234249.GA17829@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAF+LJYhBpqcps-OYJBVPH22+GpdwfftOt+KszTYGUsKKOKNW-g@mail.gmail.com>
In-Reply-To: <CAF+LJYhBpqcps-OYJBVPH22+GpdwfftOt+KszTYGUsKKOKNW-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 01, 2012 at 04:10:41PM -0700, ed in 92626 wrote:
> Hi,
> 
> I am using your software for the first time.
> Does it work on Fedora17, kernel 3.1.0?
> 
> When I run it, 'i2cdetect -l' I get no devices back.
> 
> When I try i2cdump 0xa8 3 I get
> could not open file /dev/;i2c/168.
> 
> A8 is he address of my DIMM memory modue.
> 
> Does every i2c device need to have an entry in
> /dev? I checked two machines and don't see
> any i2c under /dev.
> 
> thanks if you have any info.
> 
Execute "sudo modprobe i2c-dev" first. Otherwise you won't see the i2c devices
in /dev.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
