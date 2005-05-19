From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: FW: Fix for problems with the Intel 82810 driver of lm-sensors
Message-Id: <3DD42063.D7A757ED@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <PFEKKDLGBCAKPFINAMGJEEPHCBAA.michael@5dot1.de>
In-Reply-To: <PFEKKDLGBCAKPFINAMGJEEPHCBAA.michael@5dot1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'll take a look at it this weekend since I'm supporting the 810 driver.

On the FS451, see doc/developers/new-drivers if you haven't already.
I'll put an ID in for you.

mds

Michael Dreher wrote:
> 
> Hi!
> 
> Some days ago, I sent a patch for the i2c-i810 driver to Frodo Looijaard,
> because
> he has written this driver but maybe I used an old address, or he's just
> busy,
> so I got no reply from him.
> 
> I also sent the mail to some people that had problems with the driver and I
> got a positive feedback from David Michael <dave@drinkfromthefurrycup.com>.
> He said, that the patched driver fixes his problems.
> 
> Attached, you will find my original mail with the patch included. it would
> be nice if you could incorporate my changes to one of the next versions
> of lm-sensors.
> 
> In the meanwhile I finished a first version of my fs451 driver. Could you
> please assign me an official driverid for my driver in i2c/kernel/i2c-id.h?
> I used the constant named I2C_DRIVERID_FS451 for the driverid. When my
> driver
> is ready to be released, I will send that driver to you.
> 
>   Best Regards
> 
>      Michael Dreher
>      <michael@5dot1.de>
> 
> -----Urspr?ngliche Nachricht-----
> Von: Michael Dreher [mailto:michael@5dot1.de]
> Gesendet: Donnerstag, 31. Oktober 2002 00:15
> An: Frodo Looijaard; alp_chen@hotmail.com;
> dave@drinkfromthefurrycup.com; ppignon@eprocess.fr
> Betreff: Fix for problems with the Intel 82810 driver of lm-sensors
> 
> Hi Frodo!
> 
> I bought a MediaPortal some weeks ago. This is a SetTopBox with a DVB card
> that
> can be also used as a WebBrowser. It's based on a standard PC with a Celeron
> CPU and a Intel 82810 Chipset. To improve the tv-out capabilities a Focus
> FS450
> chip is also integrated. This chip has similar functions than the bt869 that
> is
> already supported by lm-sensors.
> 
> The FS450 chip is connected to the i2c bus of the 82810. My problem was,
> that
> the i2c-i810 module detected my 82810 chipset (device ID 0x7121), but
> i2cdetect and i2cdump never detected any i2c devices, neither on the
> i2c bus, nor on the ddc bus.
> 
> I tried to figure out where the problem and read some parts of the smbus and
> the
> Intel 82810 specs. I came to the conclusion, that something is wrong with
> data
> direction of the sda and probably the scl lines of the bus. The driver
> assumes, that when a line is set to high it is the same as setting it to
> input mode, but this is not correct, at least not for my specific chipset.
> 
> Here I send you a diff and my version of the i2c-i810.c file that fixed my
> problem.
> In the support forum, I found the support tickets #419, #615 and #728 that
> may be fixed
> with the patch, therefore I also send this mail to the originators of that
> tickets.
> The base for my patch was lm-sensors 2.6.4 and I'm using kernel 2.4.19 and
> i2c 2.6.4.
> 
> To the originators of the support tickets:
> Please let me know if this solves your problems. The MediaPortal is my only
> hardware
> with a 82810 chipset, so I can't do much testing.
> 
>   Best Regards
> 
>     Michael Dreher
>     <michael@5dot1.de>
> 
>   --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
>                     Name: i810_fix.diff
>    i810_fix.diff    Type: unspecified type (application/octet-stream)
>                 Encoding: quoted-printable
> 
>                  Name: i2c-i810.c
>    i2c-i810.c    Type: unspecified type (application/octet-stream)
>              Encoding: quoted-printable
