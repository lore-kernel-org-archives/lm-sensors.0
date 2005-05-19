From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: fan speeds and temps no reading
Message-Id: <20050129162546.58a46ea2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1104907933.3003.195.camel@tooheys.tnsa.com.au>
In-Reply-To: <1104907933.3003.195.camel@tooheys.tnsa.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> tried commands below, looked ok to start with but, still nothing
> detected on the "i2cdetect" aside from the eeprom stuff at 50+.

Too bad :(

The dump you sent suggests that the GPIO reconfiguration failed (so I'm
not surprised that nothing new showed on the SMBus). What is really odd
is that two of the three writes succeeded according to isaset, while the
third one supposedly failed, but the dump doesn't agree with this at
all. I just don't get it. I wonder if something is trying to access the
chip concurrently (sounds like paranoia but I'm almost left to that at
this point).

I may have missed one configuration step. You can try again with this
additional step. Let's also enforce the logical device value for each
write, just in case (yes, I'm going paranoid).

(Note that you NEED isaset from lm_sensors 2.9.0 or CVS for the
additional command to work, as it requires the new masked write
feature.)

rmmod w83627hf
rmmod eeprom

isaset -y -f 0x2e 0x87
isaset -y -f 0x2e 0x87
isaset -y 0x2e 0x2f 0x2b 0x30 0x30
isaset -y 0x2e 0x2f 0x07 8
isaset -y 0x2e 0x2f 0x30 1
isaset -y 0x2e 0x2f 0x07 8
isaset -y 0x2e 0x2f 0xf2 0xe7
isaset -y 0x2e 0x2f 0x07 8
isaset -y 0x2e 0x2f 0xf0 0xe7
isaset -y 0x2e 0x2f 0x07 8
isaset -y 0x2e 0x2f 0xf1 0xe7
isadump -y 0x2e 0x2f 8 > w83627thf-ld8-1.dump
sleep 10
isadump -y 0x2e 0x2f 8 > w83627thf-ld8-2.dump
isaset -y -f 0x2e 0xaa

I invite you to put all the isaset and isadump commands in a shell
script so that you can run them all in a row. It will lower the risk
that something accesses the chip inbetween commands.

If registers 0xf0, 0xf1 and 0xf2 of the dumps still have value 0xff
after that, I'm giving up...

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
