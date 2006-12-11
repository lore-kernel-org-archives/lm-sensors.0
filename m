From: david.c.hubbard@gmail.com (David Hubbard)
Date: Mon, 11 Dec 2006 17:42:57 +0000
Subject: [lm-sensors] FW: Tyan GS12
Message-Id: <4dfa50520612110942l2ee180e0y2a0a6d4004100ac9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612091617.kB9GH16e029812@srv1.nickelnetworks.com>
In-Reply-To: <200612091617.kB9GH16e029812@srv1.nickelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Paul,

I'm not in a position to debug the Tyan GS12, but from other posts to
the lm-sensors mailing list there might be a possible resolution. Can
you find out what the PWM frequency is for each motherboard? That
might make the difference.

I suggest you run the 'sensors-detect.pl' script and post the output
here on the list as a starting point. Then we can point you to the
maintainer of your driver, and they might have more information.

David

On 12/11/06, Paul Aviles <paul.aviles at nickelnetworks.com> wrote:
>
>
> Anyone?
>
>
> I have one for the masters... A few months I think back I posted a messages
> about two indentical boards having different fan speeds for no reason. At
> the end I changed the board with Tyan due to another problem and it solved
> the issue so I attributed to being a deffective board. So the replacement
> board came and after running it for maybe two months two days ago I woke up
> around 4 AM and the unit was loud again.... This actually had happened to
> all of the GS12 that I have.
>
> When you power a GS12 the fans are running at about 8000 rpms. So I use the
> following lines to lower them to about 6000 and they make little noise
>
> #echo "-2" > /sys/bus/i2c/devices/0-002e/pwm1_auto_channels
> #echo "-2" > /sys/bus/i2c/devices/0-002e/pwm2_auto_channels
> #echo "-2" > /sys/bus/i2c/devices/0-002e/pwm3_auto_channels
>
> #echo "32" > /sys/bus/i2c/devices/0-002e/pwm1
> #echo "32" > /sys/bus/i2c/devices/0-002e/pwm2
> #echo "32" > /sys/bus/i2c/devices/0-002e/pwm3
>
> Could it be that for some reason or another sensors somehow damages the
> electronics of the board or is it that Tyan boards are so bad? Their tech
> support is the worst I have seen,  people there have no clue of anything.
> Nobody according to them has ever reported this issue..... yeah.. and I am
> the only soul in the planet so lucky to have 7 identical systems (cpu,
> memory, hd and OS) and all 7 act differently!!
>
> The systems always have the same load, and the temperature has actually gone
> down due to the cold fronts so is not an issue with usage or real
> temperature.
> Any ideas as to what can cause the pwm of one or two of the fans to go crazy
> after a while?
>
> Regards,
>
> Paul
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>
>

