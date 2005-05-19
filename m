From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: [od@fet.uni-hannover.de: Trying to find device chrontel 7009
Message-Id: <20031014222458.2bed4bb5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031013205850.GA2164@frodo.local>
In-Reply-To: <20031013205850.GA2164@frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I have a Hermes 845GL with chrontel encoder for video output. Problem 
> is: although I can set in Bios that it should produce PAL signal, I 
> allways get NTSC. I already found register which has to be modified 
> only problem is how to find the device.
> 
> I hoped that chrontel chip is connected to i2c controller of i845, 
> which can be accessed through i810 driver (afaik - or there is another
> 
> chip inside i did not find yet).
> 
> Unfortunatelly scan_bit=1 does not find any device only a couple of 
> dots or ".S <7>0<7>needed 0 jiffies" id debug=9. I am not very familar
> 
> to i2c code, so my digging in that code ended up in nothing.
> 
> Can you give me some hints how to find the device and how to adress?
> Is ther some docu I missed to read about i2c drivers for linux (or 
> lm_sensors)?

What you need to do is scan your i2c bus. Get the sensors-detect script
that comes with lm_sensors, and run it. It should tell you which devices
are available on your system. It will probably not identify your video
decode chip, because it's mainly aimed at sensor chips, but at least
it'll tell you at which address the chips were found (you can also use
i2cdetect to obtain the same information).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
