From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Jul 2012 14:14:26 +0000
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon: add support for Sensirion C1 sensor
Message-Id: <20120726141426.GA15985@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1342789042-13433-1-git-send-email-johannes.winkelmann@sensirion.com>
 <20120721170150.GA13086@roeck-us.net>
 <CAEYbzYsTQttoOnkoYqw9RkDO1zUc3qpyg0CzEY11_=oqdk0H-Q@mail.gmail.com>
In-Reply-To: <CAEYbzYsTQttoOnkoYqw9RkDO1zUc3qpyg0CzEY11_=oqdk0H-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johannes Winkelmann <johannes.winkelmann@gmail.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Johannes Winkelmann <johannes.winkelmann@sensirion.com>

Hi Johannes,

On Thu, Jul 26, 2012 at 03:53:12PM +0200, Johannes Winkelmann wrote:
> Hi Guenter,
> 
> Thanks a lot for the feedback; I've incorporated most of it in
> preparation for a v2 of the patch; I have some comments on the points
> I'm not certain about:
> 
[ ... ]
> >> +
> >> +The device communicates with the I2C protocol. All sensors are set to the same
> >> +I2C address 0x70, so an entry with I2C_BOARD_INFO("shtc1", 0x70) can be used
> >> +in the board setup code.
> >> +
> > Please also provide a reference to the other means to instantiate the driver.
> 
> I've checked a couple of documentation files and haven't found what
> else I should add, in fact the other sensor documents I checked didn't
> cover this, except for the one from the sht21 after which I modelled
> the document. Could you give me a pointer where to look?
> 
Just add a reference to Documentation/i2c/instantiating-devices.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
