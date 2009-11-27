From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 27 Nov 2009 08:59:17 +0000
Subject: Re: [lm-sensors] /sys/class/hwmon/ numbering
Message-Id: <20091127095917.509beb5f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <18910e4d0911260014m5fe3445cmf423b25e6a68bf50@mail.gmail.com>
In-Reply-To: <18910e4d0911260014m5fe3445cmf423b25e6a68bf50@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Fri, 27 Nov 2009 09:24:56 +0100, Charles Pr=E9vot wrote:
> Is asus_atk0110 supposed to managed the "Cool'n Quiet" feature ?

No, AFAIK Cool'n Quiet is a CPU-related feature handled by the
powernow-k8 driver. asus_atk0110 is only exporting the hardware
monitoring values implemented by Asus in their BIOS. At this time
asus_atk0110 is a read-only driver, it doesn't make any change to your
system.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
