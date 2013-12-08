From: Felipe Almeida Lessa <felipe.lessa@gmail.com>
Date: Sun, 08 Dec 2013 23:54:34 +0000
Subject: [lm-sensors] Configuration for motherboard Asus M5A97 PRO
Message-Id: <CANd=OGHaRax2kRYepnUrLX8KN1VwmLxkse_ObbOYOyQhTUc5cQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hey!

I've tried to adjust the values to my motherboard.  The result is
pasted below.  I hope it can make it to the wiki :).

Cheers!

PS: I'm not subscribed to the mailing list.

# Asus M5A97 PRO
# http://blog.felipe.lessa.nom.br/?p=93
chip "k10temp-pci-00c3"
     label temp1 "CPU Temp (rel)"

chip "it8721-*"
     label  in0 "+12V"
     label  in1 "+5V"
     label  in2 "Vcore"
     ignore in4
     ignore in5
     ignore in6

     compute in0  @ * (515/120), @ / (515/120)
     compute in1  @ * (215/120), @ / (215/120)

     ignore temp3
     label temp1 "CPU Temp"
     label temp2 "M/B Temp"

     label fan1 "CPU Fan"
     label fan2 "Chassis Fan"
     label fan3 "Power Fan"

     ignore intrusion0

--=20
Felipe.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
