From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 15 Oct 2011 07:51:18 +0000
Subject: Re: [lm-sensors] smbus-arp module
Message-Id: <20111015095118.0b54dc46@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111014230322.39baf9f0@endymion.delvare>
In-Reply-To: <20111014230322.39baf9f0@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Please don't top-post.

On Fri, 14 Oct 2011 17:25:06 -0700 (PDT), shubhada pugaonkar wrote:
> It would be great if I=A0could use that code for testing.=20
> =A0
> One=A0question:
> I=A0dont see any of the drivers having ARP support,=A0=A0does that=A0mean=
 all the smbus controllers have ARP implemented in HW?=20
> I looked at intel 82801 smbus controller (thats what I have)=A0datasheet =
but the ARP support is nowhere to be seen. Does anyone=20
> know any smbus host controllers chip (or specific server) with HW smbus A=
RP?

I did not dig the matter too much yet but my understanding is that bus
controllers (and thus their drivers) don't have to care about ARP at
all. It is implemented in hardware on the slave side but in software on
the host side, as there is nothing the bus controller can do with the
information anyway.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
