From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 May 2011 19:24:37 +0000
Subject: Re: [lm-sensors] [GIT PULL] hwmon updates for 2.6.40
Message-Id: <1306265077.2163.419.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1306164092-13024-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1306164092-13024-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Per,

On Tue, 2011-05-24 at 15:15 -0400, Per Dalén wrote:
> > Hi Jean,
> >
> > On Mon, 2011-05-23 at 16:07 -0400, Jean Delvare wrote:
> >> Hi Guenter,
> >>
> >> On Mon, 23 May 2011 08:21:32 -0700, Guenter Roeck wrote:
> >> > Per Dalén (1):
> >> >       hwmon: Add support for MAX6642
> >>
> >> I see no trace of this device on wiki/Devices nor in sensors-detect.
> >> Can it be added please?
> >
> > While writing the sensors-detect code, I concluded that device detection
> > is too weak. I requested samples; once I get those I'll either improve
> > the detection code or drop it from the driver.
> >
> 
> I'll try to do it tomorrow when I access to the card.
> 
That would be great. One possibility would be to check for non-existing
registers, eg registers 0x04, 0x06, 0xff, which are supported by other
Maxim chips. Reading such registers will likely return the previously
read value.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
