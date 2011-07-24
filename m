From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jul 2011 06:42:53 +0000
Subject: Re: [lm-sensors] want memory temperature(i5k_amb),
Message-Id: <20110724084253.72cca9af@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOfki7BChsVD09-EKKKG+tkmjAysXqQTO98XDZqxjmdRPh=sag@mail.gmail.com>
In-Reply-To: <CAOfki7BChsVD09-EKKKG+tkmjAysXqQTO98XDZqxjmdRPh=sag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Adding the driver author in Cc.

On Sat, 23 Jul 2011 23:57:27 -0500, Suyu Zhang wrote:
> my chipset is intel 5000 and I got error info from dmesg=EF=BC=9A
> i5k_amb: probe of i5k_amb.0 failed with error -16

Please provide the outputs of:
* cat /proc/iomem
* lspci -d 8086:25F0 -v -xxx

The i5k_amb driver could certainly be made a little bit more verbose on
errors for easier diagnostics.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
