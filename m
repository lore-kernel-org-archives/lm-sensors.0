From: "Oliver Pinter" <oliver.pntr@gmail.com>
Date: Fri, 16 May 2008 14:34:23 +0000
Subject: Re: [lm-sensors] Bad value with w83627thf
Message-Id: <6101e8c40805160734t12d5fbe8ud63fe2ab1681cd13@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6101e8c40805160559i4eb94ba7y7cbfea9c3f528821@mail.gmail.com>
	 <20080516152712.629606bf@hyperion.delvare>
	 <6101e8c40805160645x5982d5ads61a422f5600f7507@mail.gmail.com>
	 <20080516162634.26207258@hyperion.delvare>
In-Reply-To: <20080516162634.26207258@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali@linux-fr.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org

Hi Jean!

[snip]

> When you reboot your machine, the W83627THF device is not reset, so the
> configuration steps done by the w83627hf driver of kernel 2.6.25+
> remain. However, if you stop the machine then start it again, the
> configuration is lost.

yean I thinked this, but dont know, what is this base (the git commit expla=
ined)
>
> [1]
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmit;h=EF878b11ba245d14b7db7816217a825d6a894182
>
> --
> Jean Delvare
>

thanks the help, and then i backported this commit to 2.6.22.y and
changed the limit values in sensors.conf

--=20
Thanks,
Oliver

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
