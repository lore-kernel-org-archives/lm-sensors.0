From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 10 Apr 2008 19:17:48 +0000
Subject: Re: [lm-sensors] AMD K10
Message-Id: <47FE67DC.1040007@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <36.1363-16343-911986936-1207841970@seznam.cz>
In-Reply-To: <36.1363-16343-911986936-1207841970@seznam.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Unfortunately all three B revisions (BA B2 and B3) of AMD k10 suffer from
following errata:

Description
The internal thermal sensor used for CurTmp (F3xA4[31:21]), hardware thermal
control (HTC), software thermal control (STC), and the sideband temperature
sensor interface (SB-TSI) may report inconsistent values.

It is same case as some K8 CPUs but I dont know if it is wise to confuse users
with incorrect values ;)

What is your CPUID please?

cat /proc/cpuinfo

or run cpuid utillity.

Thanks,

Rudolf


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFH/mfc3J9wPJqZRNURAgowAKCIZnHg20tCRQqOUgGiaHTprs1RpACg3ank
2OHcSNbqNjuA34s1bCVjAuc=O6WB
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
