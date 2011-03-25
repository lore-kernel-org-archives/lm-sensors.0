From: Piotr Maksymiuk <p.maksymiuk@wsisiz.edu.pl>
Date: Fri, 25 Mar 2011 10:49:14 +0000
Subject: Re: [lm-sensors] [config] sensors.d config for Zotac ZBox HD-ID11
Message-Id: <1301050154.31613.2.camel@pcitpes052.cern.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <21E792C5-FD4F-487B-B8B8-E35B18F218DF@wsisiz.edu.pl>
In-Reply-To: <21E792C5-FD4F-487B-B8B8-E35B18F218DF@wsisiz.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Actually, turns out i was wrong about one sensor (temp1 is not GPU but
the M/B chipset, unfortunately the i2c supplied with nvidia drivers do
not report any thermal information). Could you update the entry with
this?

##/etc/sensors.d/zbox-hd-id-11

chip "w83667hg-isa-0a10"

   # Voltages

   label  in0 "Vcore"
   label  in1 "RAM"
   label  in2 "AVCC"
   label  in3 "+3.3V"
   label  in4 "Chipset"
   label  in5 "+1.5V"
   label  in6 "3VSB"

   set in0_min  1.1 * 0.90
   set in0_max  1.1 * 1.10
   set in1_min  1.9 * 0.90
   set in1_max  1.9 * 1.10
   set in2_min  3.3 * 0.90
   set in2_max  3.3 * 1.10
   set in3_min  3.3 * 0.90
   set in3_max  3.3 * 1.10
   set in4_min  1.1 * 0.90
   set in4_max  1.1 * 1.10
   set in5_min  1.5 * 0.90
   set in5_max  1.5 * 1.10
     =20
   # Fans

   # Only fan2 is used in this barebone.
   ignore fan1
   label  fan2 "Case Fan"
   ignore fan3
   ignore fan4
   ignore fan5

   set fan2_min  800

   # Temperatures

   #unfortunately i'm not sure if temp3 is ram
   label  temp1 "M/B Temp"
   label  temp2 "CPU Temp"
   label  temp3 "RAM Temp"

   #this always returns a 0 reading
   ignore cpu0_vid

   set temp1_max       50
   set temp1_max_hyst  40

   set temp2_max       75
   set temp2_max_hyst  60

   set temp3_max       35
   set temp3_max_hyst  30

Dnia 2011-03-25, pi=C4=85 o godzinie 11:39 +0100, Jean Delvare pisze:
> Hi Piotr,
>=20
> On Wed, 23 Mar 2011 19:20:12 +0100, Piotr Maksymiuk wrote:
> > Just spend a couple of hours finetuning this, and i thought i'd be nice=
 to share
> >=20
> > ##/etc/sensors.d/zbox-hd-id-11
>=20
> Added to the wiki, thanks for your contribution!
>=20



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
