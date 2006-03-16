From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 16 Mar 2006 09:13:47 +0000
Subject: [lm-sensors] DFI Lan Party SLI-DR Expert shuts off when it87 is
Message-Id: <QtmlAR8K.1142500427.0326340.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <a33b5feb0603152333t5f7dcc28i24b235e39d595706@mail.gmail.com>
In-Reply-To: <a33b5feb0603152333t5f7dcc28i24b235e39d595706@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi Brian,

On 2006-03-16, Brian Hayward wrote:
> First off, when running sensors-detect, if I select "yes" for the next
> question, the computer turns off.
> Next adapter: SMBus nForce2 adapter at 1c40
> Do you want to scan it? (YES/no/selectively):
>
> The computer just powers down, as if I turned the switch off.  No warning
> or anything.
>
> If I select NO to the 1c40 nForc2 option and then YES to all others - the
> computer does not power off until I modprobe it87.
>
> I've tried:
>   modprobe it87
>   modprobe it87 force_it87=9191,0x290
> Same problem either way, immediate shutdown.

Try modprobe it87 ignore=3D-1,0x2e.

> If I load all suggested modules _except_ it87, it does not shut down and
> it also does not show any CPU/Fanspeed redouts when I type "sensors".
>
> Do you have any suggestions?

This was reported already, on the same board. There is a mysterious chip
at address 0x2e on the SMBus which powers off the board when probed.

See: http://bugzilla.kernel.org/show_bug.cgi?idX89

A workaround was merged in 2.6.16-rc3 and 2.6.15.5. We yet have to come
up with a workaround for sensors-detect. The solution would be to detect
this motherboard (e.g. using dmidecode) and skip probing the faulty
address automatically.

--
Jean Delvare

