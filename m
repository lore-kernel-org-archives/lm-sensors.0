From: Kent Larsson <kent.larsson@gmail.com>
Date: Wed, 25 Sep 2013 14:59:04 +0000
Subject: [lm-sensors] Problems with SYSTIN in nct6776-isa-0290
Message-Id: <CALmZR2Nd_S3tT9LM7bqwZi0PQgL4pSYPpHX3fCskXuWD587jGQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

I use sensors version 3.3.2 with libsensors version 3.3.2. I have some
sensors controlled by nct6776-isa-0290 which produce ALARM even though they
should not. For the most part I can get it to work by setting _min and _max
or ignoring the sensor. But I have one sensor I have been unable to "fix".

    sensors
    ...
    nct6776-isa-0290
    ...
    SYSTIN:         +31.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  AL=
ARM
sensor =3D thermistor
    ...

I have this /etc/sensors.d/custom
    chip "nct6776-isa-0290"
            ignore fan3
            ignore fan4
            ignore fan5
            ignore intrusion0
            ignore intrusion1
            ignore in5
            ignore SYSTIN
            label fan1 "Chassis Fan 1"
            label fan2 "CPU Fan"
            set fan1_min 500
            set fan2_min 300
            set in1_min 0.612
            set in1_max 1.428
            set in4_min 0.606
            set in4_max 1.414

I have tried

            set SYSTIN_high 80.0
            set SYSTIN_hyst 75.0

But then sudo sensors -s gives me

    Error: File /etc/sensors.d/custom, line 17: Unknown feature name
    Error: File /etc/sensors.d/custom, line 18: Unknown feature name
    nct6776-isa-0290: No such subfeature known

When that didn't work I tried

            ignore SYSTIN

In that case sudo sensors -s does not complain, but the SYSTIN line still
shows up.

Am I doing something wrong?

Best regards, Kent
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
