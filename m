From: matthias@hentges.net (Matthias Hentges)
Date: Tue, 05 Sep 2006 15:30:57 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and minor problems w/
Message-Id: <24283.136.1.1.33.1157470257.squirrel@213.196.247.205>
List-Id: <lm-sensors.vger.kernel.org>
References: <1157458671.18988.34.camel@mhcln03>
In-Reply-To: <1157458671.18988.34.camel@mhcln03>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello David,

thanks for your reply.

On Tue, September 5, 2006 16:55, David Hubbard wrote:
> Hi Matthias,
>
> Nice to get some feedback on w83627ehf. The datasheet documents only 4
> RPM sensors, but 5 pwm outputs. That's if your motherboard uses the
> standard w83627ehf without any additional electronics.
>
> Can you disconnect one fan at a time while in the BIOS readings and
> verify that each is independent of all other fans? I wonder if the
> BIOS is actually getting 5 independent RPM readings.

I will do so when I get home. However, I am pretty sure that these 5
readings are independent of each other.

> Also, is there some way (a different OS, or in the BIOS) that you can
> actually control each of the fans independently?

Windows users report that they can indeed controll all 5 fans  with a tool
called "SpeedFan" or something like that. I will investigate =)

> I'm looking for more
> info on your motherboard, but there is the possibility that the two
> CHA fans and the two PWR fans are actually hard-wired together. The
> Asus page
> (http://www.asus.com/products4.aspx?modelmenu=1&model98&l1=3&l2&l3$8)
> says you have the Intel 975X and Intel ICH7R chipsets, but that's all
> the time I have right now to google...  If you discover on google that
> there are similar questions on forums, etc., that might provide a
> clue. Otherwise, look at the board and see if there are any additional
> chips - I have an Asus motherboard and the w83627ehf chip is actually
> not hard to find. On mine, it's in the corner next to the ram slots.
>

I will have a look.

> Do the fans have three or four pins? (Just curious)

The CPU fan has 4 pins, the other 4 only have 3.

> Can you provide a listing of the sysfs files exported by the driver on
> your system? The w83627ehf pins for fans 4 and 5 can be programmed as
> general purpose I/O, and the driver detects whether you have 3, 4, or
> 5 fan pins configured. (The setting is read, but not changed.) So...do
> you have pwm4 and pwm5 in your sysfs?

I will send you the complete listing when I get home but I can already say
that there is

pwm1 to pwm4, no pwm5

Thanks for your time

-- 
Matthias Hentges

