From: Michael Brunsteiner <michael.brunsteiner@rcpe.at>
Date: Fri, 21 Dec 2018 19:04:28 +0000
Subject: huge fluctuations of fan speed reported for MSI X370
Message-Id: <c197fb26-c10c-3ccc-c082-58f9800fa1a5@rcpe.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org



Hi,
I currently run some heavy load jobs on a few workstations (specs 
below), and since the computers
keep dying on me without anything in /var/log I try using lm-sensors to 
get an idea what's
wrong. the latest version I downloaded from github appears to work 
nicely on my
debian testing. However what I see is for fan3 and fan5 looks weird (I 
believe these are System 1 and 3 Fans):
i wrote a script that executes sensors every couple of seconds and 
writes the output into
a file called log.txt ... then I'd say, e.g.:

prompt>  grep fan3 log.txt
fan3:                  1047 RPM  (min =    0 RPM)
fan3:                  1049 RPM  (min =    0 RPM)
fan3:                  1042 RPM  (min =    0 RPM)
fan3:                  56784 RPM  (min =    0 RPM)
fan3:                  1044 RPM  (min =    0 RPM)
fan3:                  1044 RPM  (min =    0 RPM)
fan3:                  1044 RPM  (min =    0 RPM)
fan3:                  1042 RPM  (min =    0 RPM)
fan3:                  1047 RPM  (min =    0 RPM)
fan3:                  1049 RPM  (min =    0 RPM)
fan3:                  1048 RPM  (min =    0 RPM)
fan3:                  2096 RPM  (min =    0 RPM)
fan3:                  56784 RPM  (min =    0 RPM)
fan3:                  2099 RPM  (min =    0 RPM)
fan3:                  56784 RPM  (min =    0 RPM)
fan3:                  1048 RPM  (min =    0 RPM)
fan3:                  56784 RPM  (min =    0 RPM)
fan3:                  1042 RPM  (min =    0 RPM)
fan3:                  1040 RPM  (min =    0 RPM)
fan3:                  1043 RPM  (min =    0 RPM)
fan3:                  1047 RPM  (min =    0 RPM)
fan3:                  1048 RPM  (min =    0 RPM)
fan3:                  1047 RPM  (min =    0 RPM)
fan3:                  1048 RPM  (min =    0 RPM)
fan3:                  1042 RPM  (min =    0 RPM)
fan3:                  1043 RPM  (min =    0 RPM)
fan3:                  1041 RPM  (min =    0 RPM)
fan3:                  1041 RPM  (min =    0 RPM)
fan3:                  1044 RPM  (min =    0 RPM)
fan3:                  1042 RPM  (min =    0 RPM)
fan3:                  1048 RPM  (min =    0 RPM)
fan3:                  1048 RPM  (min =    0 RPM)
fan3:                  1044 RPM  (min =    0 RPM)
fan3:                  1042 RPM  (min =    0 RPM)
fan3:                  1045 RPM  (min =    0 RPM)
fan3:                  1046 RPM  (min =    0 RPM)
fan3:                  1044 RPM  (min =    0 RPM)
fan3:                  1047 RPM  (min =    0 RPM)
fan3:                  1043 RPM  (min =    0 RPM)
fan3:                  1048 RPM  (min =    0 RPM)
fan3:                  1041 RPM  (min =    0 RPM)

etc ... (fan )

every once in a while the fan speed supposedly is > 50000 RPM ... I 
guess if this was true the
computer should take off and leave the building through the roof ... 
which it does not do ...
I'd be grateful for any hints on how i can interpret what i see there!

I should add that fan2 (which according to some conf file I found online 
should be the "CPU Fan")
gives me output that looks much more "normal"

best regards & happy NY
michael





specs:
AMD Ryzen 7 2700X 8x 3.70GHz
MSI X370 Gaming Pro Carbon (this has a nct6795d chip, I believe)
Arctic Freezer 33 CO
G.Skill 16GB Ram Kit
240 GB Patriot Burst SSD
2x 4 TB Western Digital HDD
Chieftec A-90 GDP-750C 750W ATX 2.
Fractal Design Define R5 Black
Nvidia GTX 1060


-- 
==========================Michael Brunsteiner, PhD
Principal Scientist, Area II
Research Center Pharmaceutical Engineering GmbH
A-8010 Graz, Inffeldgasse 13
phone: +43 316 873 30908
mobile: +43 660 4887763
fax: +43 316 873 109700
e-mail: michael.brunsteiner@rcpe.at
www.rcpe.at
UID-Nr.: ATU64272307
FN: 312899x, FB-Gericht: LG für ZRS Graz

Vertraulichkeitshinweis
Diese Nachricht und allfällige angehängte Dokumente sind vertraulich und nur für den/die Adressaten bestimmt.
Sollten Sie nicht der beabsichtigte Adressat sein, ist jede Offenlegung, Weiterleitung oder sonstige Verwendung
dieser Information nicht gestattet. In diesem Fall bitten wir, den Absender zu verständigen und die Information zu
vernichten. Für Übermittlungsfehler oder sonstige Irrtümer bei Übermittlung besteht keine Haftung.

Confidentiality Note:
This message and any attached files are confidential and intended solely for the addressee(s). Any publication,
transmission or other use of the information by a person or entity other than the intended addressee is prohibited.
If you receive this in error please contact the sender and delete the material. The sender does not accept liability
for any errors or omissions as a result of the transmission.
