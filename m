From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Tue, 17 Apr 2007 15:57:23 +0000
Subject: Re: [lm-sensors] w83627dhg msi 975x problems
Message-Id: <4dfa50520704170857n3184ff97jd2e19f6c5413fd0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070415185853.GA11766@xeron.cc>
In-Reply-To: <20070415185853.GA11766@xeron.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean, Jordan,

On 4/17/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi David, Jordan,
>
> On Sun, 15 Apr 2007 16:03:09 -0600, David Hubbard wrote:
> > Hi Jordan,
> >
> > On 4/15/07, Jordan <xero@xeron.cc> wrote:
> > > I have a MSI 975x Platinum, which uses the w83627dhg. This one here:
> > >
> > > http://www.msicomputer.com/product/p_spec.asp?model=975X_Platinum_(Li=
mited_Edition)&class=3Dmb
> > >
> > > I've applied the DHG patch to my kernel (2.6.20) but I'm currently ha=
ving some
> > > issues controlling the fan speeds. I've tried pwmconfig as well as ma=
nually
> > > echoing some values to pwm1-4 and pwm1-4_enable. It does correctly co=
ntrol
> > > my case fans, but it doesn't seem to have any effect over my CPU fan.=
 I am
> > > using one of the new 4 pin cpu fans.
> > >
> > > My bios has a "smart fan" option for the CPU fan which does work corr=
ectly,
> > > although this option is not very configurable in the BIOS, it's only =
an
> > > on/off switch with no way to control the temperature that it raises t=
he fan
> > > speed at. I found an actual picture of the BIOS screen for reference:
> > > http://www.hardocp.com/images/articles/1168231380Rzv7IS7G0U_2_15_l.gif
> > >
> > > I was hoping to be able to control the CPU fan speed through lm_senso=
rs instead.
> > > Disabling the smart fan in the bios leaves the fan running at full sp=
eed, but
> > > this doesn't seem to make a difference, pwm1-4 continue to have no ef=
fect on
> > > the fan speed. Any ideas?
> >
> > Unfortunately, it looks like your CPU fan really is just an on/off
> > switch. It may not be controllable by the w83627dhg chip. As you said,
> > you have manipulated pwm1-4 to no effect. If you can find a schematic
> > for your motherboard, I can tell you for sure. (Jan van Tiggelen, here
> > http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019282.html,
> > seems to have access to some of them.) But the 4-pin fan design does
> > allow the fan to be controlled in this binary fashion, either on (full
> > speed) or off (low speed, or completely off) -- so I don't think there
> > really is any chance of actually controlling the speed of that fan out
> > port.
>
> I don't think that Jordan's CPU fan goes off. My understanding is that
> what Jordan qualifies as "on/off" is the BIOS option (no way to set
> temperature limits), not the fan behavior when the option is enabled.

Okay, I see what you're saying. This sounds good.

> I don't understand why the manual mode doesn't work either, but the
> following things could probably be tried:
>
> * Jordan, you say you tried manual mode when the option was disabled in
> your BIOS. Can you try again when the option is enabled? If the BIOS
> does extra initialization when the option is on, it might make a
> difference.
>
> * You could try to dump the registers of the W83627DHG chip with the
> BIOS option off, and then again with the option on, and see if there
> are relevant differences. Make sure you do NOT let the w83627ehf driver
> load, though, as it could overwrite a few settings. Assuming that your
> chip is at the standard address (0x295) you can dump its contents with:
>
> isadump 0x295 0x295
>
> If it lives at a difference address, adjust the command.
>
> * You could try leaving the option enabled in the BIOS, so the fan is
> in automatic mode, then check the value of all pwmN_enable files. If
> one has value >=3D 2, that should be the PWM output controlling your CPU
> fan. Then you can check the value of pwmN_target, and maybe change it
> to adjust the behavior.
>
> I seem to remember that the W83627DHG supports more fan control modes
> than the w83627ehf driver handles.

The 627dhg is actually very similar to the 627ehf. I believe they both
support SmartFan 3. However, the 627dhg can work with the ICH7
southbridge using PECI, so there may be additional possiblities that
way.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
