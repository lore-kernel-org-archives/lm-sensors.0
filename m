From: b-gruber@gmx.de (Berni)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lm_sensors && bt869
Message-Id: <1782081342.20040101120221@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031228153744.49065c91.khali@linux-fr.org>
In-Reply-To: <20031228153744.49065c91.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean Delvare,

am Donnerstag, 1. Januar 2004 um 08:10 schrieben Sie:

JD> So I invite you to submit a file names proposal on this list, as
JD> detailed as possible when it comes to the reasons of your choices each
JD> time it isn't obvious (and possibly even when it seems to be). We'll
JD> discuss it together to make sure it will be a safe base for future video
JD> drivers as well, and then you can go coding ;)

JD> Thanks.

Well...actually I think we need the following new names:
1. switch_ntsc : To tell the bt869 to output either ntsc or pal
(1=NTSC, 0=PAL)
2. switch_colorbars : 1 to turn on colorbars calibration screen and 0
to turn it off
3. change_colordepth : To change the color depth (for Voodoo3 there's
only 16 and 24bit for TV-Out-Mode, other would have 32bit here, too)
4. change_resolution[1-2] : 1 for the width(x) and 2 for the height(y)
5. switch_half_resolution : Switch to turn on the Half-Resolution-Mode
(this is a special mode which can't be merged with switch_resolution!)
6. switch_output_format : 2=RGB, 1=SVIDEO, 0=Composite

There's also a status[0-2] in there (read-only), but I couldn't figure
out what exactly this is for. It is used but as it seems it's only for
driver-internal things and not really for the end-user...Perhaps you could
take a look over it!


Bernhard Gruber
mailto:b-gruber@gmx.de
