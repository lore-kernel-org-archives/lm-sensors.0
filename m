From: Luca Tettamanti <kronos.it@gmail.com>
Date: Fri, 11 Dec 2009 13:04:52 +0000
Subject: Re: [lm-sensors] ATK0110 breaks keyboard and mouse on asus p7p55d -
Message-Id: <68676e00912110504u17d43c73u16efaeeb167741ce@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

(your mailer didn't insert the From: header... weird)

On Fri, Dec 11, 2009 at 12:51 AM,  <> wrote:
> i wanted to report the above mentioned.
> The sensors display with atk0110 itself is ok.
> But after a while, like one or two minutes after reboot, my keyboard and my
> mouse stops responding.

It's very strange since I had a tester that helped my with the very same board.
What kind of keyboard/mouse are you using? PS2 or USB?
Can you access the machine remotely (ssh)? If so, please send me a
dump of /proc/interrupts _after_ the keyboard becomes unresponsive.

> The system is still running, i can see "things happen" ;) like
> the seconds of my statusbar clock.
> Its just the mouse and the keyboard, anyway i had to cold reboot.
> After removing the driver again, everything works fine (except
> speedstepping/turboboost, which completely freezes my box, but thats
> another thing ;)

Ok, the only difference between working and non-working is the atk0110 driver?

Locate atk_ec_present function in asus_atk0110.c; put a

return 0;

as first instruction; recompile and see if it still locks up the keyboard.
Also enable HWMON_DEBUG_CHIP.

thanks,
Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
