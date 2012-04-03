From: =?UTF-8?B?TnVtYW4gREVNxLBSRMOWxJ5FTg==?= <numand46@gmail.com>
Date: Tue, 03 Apr 2012 18:33:58 +0000
Subject: Re: [lm-sensors] sensors-detect changed screen's vertical rate
Message-Id: <CAHa016fKpw5ZGnvFAhiyB38VuSu-c28Ht_9sckMAe93m6vCneg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
In-Reply-To: <CAHa016ft3m21YqasTFMnc8oiHKNELQ6dcUk43-XJXTs4AOk5pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> Hi Numan,

   Hi Jean,

Thank you for your concer on this problem and kindness.

> For the records, please also tell us:
> * Which version of sensors-detect you used?

Version that I used is:

libsensors4 1:3.3.0-4ubuntu1
lm-sensors 1:3.3.0-4ubuntu1

> * Did you leave the default answer to every question, or did you ask
> =A0for probing which was disabled by default?

I answered all questions to yes.

> I see you're using the radeon driver on a RV380 chip. Do I understand
> correctly that this is a laptop and the screen you're talking about is
> the laptop's own screen? Fujitsu-Siemens Amilo Pro V2045, right?

Yes, it is a laptop and I am talking about it's screen. It is a
Fujitsu-Siemens Amilo Pro V2045.

> It would be great if you could dig your logs for a dump of your EDID  _be=
fore_ the corruption. The radeon driver logs this
> to /var/log/Xorg.0.log. If you can't find that, it would be great to find=
 another user with the same laptop who could provide > this dump.

Unfortunately, there is no dump of EDID in the Xorg.0.log. My screen
is a SAMSUNG LTN 154X3-L01.
Here is the Xorg.0.log output: http://pastebin.com/7Y2wRWpg
But, fortunately, I found some dump of EDID: http://pastebin.com/HDTG4T2W
There are 3 more of like this and they belong to same monitor, SAMSUNG
LTN 154X3-L01. They have same manufacturer, model, EDID version and
product year. All of this dump of EDID are exactly same.

> First run xrandr --verbose to have the detailed timings for 1280x1023, an=
d then use --newmode with 1023 replaced by > >  800
I took your advice and gave xrandr --newmode "try" 68.9 1280 1296 1544
1408 800 1024 1027 1039 command ( replaced 1023 with 800) Now, it is
better. I mean before this command, I could not see the bottom of
applications if I used them maximized but now I can see a little bit
of bottom of applications.

> I'd be more interested in the output of i2cdetect for each but for now. A=
lso I'm not sure what you were trying to achieve >with:

I thought i2cdump output would be usefull so I added them.
I loaded i2c-dev, eeprom and radeonfb modules than gave i2cdetect,
here is the output: http://pastebin.com/4fK1Y4P9

> I suspect you meant 0x50, not 0x60. Please try that and report. I would a=
lso need the (bogus) EDID dump from /var/log
> /Xorg.0.log.

Sorry, here is the result that you wanted:

sudo i2cdump 2 0x50
No size specified (using byte-data access)
Error: Could not set address to 0x50: Device or resource busy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
