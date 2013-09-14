From: singumal <qdmd-pu1o@dea.spamcon.org>
Date: Sat, 14 Sep 2013 01:42:26 +0000
Subject: [lm-sensors] ASRock IMB-170 configuration help
Message-Id: <jaf739to4p5c3erfh5rc33qk1mg2iopfoo@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Now that I can read sensors for this ASRock IMB-170 board (see list thread =
"Re: Cannot
compile w83627ehf standalone driver"), I need to configure it.  I don't see=
 any info
poking around the lm-sensors.org site or in a web search.  Here is the "sen=
sors" output
(less the coretemp info) with the 3.3.4 sensors.conf.default as /etc/sensor=
s3.conf:

w83627uhg-isa-0290
Adapter: ISA adapter
in0:           +0.86 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:           +1.83 V  (min =3D  +0.61 V, max =3D  +1.02 V)  ALARM
AVCC:          +5.12 V  (min =3D  +4.49 V, max =3D  +5.49 V)
+5V:           +5.14 V  (min =3D  +4.49 V, max =3D  +5.51 V)
in4:           +1.71 V  (min =3D  +0.80 V, max =3D  +0.62 V)  ALARM
in5:           +1.70 V  (min =3D  +1.80 V, max =3D  +1.64 V)  ALARM
5VSB:          +5.12 V  (min =3D  +4.49 V, max =3D  +5.49 V)
Vbat:          +3.37 V  (min =3D  +2.69 V, max =3D  +3.64 V)
fan1:            0 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
fan2:         6026 RPM  (min =3D 21093 RPM, div =3D 16)  ALARM
SYSTIN:        +42.0=B0C  (high =3D  +1.0=B0C, hyst =3D -76.0=B0C)  ALARM  =
sensor =3D thermistor
PECI Agent 1:  +26.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D Intel PECI
intrusion0:   ALARM



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
