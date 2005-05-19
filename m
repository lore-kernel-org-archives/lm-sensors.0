From: chris_honschu@gmx.de (honschu)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: Userquestion: A/D-Converter on Parport
Message-Id: <200310182049.38529.chris_honschu@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

First of all: I am a Newbie and since three days I am trying to read and learn 
as much as I can, because I have to do a study-project. I tried to 
understand: the i2c-Documentation in my 2.4.22 Kernel, some general 
I2C-Docus/FAQs and a Linux-Hardware-Control book. I also red the new_drivers 
file and didn't undertand mutch of all ;)

The goal of this study-project is to attach a A/D-Converter (Analog-Voltage to 
Digital-Signal) to a PC. It is a learn-project where other students (and I) 
should learn principles about electronics and computer-measurement. Voltage 
over a  pt100 (resistor variegating Ohm by tempreature) should be transfeard 
by a 16-Bit A/D-Converter into a PC. It would be great to have/make a program 
that reads more than 3 times a secound the measured voltage-value. So that I 
can display it for example with gnu-plot or at realtimie.

So I bought a I2C 7Bit-Adress ADS1110 (ADS1110A0IDBVT by TexasInstruments) 
16-Bit and would like to mount it to a i2c-philips-par wireing.
The Datasheet of the ADS1110 can be found at: 
http://www-s.ti.com/sc/ds/ads1110.pdf

But howto talk to the ADS1110 ? Is there a simple C Program/Example?  Is it 
hard to write sutch a driver? Do I have to be root to read out the values? 
Are there other known similar projects to mine?

I found the Hadware Hacking Site and supposed that my project should be 
possible.

Is there someone who could help me, is interested in contribution? 

regards
Honschu

PS: I would like to subscribe to the mailinglist to learn more.
