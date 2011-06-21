From: Vincent Pelletier <plr.vincent@gmail.com>
Date: Tue, 21 Jun 2011 19:38:46 +0000
Subject: Re: [lm-sensors] IT8721F on Asus M5A88-V EVO
Message-Id: <201106212138.47083.plr.vincent@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <201106192314.40074.plr.vincent@gmail.com>
In-Reply-To: <201106192314.40074.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Le mardi 21 juin 2011 09:16:31, Jean Delvare a =E9crit :
> Your copy-and-paste method added a lot of trailing white space, making
> your post needlessly large and quoting difficult. Please clean up your
> post before sending next time.

Sure. Sorry for not noticing.

> This is indeed the driver you want to use on every recent Asus desktop
> board.

it87 driver has the advantage of exposing pwm controls in sysfs.

> It no longer matters, but the first 5 voltage labels are wrong. Not
> sure where you got them from. in2 is obviously Vcore and in3 matches
> +3.3V.

I noticed this too. Maybe this comes from a config I was trying to write fo=
r=20
this chip - I thought I moved it away & reconfigured sensors before posting.

> Looks wrong indeed, as it is set to 75=B0C, not 95=B0C. Is there a CPU
> temperature shutdown level that you can set as well? If so, to what
> value did you set it?

Actually, the "NorthBridge overheat protection" option is a simple=20
neable/disable switch on a different screen than sensors output & fan=20
settings.
I could not find any way to configure any temperature limit on CPU.

> What surprises me the most is that the it87 driver reported completely
> different limits, which means that these are software limits... The
> BIOS never wrote them to the chip (unless you screwed them up yourself
> with a libsensors configuration file?)

I don't think so: I could not find any settings for it8721 in either=20
/etc/sensors3.conf nor /etc/sensors.d/* . All I configured on this chip wer=
e=20
names & fan speed limit, and fan limits were not applied anymore in dumps I=
=20
pasted.

> I wonder how such software
> limits can be enforced. Maybe this only works on Windows with Asus
> proprietary software loaded. Or maybe the BIOS is polling the device
> periodically at run-time. Ugly in both cases.

No idea. So far, this motherboard didn't see windows.

--=20
Vincent Pelletier

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
