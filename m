From: od@fet.uni-hannover.de (Oliver Dawid)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: [od@fet.uni-hannover.de: Trying to find device chrontel 7009 ...]
Message-Id: <200311041947.56508.od@fet.uni-hannover.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031013205850.GA2164@frodo.local>
In-Reply-To: <20031013205850.GA2164@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have been on vacations, so today is the first time, I could try out what you 
sent to me.

On Tuesday 14 October 2003 22:24, you wrote:
> > I have a Hermes 845GL with chrontel encoder for video output. Problem
> > is: although I can set in Bios that it should produce PAL signal, I
> > allways get NTSC. I already found register which has to be modified
> > only problem is how to find the device.
> >
..
> What you need to do is scan your i2c bus. Get the sensors-detect script
> that comes with lm_sensors, and run it. It should tell you which devices
> are available on your system. It will probably not identify your video
> decode chip, because it's mainly aimed at sensor chips, but at least
> it'll tell you at which address the chips were found (you can also use
> i2cdetect to obtain the same information).

thanks a lot for your info. I used sensors-detect to find out, on which 
adresses i2c components are connected to my system.

There are some interesting news:
I can load i2c-i810 driver but only DDC (what's that?) can be initialized.
Your script detected a i2c-i801 which has some devices attached to
its bus.

Output of sensors-detect looks like this below. I kicked out all lines which 
failed. Can you please help me interpret this? Does this mean, that there are 
8 devices connected to this bus? 0x00, 0x08, 0x30, 0x44 and 0x69 are unknown 
so one of thouse can be my video codec? How can I identify which device it 
is? I have a paper about chrontel 7009 chip with all register adresses but it 
don't seem to contain something like an identifier.

Client found at address 0x00
Client found at address 0x08
Client found at address 0x2e
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Client found at address 0x2f
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Client found at address 0x30
Client found at address 0x44
Client found at address 0x50
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x69

Thanks,
od
-- 
od@fli4l.de * http://www.fli4l.de/ * the on(e) disk router
