From: david.c.hubbard@gmail.com (David Hubbard)
Date: Sat, 18 Nov 2006 20:01:19 +0000
Subject: [lm-sensors] w83627ehf informations
Message-Id: <4dfa50520611181201o13730cecre671d379427e8c8a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1163284779.5555.34.camel@armageddon>
In-Reply-To: <1163284779.5555.34.camel@armageddon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Torsten,

This is the way the driver is designed to work. 0 is an invalid value
for pwm1_enable, and the driver returns EINVAL. As a result, the
write() function that bash uses returns the error, and bash reports
it. (Did that explanation make sense?)

So echo 1 > pwm1_enable and then echo some values > pwm1

Do you get the results you expect?

The values which pwm1_enable will accept are:
1 = manual mode
2 = thermal cruise

In the future, we will support the following values as well, but right
now they return EINVAL:
3 = rpm cruise
4 = smartfan III (thermal cruise)

This information can also be found in
/usr/src/linux/Documentation/hwmon, which you may find useful.

David

On 11/18/06, torsten goroll <2crazy4you at gmx.de> wrote:
> Hi all,
>
> strange things are going on:
>
> "echo 1 > /sys/class/hwmon/hwmon0/device/pwm1_enable" does work
>
> "echo 2 > /sys/class/hwmon/hwmon0/device/pwm1_enable" does work
>
> "echo 0 > /sys/class/hwmon/hwmon0/device/pwm1_enable" does not work: "bash: echo: write error: Invalid argument"
>
> "echo 0>/sys/class/hwmon/hwmon0/device/pwm1_enable" does not work but doesn write an error message
>
> if I try to write the 0 with vi: ""pwm1_enable" E667: Fsync failed"
>
> I'm not that familiar with linux to guess whats going on here. I will try to google a bit today afternoon, but if anybody has an idea I would be thankful.
>
> Torsten
> --
> Der GMX SmartSurfer hilft bis zu 70% Ihrer Onlinekosten zu sparen!
> Ideal f?r Modem und ISDN: http://www.gmx.net/de/go/smartsurfer
>

