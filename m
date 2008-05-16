From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 16 May 2008 14:26:34 +0000
Subject: Re: [lm-sensors] Bad value with w83627thf
Message-Id: <20080516162634.26207258@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <6101e8c40805160559i4eb94ba7y7cbfea9c3f528821@mail.gmail.com>
	<20080516152712.629606bf@hyperion.delvare>
	<6101e8c40805160645x5982d5ads61a422f5600f7507@mail.gmail.com>
In-Reply-To: <6101e8c40805160645x5982d5ads61a422f5600f7507@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Oliver Pinter <oliver.pntr@gmail.com>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org

Hi Oliver,

On Fri, 16 May 2008 15:45:01 +0200, Oliver Pinter wrote:
> the battery is CR2032, and it is 3V, im older kernel alway reported
> bad value 0,02V or 2,4V (i think it is a possible value), after i
> inserted new battery, show 2,4V.
> from the 2.6.26-rcX kernel showed the 3+ V. when i reboot to older
> kernel, the this state remained, but when turned off the pc, then not.

This can be easily explained. In kernel 2.6.25, we fixed a bug where
the w83627hf driver assumed that the BIOS had enabled VBat monitoring
[1]. With previous kernels, the VBat value would be wrong if the BIOS
did not actually enable VBat monitoring. Since kernel 2.6.25, the
w83627hf driver doesn't assume anything from the BIOS as far as VBat is
concerned, and enables monitoring if needed.

When you reboot your machine, the W83627THF device is not reset, so the
configuration steps done by the w83627hf driver of kernel 2.6.25+
remain. However, if you stop the machine then start it again, the
configuration is lost.

[1] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commit;h=EF878b11ba245d14b7db7816217a825d6a894182

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
