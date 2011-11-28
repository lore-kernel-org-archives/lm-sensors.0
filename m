From: "Gerhart, Bjoern" <bjoern.gerhart@wincor-nixdorf.com>
Date: Mon, 28 Nov 2011 16:48:12 +0000
Subject: [lm-sensors] [f75387] modifying f75375s module
Message-Id: <EA28F4E582D7F04DA4E25034DF5AA0FD0BB9DFE5@DEEXVS21.wincor-nixdorf.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Dear list,

at the moment I modify the existing f75375s kernel module for supporting th=
e current Fintek model f75387 (which is being recognized by sensors-detect =
but yet unsupported). My configuration is CentOS 5 + kernel 2.6.39 + lm_sen=
sors 3.3.1.

One of the main differences between the two models is that the 75387 has 11=
-bit temperature read in contrast to 8-bit with the older model. Up to now,=
 I managed the 11-bit part by converting some lines out of the lm63 source =
code. The temperature reading of the 75387 with the modified kernel module =
code seems now to be valid, so the module really seems to operate the chip.

However, I defined some labels in /etc/sensors3.conf. These labels do not a=
ppear in the sensors command. When strace'ing the sensors command I see tha=
t the /sys/class/hwmon/hwmon0/device/in0_label and all other label files do=
 not exist.
Additionally, the thresholds defined in sensors3.conf are not written to th=
e appropriate files in /sys/class/hwmon/hwmon0/device, although the thresho=
ld files temp1_max and others do exist. I can define them manually by just =
echo'ing the threshold value into temp1_max. Then the command sensors does =
show the right threshold.
The "ignore" statements (e.g. ignore fan1) also do not have any effect.

So this is my question: Which are the prerequisites for the module to creat=
e the label files and to set the thresholds on module load?

(..or is this in the end a question for the kernel list..?)

Best Regards
Bj=F6rn Gerhart

WINCOR NIXDORF International GmbH
Sitz der Gesellschaft: Paderborn
Registergericht Paderborn HRB 3507
Gesch=E4ftsf=FChrer: Eckard Heidloff (Vorsitzender), Stefan Auerbach, Dr. J=
=FCrgen Wunram
Vorsitzender des Aufsichtsrats: Karl-Heinz Stiller
Steuernummer: 339/5884/0020 - Ust-ID Nr.: DE812927716 - WEEE-Reg.-Nr. DE444=
77193

Diese E-Mail enth=E4lt vertrauliche Informationen.
Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrt=FCmlich er=
halten haben,
informieren Sie bitte sofort den Absender und vernichten Sie diese E-Mail.
Das unerlaubte Kopieren sowie die unbefugte Weitergabe dieser E-Mail ist ni=
cht gestattet.

This e-mail may contain confidential information.
If you are not the intended recipient (or have received this e-mail in erro=
r)
please notify the sender immediately and destroy this e-mail.
Any unauthorised copying, disclosure or distribution of the material in thi=
s e-mail is strictly forbidden.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
