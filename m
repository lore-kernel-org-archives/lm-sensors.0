From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 29 Oct 2008 11:43:35 +0000
Subject: Re: [lm-sensors] Intel DG45FC
Message-Id: <20081029124335.5a5d4b78@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
In-Reply-To: <7bccedf10809181658o18aa47bbt46480ca2a67b1ac9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Anthony,

On Tue, 21 Oct 2008 12:06:43 -0700, Anthony Arobone wrote:
> Would the tech docs on this sensor be helpful?  I found them on the Intel
> site.  It describes all the registers in detail.
> 
> See Chapter 23.
> http://www.intel.com/Assets/PDF/datasheet/319973.pdf

This is the ICH10 (south bridge) datasheet. The ICH10 does indeed
include sensors for temperature and fans, but we don't support them.
And I doubt that's what your board uses though, as your BIOS also
displays voltage values while I don't think the ICH10 has voltage
sensors.

> Let me know if I can do any debugging or coding to help out.  I'm proficient
> in C and C++.  Just don't understand how all this sensor stuff works ;)

I just had a new idea. All users who reported the mysterious all-zero
LM96000 chip also have a PC8374L or compatible super-I/O chip. I am
almost certain that what sensors-detect identifies as an LM96000 is
actually the PC8374L super-I/O chip, as it is documented as exposing
its hardware monitoring registers on the SMBus.

Please provide a dump of the logical device 8 of your Super-I/O:

isadump 0x2e 0x2f 8

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
