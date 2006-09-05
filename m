From: david.c.hubbard@gmail.com (David Hubbard)
Date: Tue, 05 Sep 2006 14:55:39 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and minor problems w/
Message-Id: <4dfa50520609050755j23ae4724v8c8fb798f68ae841@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1157458671.18988.34.camel@mhcln03>
In-Reply-To: <1157458671.18988.34.camel@mhcln03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Matthias,

Nice to get some feedback on w83627ehf. The datasheet documents only 4
RPM sensors, but 5 pwm outputs. That's if your motherboard uses the
standard w83627ehf without any additional electronics.

Can you disconnect one fan at a time while in the BIOS readings and
verify that each is independent of all other fans? I wonder if the
BIOS is actually getting 5 independent RPM readings.

Also, is there some way (a different OS, or in the BIOS) that you can
actually control each of the fans independently? I'm looking for more
info on your motherboard, but there is the possibility that the two
CHA fans and the two PWR fans are actually hard-wired together. The
Asus page (http://www.asus.com/products4.aspx?modelmenu=1&model98&l1=3&l2&l3$8)
says you have the Intel 975X and Intel ICH7R chipsets, but that's all
the time I have right now to google...  If you discover on google that
there are similar questions on forums, etc., that might provide a
clue. Otherwise, look at the board and see if there are any additional
chips - I have an Asus motherboard and the w83627ehf chip is actually
not hard to find. On mine, it's in the corner next to the ram slots.

Do the fans have three or four pins? (Just curious)

Can you provide a listing of the sysfs files exported by the driver on
your system? The w83627ehf pins for fans 4 and 5 can be programmed as
general purpose I/O, and the driver detects whether you have 3, 4, or
5 fan pins configured. (The setting is read, but not changed.) So...do
you have pwm4 and pwm5 in your sysfs?

HTH,
David

On 9/5/06, Matthias Hentges <oe at hentges.net> wrote:
> Hi all,
>
> since a few weeks ago I am the proud owner of an Asus P5W DH Deluxe
> mainboard. It features the w83627ehf chip for hardware monitoring. While
> all in all the monitoring works allright, there are a few minor
> bugs in this driver. Before I continue let me say that I have fans
> connected to every connector on this board.
>
> - The board has 5 fan connectors (1x CPU, 2xCHA, 2xPWR) and 5 RPM
> readings can be accessed in the BIOS, the driver however, only shows 4
> fans. It would be nice to get a reading of the missing fan =)
>
> - PWM control is a little bit confused:
>         - pwm1 controls _both_ CHA fans, not only one of them (the 2nd CHA fan
> is the one missing from
>         the driver)
>         - pwm2 works just fine and controls the CPU fan
>         - pwm3 doesn't change any fans at all
>         - pwm4 controls _both_ PWR fans, not only one of them
>
> It would be nice to get a pwm5 for the 5th fan and have every pwm
> control a single fan =)
>
> FWIW: Im running 2.6.18-rc4-mm3 right now.
> If you need more information or a willing test-subject, let me know.
>
> --
> Matthias 'CoreDump' Hentges

