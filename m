From: Larry Lade <larry.p.lade@gmail.com>
Date: Thu, 05 Sep 2013 01:17:41 +0000
Subject: Re: [lm-sensors] Trouble with sensors-detect probing ASUS 1015E-DS03 laptop
Message-Id: <CADO8fxbznzh4NKGJN5ijyz6q9GVovZufSFLWNEx-Gr5zECD4qg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6884061641206010697=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CADO8fxbc7H6y32vm28GV3+ye7O+WnfpcvQQKMom5_CmbAQYbZg@mail.gmail.com>
In-Reply-To: <CADO8fxbc7H6y32vm28GV3+ye7O+WnfpcvQQKMom5_CmbAQYbZg@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6884061641206010697==
Content-Type: multipart/alternative; boundary=f46d043893bd6c427404e598b1c8

--f46d043893bd6c427404e598b1c8
Content-Type: text/plain; charset=UTF-8

Thank you Jean and Guenter for taking the time to reply.

Since it was still new, I decided to work with the retailer to replace the
device.

I have an suspicion there's a EEPROM in this device that is shipping
without write-protection set, and the sensors-detect probe rakes over it at
random before eventually eventually setting the chip into read-only mode.
If that's the case, then it's probably a lost cause. But EEPROM programming
is all very much over my head! I'm happy to not solve the mystery if I
don't have to.

Perhaps the thing to do is file a bug with Ubuntu to push out a more
up-to-date version of lm-sensors to their long-term support release.


On Thu, Aug 29, 2013 at 5:02 AM, Jean Delvare <khali@linux-fr.org> wrote:

> Hi Larry,
>
> On Sat, 24 Aug 2013 19:32:41 -0500, Larry Lade wrote:
> > I wanted to report an alarming issue running sensors-detect on my new
> > (Ubuntu 12.04 out of the box!) laptop.
> > (...)
> > At some point during one of these scans, there's a flash and SOMETHING
> > happens to the built-in LCD screen. I noticed it's as though the gamma
> > was all out of whack, the colors were washed out, and dithering
> > becomes notable everywhere. (Bad even for an 18-bit LCD.) Display
> > looks fine on an LCD connected by VGA port.
> >
> > This change survived the re-install of the operating system.
> >
> > I was getting desperate, thinking I had just zapped something and
> > voided the hardware, so I ran sensors-detect again. Probing either of
> > the two above adapters (they both seem to reference the same bit of
> > hardware) seemed to toggle something, restoring or corrupting the
> > screen quality.
> >
> > Or at least it did. It seems to have it stuck in "ugly" mode again,
> > and nothing on the display toggles any more when I run sensors-detect
> > any more. Is anyone able to help?
>
> I'm very sorry about this. As Guenter said, we have changed the code
> meanwhile to skip graphics adapters by default, and I can only urge
> Linux distributions to include that change.
>
> You may try to ask the hardware vendor for help. After all they did
> ship the software which broke the laptop, right? Even though they did
> not write it. I am willing to help but the problem is that it will be
> very difficult, if not impossible, to do so without intimate knowledge
> of the hardware, which only the vendor can provide. I would be very
> happy to cooperate with Asus on that matter if they want to. Only Asus
> knows exactly which I2C chips are connected to the graphics chip, at
> what address, and if any of them could be responsible for what you
> observe.
>
> Meanwhile, the first thing to try here is:
> * Shut down the machine.
> * Remove the battery.
> * Unplug the AC adapter.
> * Let the laptop rest that way for a moment, at least 10 minutes.
> * Plug everything back and start the machine.
>
> This has restored systems for me and others in the past, I can only
> hope it helps for you as well.
>
> If it does not, then if the laptop is new, I think I would just play
> the support/warranty card.
>
> You can also try changing the gamma setting with xrandr.
>
> > The LCD seems to be an AUO B101XTN01 (as reported by the EDID)
> > http://www.panelook.com/B101XTN01.0_AUO_10.1_LCM_parameter_19387.html
> >
> > lm-sensors 1:3.3.1-2ubuntu1
> >
> > linux 3.2.0-52-generic #78-Ubuntu SMP x86_64
> >
> >
> > $ sudo get-edid | parse-edid:
> >
> >     # EDID version 1 revision 4
> > Section "Monitor"
> >     # Block type: 2:0 3:f
> >     # Block type: 2:0 3:fe
> >     # Block type: 2:0 3:fe
> >     Identifier "AUO:dc11"
> >     VendorName "AUO"
> >     ModelName "AUO:dc11"
> >     # Block type: 2:0 3:f
> >     # Block type: 2:0 3:fe
> >     # Block type: 2:0 3:fe
> >     # DPMS capabilities: Active off:no  Suspend:no  Standby:no
> >
> >     Mode     "1366x768"    # vfreq 60.041Hz, hfreq 47.913kHz
> >         DotClock    76.660000
> >         HTimings    1366 1404 1426 1600
> >         VTimings    768 771 777 798
> >         Flags    "-HSync" "-VSync"
> >     EndMode
> >     # Block type: 2:0 3:f
> >     # Block type: 2:0 3:fe
> >     # Block type: 2:0 3:fe
> > EndSection
> >
> >
> > $ sudo i2cdetect 5
> > WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> > I will probe file /dev/i2c-5.
> > I will probe address range 0x03-0x77.
> > Continue? [Y/n]
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00:          -- -- -- -- -- -- -- -- -- -- -- -- --
> > 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 4f
> > 50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> > 70: -- -- -- -- -- -- -- --
> >
> >
> > $ sudo i2cdump 5 0x4f
> > No size specified (using byte-data access)
> > WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> > I will probe file /dev/i2c-5, address 0x4f, mode byte
> > Continue? [Y/n]
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> > 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> > 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> > 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> > 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> > 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> > 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> > 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> > 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> > 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> > a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> > b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> > c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> > d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> > e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
> > f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
>
> No idea what this is, it might as well be the "chip" which caused the
> problem, or maybe it is completely unrelated.
>
> > $ sudo i2cdump 5 0x50
> > No size specified (using byte-data access)
> > WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
> > I will probe file /dev/i2c-5, address 0x50, mode byte
> > Continue? [Y/n]
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: 00 ff ff ff ff ff ff 00 06 af dc 11 00 00 00 00    ........????....
> > 10: 00 16 01 04 90 16 0d 78 02 bb f5 94 55 54 90 27    .??????x????UT?'
> > 20: 23 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01    #PT...??????????
> > 30: 01 01 01 01 01 01 f2 1d 56 ea 50 00 1e 30 26 16    ????????V?P.?0&?
> > 40: 36 00 de 7d 00 00 00 18 00 00 00 0f 00 00 00 00    6.?}...?...?....
> > 50: 00 00 00 00 00 00 00 00 00 20 00 00 00 fe 00 41    ......... ...?.A
> > 60: 55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe    UO?         ...?
> > 70: 00 42 31 30 31 58 54 4e 30 31 2e 31 20 0a 00 dd    .B101XTN01.1 ?.?
> > 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
> > f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
>
> This is the EEPROM with the EDID monitor information. Should be read
> only. If it was somehow corrupted then X should complain repeatedly
> about it (it does complain every now and then on many systems due to
> occasional I2C bus timeouts, but I would expect it to be much louder if
> the EEPROM is corrupted.)
>
> That being said the above dump does NOT look corrupted to me, at least
> the checksum is correct and the available data looks good to me -
> except for the claim that the display is monochrome and doesn't support
> DPMS.
>
> > dmesg currently dumping this during probe of 0x4f:
> > [  783.847244] i2c i2c-6: sendbytes: NAK bailout.
> > [  783.848321] i2c i2c-6: sendbytes: NAK bailout.
> > [  783.849399] i2c i2c-6: sendbytes: NAK bailout.
> > [  783.850497] i2c i2c-6: sendbytes: NAK bailout.
> > [  783.851666] i2c i2c-6: sendbytes: NAK bailout.
> > [  783.852746] i2c i2c-6: sendbytes: NAK bailout.
> > [  783.853827] i2c i2c-6: sendbytes: NAK bailout.
> > [  783.854908] i2c i2c-6: sendbytes: NAK bailout.
> > [  783.855988] i2c i2c-6: sendbytes: NAK bailout.
> > [  783.857065] i2c i2c-6: sendbytes: NAK bailout.
> > [  783.858150] i2c i2c-6: sendbytes: NAK bailout.
> > [  783.859230] i2c i2c-6: sendbytes: NAK bailout.
> > [  783.860306] i2c i2c-6: sendbytes: NAK bailout.
> > [  783.861383] i2c i2c-6: sendbytes: NAK bailout.
>
> This suggests that the chip in question does not like the format of the
> messages used by the probe / dump. This explains the XX's but is not
> necessarily bad. I've seen a lot of these in the past on various
> systems, without any hardware issue resulting from that.
>
> Note that the messages are for i2c bus 6 while your dumps where on i2c
> bus 5.
>
> One thing which comes to my mind is DCC/CI: the ability to control the
> monitor settings through the OS rather than by pressing physical
> buttons on the screen. Your observations could be the result of
> (uncontrolled) DCC/CI commands having been sent to the screen as part
> of the sensors detection.
>
> Unfortunately I am not aware of any recent Linux tool that can send
> DCC/CI commands. The projects I found are old and look abandoned:
>   http://jaffar.cs.msu.su/oleg/ddcci/
>   http://ddccontrol.sourceforge.net/
> You may still want to give them a try.
>
> AFAIK DCC/CI operates on I2C address 0x37. Can you remember if you did
> see anything respond to that address on one of the graphics chip I2C
> buses during the initial run of sensors-detect?
>
> http://www.boichat.ch/nicolas/ddcci/specs.html is a good read as well
> but unfortunately most commands appear to be vendor specific, plus I
> wouldn't even know what setting needs to be tweaked in your case, as we
> don't know what the settings were before the problem happened.
>
> But it is also possible that your problem has nothing to do with DCC/CI
> and sensors-detect touched a completely different chip which is
> controlling some voltages or clock frequencies and what you are seeing
> is the result of this now incorrect voltage or frequency.
>
> Good luck,
> --
> Jean Delvare
>

--f46d043893bd6c427404e598b1c8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Thank you Jean and Guenter for taking the t=
ime to reply.<br><br></div>Since it was still new, I decided to work with t=
he retailer to replace the device.<br><br></div>I have an suspicion there&#=
39;s a EEPROM in this device that is shipping without write-protection set,=
 and the sensors-detect probe rakes over it at random before eventually eve=
ntually setting the chip into read-only mode. If that&#39;s the case, then =
it&#39;s probably a lost cause. But EEPROM programming is all very much ove=
r my head! I&#39;m happy to not solve the mystery if I don&#39;t have to.<b=
r>

<br></div>Perhaps the thing to do is file a bug with Ubuntu to push out a m=
ore up-to-date version of lm-sensors to their long-term support release.<br=
></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Thu=
, Aug 29, 2013 at 5:02 AM, Jean Delvare <span dir=3D"ltr">&lt;<a href=3D"ma=
ilto:khali@linux-fr.org" target=3D"_blank">khali@linux-fr.org</a>&gt;</span=
> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi Larry,<br>
<div class=3D"im"><br>
On Sat, 24 Aug 2013 19:32:41 -0500, Larry Lade wrote:<br>
&gt; I wanted to report an alarming issue running sensors-detect on my new<=
br>
&gt; (Ubuntu 12.04 out of the box!) laptop.<br>
</div>&gt; (...)<br>
<div class=3D"im">&gt; At some point during one of these scans, there&#39;s=
 a flash and SOMETHING<br>
&gt; happens to the built-in LCD screen. I noticed it&#39;s as though the g=
amma<br>
&gt; was all out of whack, the colors were washed out, and dithering<br>
&gt; becomes notable everywhere. (Bad even for an 18-bit LCD.) Display<br>
&gt; looks fine on an LCD connected by VGA port.<br>
&gt;<br>
&gt; This change survived the re-install of the operating system.<br>
&gt;<br>
&gt; I was getting desperate, thinking I had just zapped something and<br>
&gt; voided the hardware, so I ran sensors-detect again. Probing either of<=
br>
&gt; the two above adapters (they both seem to reference the same bit of<br=
>
&gt; hardware) seemed to toggle something, restoring or corrupting the<br>
&gt; screen quality.<br>
&gt;<br>
&gt; Or at least it did. It seems to have it stuck in &quot;ugly&quot; mode=
 again,<br>
&gt; and nothing on the display toggles any more when I run sensors-detect<=
br>
&gt; any more. Is anyone able to help?<br>
<br>
</div>I&#39;m very sorry about this. As Guenter said, we have changed the c=
ode<br>
meanwhile to skip graphics adapters by default, and I can only urge<br>
Linux distributions to include that change.<br>
<br>
You may try to ask the hardware vendor for help. After all they did<br>
ship the software which broke the laptop, right? Even though they did<br>
not write it. I am willing to help but the problem is that it will be<br>
very difficult, if not impossible, to do so without intimate knowledge<br>
of the hardware, which only the vendor can provide. I would be very<br>
happy to cooperate with Asus on that matter if they want to. Only Asus<br>
knows exactly which I2C chips are connected to the graphics chip, at<br>
what address, and if any of them could be responsible for what you<br>
observe.<br>
<br>
Meanwhile, the first thing to try here is:<br>
* Shut down the machine.<br>
* Remove the battery.<br>
* Unplug the AC adapter.<br>
* Let the laptop rest that way for a moment, at least 10 minutes.<br>
* Plug everything back and start the machine.<br>
<br>
This has restored systems for me and others in the past, I can only<br>
hope it helps for you as well.<br>
<br>
If it does not, then if the laptop is new, I think I would just play<br>
the support/warranty card.<br>
<br>
You can also try changing the gamma setting with xrandr.<br>
<div><div class=3D"h5"><br>
&gt; The LCD seems to be an AUO B101XTN01 (as reported by the EDID)<br>
&gt; <a href=3D"http://www.panelook.com/B101XTN01.0_AUO_10.1_LCM_parameter_=
19387.html" target=3D"_blank">http://www.panelook.com/B101XTN01.0_AUO_10.1_=
LCM_parameter_19387.html</a><br>
&gt;<br>
&gt; lm-sensors 1:3.3.1-2ubuntu1<br>
&gt;<br>
&gt; linux 3.2.0-52-generic #78-Ubuntu SMP x86_64<br>
&gt;<br>
&gt;<br>
&gt; $ sudo get-edid | parse-edid:<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 # EDID version 1 revision 4<br>
&gt; Section &quot;Monitor&quot;<br>
&gt; =C2=A0 =C2=A0 # Block type: 2:0 3:f<br>
&gt; =C2=A0 =C2=A0 # Block type: 2:0 3:fe<br>
&gt; =C2=A0 =C2=A0 # Block type: 2:0 3:fe<br>
&gt; =C2=A0 =C2=A0 Identifier &quot;AUO:dc11&quot;<br>
&gt; =C2=A0 =C2=A0 VendorName &quot;AUO&quot;<br>
&gt; =C2=A0 =C2=A0 ModelName &quot;AUO:dc11&quot;<br>
&gt; =C2=A0 =C2=A0 # Block type: 2:0 3:f<br>
&gt; =C2=A0 =C2=A0 # Block type: 2:0 3:fe<br>
&gt; =C2=A0 =C2=A0 # Block type: 2:0 3:fe<br>
&gt; =C2=A0 =C2=A0 # DPMS capabilities: Active off:no =C2=A0Suspend:no =C2=
=A0Standby:no<br>
&gt;<br>
&gt; =C2=A0 =C2=A0 Mode =C2=A0 =C2=A0 &quot;1366x768&quot; =C2=A0 =C2=A0# v=
freq 60.041Hz, hfreq 47.913kHz<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 DotClock =C2=A0 =C2=A076.660000<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 HTimings =C2=A0 =C2=A01366 1404 1426 1600<=
br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 VTimings =C2=A0 =C2=A0768 771 777 798<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 Flags =C2=A0 =C2=A0&quot;-HSync&quot; &quo=
t;-VSync&quot;<br>
&gt; =C2=A0 =C2=A0 EndMode<br>
&gt; =C2=A0 =C2=A0 # Block type: 2:0 3:f<br>
&gt; =C2=A0 =C2=A0 # Block type: 2:0 3:fe<br>
&gt; =C2=A0 =C2=A0 # Block type: 2:0 3:fe<br>
&gt; EndSection<br>
&gt;<br>
&gt;<br>
&gt; $ sudo i2cdetect 5<br>
&gt; WARNING! This program can confuse your I2C bus, cause data loss and wo=
rse!<br>
&gt; I will probe file /dev/i2c-5.<br>
&gt; I will probe address range 0x03-0x77.<br>
&gt; Continue? [Y/n]<br>
&gt; =C2=A0 =C2=A0 =C2=A00 =C2=A01 =C2=A02 =C2=A03 =C2=A04 =C2=A05 =C2=A06 =
=C2=A07 =C2=A08 =C2=A09 =C2=A0a =C2=A0b =C2=A0c =C2=A0d =C2=A0e =C2=A0f<br>
&gt; 00: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-- -- -- -- -- -- -- -- -- -- --=
 -- --<br>
&gt; 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --<br>
&gt; 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --<br>
&gt; 30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --<br>
&gt; 40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 4f<br>
&gt; 50: 50 -- -- -- -- -- -- -- -- -- -- -- -- -- -- --<br>
&gt; 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --<br>
&gt; 70: -- -- -- -- -- -- -- --<br>
&gt;<br>
&gt;<br>
&gt; $ sudo i2cdump 5 0x4f<br>
&gt; No size specified (using byte-data access)<br>
&gt; WARNING! This program can confuse your I2C bus, cause data loss and wo=
rse!<br>
&gt; I will probe file /dev/i2c-5, address 0x4f, mode byte<br>
&gt; Continue? [Y/n]<br>
&gt; =C2=A0 =C2=A0 =C2=A00 =C2=A01 =C2=A02 =C2=A03 =C2=A04 =C2=A05 =C2=A06 =
=C2=A07 =C2=A08 =C2=A09 =C2=A0a =C2=A0b =C2=A0c =C2=A0d =C2=A0e =C2=A0f =C2=
=A0 =C2=A00123456789abcdef<br>
&gt; 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
&gt; 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
&gt; 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
&gt; 30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
&gt; 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
&gt; 50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
&gt; 60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
&gt; 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
&gt; 80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
&gt; 90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
&gt; a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
&gt; b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
&gt; c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
&gt; d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
&gt; e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
&gt; f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX =C2=A0 =C2=A0XXXXX=
XXXXXXXXXXX<br>
<br>
</div></div>No idea what this is, it might as well be the &quot;chip&quot; =
which caused the<br>
problem, or maybe it is completely unrelated.<br>
<div class=3D"im"><br>
&gt; $ sudo i2cdump 5 0x50<br>
&gt; No size specified (using byte-data access)<br>
&gt; WARNING! This program can confuse your I2C bus, cause data loss and wo=
rse!<br>
&gt; I will probe file /dev/i2c-5, address 0x50, mode byte<br>
&gt; Continue? [Y/n]<br>
&gt; =C2=A0 =C2=A0 =C2=A00 =C2=A01 =C2=A02 =C2=A03 =C2=A04 =C2=A05 =C2=A06 =
=C2=A07 =C2=A08 =C2=A09 =C2=A0a =C2=A0b =C2=A0c =C2=A0d =C2=A0e =C2=A0f =C2=
=A0 =C2=A00123456789abcdef<br>
&gt; 00: 00 ff ff ff ff ff ff 00 06 af dc 11 00 00 00 00 =C2=A0 =C2=A0.....=
...????....<br>
&gt; 10: 00 16 01 04 90 16 0d 78 02 bb f5 94 55 54 90 27 =C2=A0 =C2=A0.????=
??x????UT?&#39;<br>
&gt; 20: 23 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01 =C2=A0 =C2=A0#PT..=
.??????????<br>
&gt; 30: 01 01 01 01 01 01 f2 1d 56 ea 50 00 1e 30 26 16 =C2=A0 =C2=A0?????=
???V?P.?0&amp;?<br>
&gt; 40: 36 00 de 7d 00 00 00 18 00 00 00 0f 00 00 00 00 =C2=A0 =C2=A06.?}.=
..?...?....<br>
&gt; 50: 00 00 00 00 00 00 00 00 00 20 00 00 00 fe 00 41 =C2=A0 =C2=A0.....=
.... ...?.A<br>
&gt; 60: 55 4f 0a 20 20 20 20 20 20 20 20 20 00 00 00 fe =C2=A0 =C2=A0UO? =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ...?<br>
&gt; 70: 00 42 31 30 31 58 54 4e 30 31 2e 31 20 0a 00 dd =C2=A0 =C2=A0.B101=
XTN01.1 ?.?<br>
&gt; 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =C2=A0 =C2=A0.....=
...........<br>
&gt; 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =C2=A0 =C2=A0.....=
...........<br>
&gt; a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =C2=A0 =C2=A0.....=
...........<br>
&gt; b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =C2=A0 =C2=A0.....=
...........<br>
&gt; c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =C2=A0 =C2=A0.....=
...........<br>
&gt; d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =C2=A0 =C2=A0.....=
...........<br>
&gt; e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =C2=A0 =C2=A0.....=
...........<br>
&gt; f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff =C2=A0 =C2=A0.....=
...........<br>
<br>
</div>This is the EEPROM with the EDID monitor information. Should be read<=
br>
only. If it was somehow corrupted then X should complain repeatedly<br>
about it (it does complain every now and then on many systems due to<br>
occasional I2C bus timeouts, but I would expect it to be much louder if<br>
the EEPROM is corrupted.)<br>
<br>
That being said the above dump does NOT look corrupted to me, at least<br>
the checksum is correct and the available data looks good to me -<br>
except for the claim that the display is monochrome and doesn&#39;t support=
<br>
DPMS.<br>
<div class=3D"im"><br>
&gt; dmesg currently dumping this during probe of 0x4f:<br>
&gt; [ =C2=A0783.847244] i2c i2c-6: sendbytes: NAK bailout.<br>
&gt; [ =C2=A0783.848321] i2c i2c-6: sendbytes: NAK bailout.<br>
&gt; [ =C2=A0783.849399] i2c i2c-6: sendbytes: NAK bailout.<br>
&gt; [ =C2=A0783.850497] i2c i2c-6: sendbytes: NAK bailout.<br>
&gt; [ =C2=A0783.851666] i2c i2c-6: sendbytes: NAK bailout.<br>
&gt; [ =C2=A0783.852746] i2c i2c-6: sendbytes: NAK bailout.<br>
&gt; [ =C2=A0783.853827] i2c i2c-6: sendbytes: NAK bailout.<br>
&gt; [ =C2=A0783.854908] i2c i2c-6: sendbytes: NAK bailout.<br>
&gt; [ =C2=A0783.855988] i2c i2c-6: sendbytes: NAK bailout.<br>
&gt; [ =C2=A0783.857065] i2c i2c-6: sendbytes: NAK bailout.<br>
&gt; [ =C2=A0783.858150] i2c i2c-6: sendbytes: NAK bailout.<br>
&gt; [ =C2=A0783.859230] i2c i2c-6: sendbytes: NAK bailout.<br>
&gt; [ =C2=A0783.860306] i2c i2c-6: sendbytes: NAK bailout.<br>
&gt; [ =C2=A0783.861383] i2c i2c-6: sendbytes: NAK bailout.<br>
<br>
</div>This suggests that the chip in question does not like the format of t=
he<br>
messages used by the probe / dump. This explains the XX&#39;s but is not<br=
>
necessarily bad. I&#39;ve seen a lot of these in the past on various<br>
systems, without any hardware issue resulting from that.<br>
<br>
Note that the messages are for i2c bus 6 while your dumps where on i2c<br>
bus 5.<br>
<br>
One thing which comes to my mind is DCC/CI: the ability to control the<br>
monitor settings through the OS rather than by pressing physical<br>
buttons on the screen. Your observations could be the result of<br>
(uncontrolled) DCC/CI commands having been sent to the screen as part<br>
of the sensors detection.<br>
<br>
Unfortunately I am not aware of any recent Linux tool that can send<br>
DCC/CI commands. The projects I found are old and look abandoned:<br>
=C2=A0 <a href=3D"http://jaffar.cs.msu.su/oleg/ddcci/" target=3D"_blank">ht=
tp://jaffar.cs.msu.su/oleg/ddcci/</a><br>
=C2=A0 <a href=3D"http://ddccontrol.sourceforge.net/" target=3D"_blank">htt=
p://ddccontrol.sourceforge.net/</a><br>
You may still want to give them a try.<br>
<br>
AFAIK DCC/CI operates on I2C address 0x37. Can you remember if you did<br>
see anything respond to that address on one of the graphics chip I2C<br>
buses during the initial run of sensors-detect?<br>
<br>
<a href=3D"http://www.boichat.ch/nicolas/ddcci/specs.html" target=3D"_blank=
">http://www.boichat.ch/nicolas/ddcci/specs.html</a> is a good read as well=
<br>
but unfortunately most commands appear to be vendor specific, plus I<br>
wouldn&#39;t even know what setting needs to be tweaked in your case, as we=
<br>
don&#39;t know what the settings were before the problem happened.<br>
<br>
But it is also possible that your problem has nothing to do with DCC/CI<br>
and sensors-detect touched a completely different chip which is<br>
controlling some voltages or clock frequencies and what you are seeing<br>
is the result of this now incorrect voltage or frequency.<br>
<br>
Good luck,<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Jean Delvare<br>
</font></span></blockquote></div><br></div>

--f46d043893bd6c427404e598b1c8--


--===============6884061641206010697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6884061641206010697==--
