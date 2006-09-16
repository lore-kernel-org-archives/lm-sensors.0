From: oe@hentges.net (Matthias Hentges)
Date: Sat, 16 Sep 2006 21:09:50 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and minor
Message-Id: <1158440991.10014.3.camel@mhcln03>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Freitag, den 15.09.2006, 23:21 +0200 schrieb Rudolf Marek:
> Hi all,
> 
> Good news everyone, the mystery of fan5 is now uncloaked. It is short story. The
> bit0 in reg 47 is write only and reads always 0.

[...]

> All in all I think the usage as fan output for fan on/off is very very unlikely
> and I have done what I could to detect if it is this way.
> 
> > P.S. Working on an updated w83627dhg patch!
> 
> Good.
> 
> Matthias, please can you check if the patch is working for you? There might be
> some typos in code, please fix them if you can.
> 
> The patch should be applied on the top of:
> http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-w83627ehf-add-pwm-support.patch
> http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-unchecked-return-status-fixes-w83627ehf.patch
> 

Doesn't work for me :\ I still only get 4 fans.
Maybe you could add some debugging output?
-- 
Matthias 'CoreDump' Hentges 

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Dies ist ein digital signierter Nachrichtenteil
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060916/2893e8c2/attachment.bin 
