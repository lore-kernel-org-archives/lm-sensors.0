From: sukhdeep@gmail.com (Sukhdeep Johar)
Date: Mon, 13 Jun 2005 12:11:59 +0000
Subject: Fwd: [lm-sensors] w83781d.o: Subclient 0 registration at address 0x49
Message-Id: <2ef564dc05061303115994a667@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
It's really GREAT to see your mail !!

The chip is W83697F - that's what written on the chip.
I think it's the W83697_T_H_F chip..
I could not get it's data-sheet anywhere.. but i guess it's very similar to
the W83782d.

Is W83697_THF also ISA-only ?

I'm using lm-sensors 2.8.8

The temp2 and temp3 read as 68C and 16C while temp1 is movind around
27-32 range, which seems correct.

regards,
Sukhdeep


On 6/13/05, Jean Delvare <khali@linux-fr.org> wrote:
>
> Hi Sukhdeep,
>
> > I am using the chip W83697F chip.
>
> I assume W83697_H_F?
>
> > I am getting this error when loading the w83781d driver.
> > w83781d.o: Subclient 0 registration at address 0x49 failed
>
> This is quite strange, the W83697HF is an ISA-only chip, so it isn't
> supposed to have subclients. Which version of lm_sensors are you using?
> On which kernel?
>
> > I have tried  modprobe w83781d init=0 force_subclients=0,0x2c,0x4a,0x4b
> > without any succes..
>
> Which isn't surprising, as force_subclients only works for I2C chips,
> not ISA ones.
>
> > Can you please provide some insights.. I have run out of options :(
>
> Please try the w83627hf driver instead. The support of ISA-only chips in
> the w83781d driver is deprecated and will be removed soon.
>
> --
> Jean Delvare
>
