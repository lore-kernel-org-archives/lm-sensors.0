From: Luca Tettamanti <kronos.it@gmail.com>
Date: Tue, 27 Jul 2010 11:03:09 +0000
Subject: Re: [lm-sensors] asus_atk0110 on a p6td deluxe
Message-Id: <AANLkTikMLZkogdu7oXvpg7W7aUUkggAbat89wrm4BBi0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <724895.29279.qm@web28512.mail.ukl.yahoo.com>
In-Reply-To: <724895.29279.qm@web28512.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Jul 26, 2010 at 11:18 PM, Marco <jjletho67-ml@yahoo.it> wrote:
> i'm attaching the DSDT file. If i well understood =C2=A0you are able to l=
ook inside
> it...

Ok, as expected the hwmon section does not contain additional entries.

However, in GIT3 I see at least the following entries that are
connected to the hwmon chip:

"BCLK Frequency"
"CPU Voltage" (another one, but for a different register)
"CPU Ratio"
"QPI/DRAM Core Volt"
"DRAM Bus Voltage"

It will take a bit of reverse engineering to get GIT3 to work; are you
able to compile a patched version of the driver and do some tests?

Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
