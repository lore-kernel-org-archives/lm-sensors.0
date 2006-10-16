From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 16 Oct 2006 20:53:24 +0000
Subject: [lm-sensors] ticket #1986, occasional bad data from lm85
Message-Id: <20061016225324.36ad9059.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <453388EE.1090907@gmail.com>
In-Reply-To: <453388EE.1090907@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jason,

On Mon, 16 Oct 2006 09:28:14 -0400, Jason Craig wrote:
> I seem to be able to run i2cdump for all of these addresses except 0x69, which
> from what I gathered from the I2C tools page
> (http://netroedge.com/~lm78/i2ctools.html <http://netroedge.com/%7Elm78/i2ctools.html>) seems to be a clock chip.

Page which no longer exists, BTW, so I wonder how you read it.

> Here is the output I get for this address.
> # i2cdump -y 0 0x69 b
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 	 00: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
> 	 10: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
> 	 20: 0f 1f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
> 	 30: 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f    ????????????????
> 	 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 
> Basically, the first 4 lines of output are output as normal with a slight delay
> between echos, but then there is a short pause, and the rest of the lines are
> output immediately with no delay.  Subsequent i2cdump commands generate the
> following output immediately (no delay like before for the first 4 lines).
> 
> # i2cdump -y 0 0x69 b
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 	 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 	 f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> 
> I am assuming that I am hosing some hardware registers each time I try to dump
> this clock chip.  Maybe I shouldn't be trying to do that??  I'm not exactly
> sure.  The i2cdumps behave the same way until I reboot the system.  I've tried
> removing the modules from the kernel and then installing them again, but the
> problem? remains.

Our FAQ has the following entry of interest:

Q: What is at I2C address 0x69?

A: A clock chip. Often, accessing these clock chips in the wrong way
will instantly crash your computer. Sensors-detect carefully avoids
these chips, and you should do too. You have been warned. 

> Furthermore, subsequent i2cdetect commands give the following output:
> # i2cdetect -y 0
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 	 00:          XX XX XX XX XX XX XX XX XX XX XX XX XX
> 	 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 	 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX UU XX
> 	 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 	 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 	 50: UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 	 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 	 70: XX XX XX XX XX XX XX XX
> 
> Which shows that I don't have the same addresses as before.
> 
> Thanks for any suggestions.

You're good for a cold boot at this point.

-- 
Jean Delvare

