From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 25 Oct 2012 15:24:31 +0000
Subject: Re: [lm-sensors] Asus P7F-X w/ W83667HG-B pwm control problem
Message-Id: <20121025152431.GA16737@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
In-Reply-To: <CABkW7JOH6quu8kc56=Qm4+3ewqvtcpo7RsQKyYDyFtLd3_1pkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 24, 2012 at 06:40:33PM -0700, camden lindsay wrote:
> >
> > Hi,
> >
> > Please don't top-post.
> >
> > If you set anything but full speed mode, do you see different pwm values ?
> >
> > Also, please provide the output of
> >
> >         sudo isadump -y 0x295 0x296 0
> >         sudo isadump -y 0x295 0x296 8
> >         sudo isadump -y 0x295 0x296 9
> >         sudo isadump -y 0x295 0x296 10
> >         sudo isadump -y 0x295 0x296 11
> >
> > Thanks,
> > Guenter
> >
> >
> Sorry about the top-post, its a habit from working for years in gmail and
> never really taking part in mailing lists;  I really don't know the correct
> mannerisms.
> 
> Yes, pwm{1..3} change depending on the fan mode set in bios.
> Out of curiosity, is there a datasheet for the chip floating around?  It
> seems the manufacturer makes it on-request-only.  I couldn't find it online
> anywhere particularly easily... lots of bad results in a search.
> 
> 
> Hopefully this isn't too much to parse, but i've provided the
> /sys/bus/hwmon and the isadump  output for each of the fan settings  in bios
> 
Please download and install the driver from https://github.com/groeck/w83627ehf.
This is an experimental version which adds a couple of new features and,
specifically for you chip, a missing fan control mode. If we are lucky that
might solve your problem.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
