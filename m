From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Sun, 15 Apr 2007 22:03:09 +0000
Subject: Re: [lm-sensors] w83627dhg msi 975x problems
Message-Id: <4dfa50520704151503x11790015t6f5ae4f3a28162eb@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070415185853.GA11766@xeron.cc>
In-Reply-To: <20070415185853.GA11766@xeron.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jordan,

On 4/15/07, Jordan <xero@xeron.cc> wrote:
> I have a MSI 975x Platinum, which uses the w83627dhg. This one here:
>
> http://www.msicomputer.com/product/p_spec.asp?model=975X_Platinum_(Limite=
d_Edition)&class=3Dmb
>
> I've applied the DHG patch to my kernel (2.6.20) but I'm currently having=
 some
> issues controlling the fan speeds. I've tried pwmconfig as well as manual=
ly
> echoing some values to pwm1-4 and pwm1-4_enable. It does correctly control
> my case fans, but it doesn't seem to have any effect over my CPU fan. I am
> using one of the new 4 pin cpu fans.
>
> My bios has a "smart fan" option for the CPU fan which does work correctl=
y,
> although this option is not very configurable in the BIOS, it's only an
> on/off switch with no way to control the temperature that it raises the f=
an
> speed at. I found an actual picture of the BIOS screen for reference:
> http://www.hardocp.com/images/articles/1168231380Rzv7IS7G0U_2_15_l.gif
>
> I was hoping to be able to control the CPU fan speed through lm_sensors i=
nstead.
> Disabling the smart fan in the bios leaves the fan running at full speed,=
 but
> this doesn't seem to make a difference, pwm1-4 continue to have no effect=
 on
> the fan speed. Any ideas?

Unfortunately, it looks like your CPU fan really is just an on/off
switch. It may not be controllable by the w83627dhg chip. As you said,
you have manipulated pwm1-4 to no effect. If you can find a schematic
for your motherboard, I can tell you for sure. (Jan van Tiggelen, here
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019282.html,
seems to have access to some of them.) But the 4-pin fan design does
allow the fan to be controlled in this binary fashion, either on (full
speed) or off (low speed, or completely off) -- so I don't think there
really is any chance of actually controlling the speed of that fan out
port.

If you connect the CPU fan to another fan out port on the motherboard
you could control its speed manually, but automatic fan speed control
would be broken. And it sounds like you are using the other ports for
case fans.

Thanks, by the way, for finding the links to the manufacturer
information and the BIOS screen.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
