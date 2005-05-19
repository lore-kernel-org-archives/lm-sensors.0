From: vitalyb@mail333.com (Vitaly V. Bursov)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: ASB100 PWM
Message-Id: <20031111144852.45f8116a.vitalyb@mail333.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031111062929.GA30118@earth.solarsys.private>
In-Reply-To: <20031111062929.GA30118@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 11 Nov 2003 01:29:29 -0500
"Mark M. Hoffman" <mhoffman@lightlink.com> wrote:

> vitalyb wrote in ticket #1437:
> 
> > asb100??s chip address: 0x2d
> > pwm data address: 0x59
> > default value: 0x8f
> > 
> > lower nybble (with a mask 0x0f) regulates Power and Chassis Fans, but not a CPU
> > fan
> > 
> > it looks like if higher (7) bit is set, manual control is enabled, ie if
> > register contains 0x85 fan??s speed will be around 5/16
> > 
> > but if bits 5 and/or 6 are set and bit 7 is not, fan speed is constantly
> > lowering (approx. every 4 sec.)
> 
> So, I tried the attached patch (vs. current CVS) with no result here:
> modifying the pwm did not change any fan speeds at all.  But maybe
> there are different ASB100 revs?  Who knows?  The patch didn't
> seem to hurt anything, so if it works for you I'll commit it.

$ echo $[ 0x80 ] 1 > pwm1
It works for me! Thanks!


I have an Asus A7V8X mobo rev 1.04, ASB100 chip marking follows

ASB100-A    Bach
TPV268981   0240E

i2cdump`s output for banks 0-4 is attached.

And I checked a photo in the manual. It is a mobo rev 1.02
ASB100 marking:

ASB100-A    Bach
TKF100471AE 0227

Looks differently...

> BTW: thanks for the info... anything else you can find out about
> that chip, please email (sensors@stimpy.netroedge.com) us.

OK.

-- 
Regards,
Vitaly V. Bursov                    mailto:vitalyb@mail333.com
GPG Key ID: F95A23B9                http://www.gnupg.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: asb100-dump.gz
Type: application/octet-stream
Size: 683 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031111/0c1fbb89/asb100-dump.obj
