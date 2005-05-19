From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: eeprom driver
Message-Id: <20020204134622.R1871@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020201105452.C1871@Stimpy.netroedge.com>
In-Reply-To: <20020201105452.C1871@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I think this was noted as a laptop.  Some of the strangest hardware
and I2C configurations are on laptops.  Sometimes battery/power
controllers and backlight controls may be on the SMBus/I2C, although
I'm guessing that the 0x57 isn't much more than a eeprom.  Perhaps
even for the Bios?


Phil

On Mon, Feb 04, 2002 at 04:34:30PM -0500, Mark Studebaker wrote:
> The 0x57 eeprom is clearly set up for some non-volatile storage on the motherboard.
> I see a lot of ASCII numbers and letters;
> At row E0, for example, is "11/15/01 13:26:37"
> This answers your second question.
> 
> Your first question (why the second slot doesn't make an appearance),
> I have no idea.
> 
> mds

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
