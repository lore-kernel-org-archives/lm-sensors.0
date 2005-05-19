From: vgmarimon@terra.es (Victor G. Marimon)
Date: Thu, 19 May 2005 06:23:54 +0000
Subject: formula for calculating cpu temp with ASUS cusl2-c
Message-Id: <200304252010.06867.vgmarimon@terra.es>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi, i have an asus cusl2-c mainboard and lm_sensors report bad temp in cpu.

I have a ASUS iPanel and i test some temperatures and i found this formula 
correct:


	realvalue = (1,39 * programvalue) + 24,5

in sensors.conf:


    compute temp2 (@*1.39)+24.55,(@-24.55)/1.39


See Ya

- -- 
Victor G. Marimon
Miembro de Bulma (http://bulmalug.net)
Usando Gentoo Linux 1.4
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+qXn+mAtZm4z1xakRApeWAJ9It/dRtI77bSME2ObPo06ID7lvWwCffp0p
VbFjLtakZnzehsxBgNeotdY=ZPjW
-----END PGP SIGNATURE-----

