From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 01 Aug 2007 16:47:44 +0000
Subject: Re: [lm-sensors] [i2c] Help on i2c-parport-light
Message-Id: <191fb4ca0708010947i6635939bi64219dd519ad9041@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Benoit,


> Hi,
>
> Thanks for your help. I managed to work out a solution. My C program had an error, that I eventually found.

Good.


> I have another question. Do you know how to change the Baud rate of the transfert? I would like to speed up my communication, I suspect to have to change i2c.c but I did not find the contant to change.

Check i2c-parport-light.c and change the udelay value in the following struct:

static struct i2c_algo_bit_data parport_algo_data = {
        .setsda         = parport_setsda,
        .setscl         = parport_setscl,
        .getsda         = parport_getsda,
        .getscl         = parport_getscl,
        .udelay         = 50,
        .timeout        = HZ,
};

And the description for udelay from i2c-algo-bit.h:
int udelay;             /* half clock cycle time in us,
                               minimum 2 us for fast-mode I2C,
                               minimum 5 us for standard-mode I2C and SMBus,
                               maximum 50 us for SMBus */


Maybe there's a way to change this value with a module load parameter,
but I couldn't figure it out. Didn't spend too much time on it
though...

...juerg



> Thanks
>
> ---- Original message ----
> >Date: Wed, 25 Jul 2007 09:11:56 -0700
> >From: "Juerg Haefliger" <juergh@gmail.com>
> >Subject: Re: [i2c] Help on i2c-parport-light
> >To: "Benoit Blanquet" <bblanqu2@uiuc.edu>
> >Cc: i2c@lm-sensors.org
> >
> >Hi Benoit,
> >
> >
> >> Hello,
> >>
> >> I work on a class project and I am experiencing some troubles using i2c-parport-light module. The goal of the project is to command a chip driving a steeper motor by I2C using the parport.
> >> I therefore develop a program capable of sending commands (2 to 9 bytes depending on the command) to the chip by using i2c-parport-light module.
> >>
> >> modprobe i2c-dev
> >> modprobe i2c-algo-bit bit-test=1
> >> modprobe i2c-parport-light type=4
> >>
> >> works.
> >>
> >> But a problem occurs when I want to transfer a random sequence of bytes to the chip.
> >> (I listen to the SDA and SCK lines by using an oscilloscope.)
> >> I use the write/read functions of i2c-dev.
> >> The second byte, listen on the SDA line, corresponding to the fist byte after the adress byte, differs from the one written into the buffer. What is more confusing is that the following bytes are the ones expected! Just the second byte is messed up.
> >> Morevoer, when the length of the complete word to be transmitted is above 6 bytes, the adress byte is messed up and set to 0x00.
> >
> >It would help if you could tell us what you write to the buffer and
> >what you actually see on the SDA output.
> >
> >...juerg
> >
> >
> >> I am a beginner in C and I2C parport and I would like to know if someone already experienced the same problem and if he/she found a solution.
> >>
> >> Thanks
> >>
> >> _______________________________________________
> >> i2c mailing list
> >> i2c@lm-sensors.org
> >> http://lists.lm-sensors.org/mailman/listinfo/i2c
> >>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
