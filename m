From: "DG Cussans" <David.Cussans@bristol.ac.uk>
Date: Mon, 21 Jun 2010 16:30:48 +0000
Subject: [lm-sensors] ASUS P7P55D PRO
Message-Id: <43865.137.222.58.99.1277137848.squirrel@webmail.bris.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,
   I have a PC with a ASUS p7p55d motherboard. sensors-detect indicates
that it uses a W83667HG-B
Is there any estimate of how long it will take before there is a driver
for this device?

Many thanks,
David

Output of sensors-detect:

bash-3.2$ sudo /usr/local/sbin/sensors-detect

# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# System: System manufacturer System Product Name
# Board: ASUSTeK Computer INC. P7P55D PRO

[... snip ... ]
Do you want to scan for Super I/O sensors? (YES/no):

[... snip .... ]
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found `Nuvoton W83667HG-B Super IO Sensors'                 Success!
    (address 0x290, driver `to-be-written')



-- 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
