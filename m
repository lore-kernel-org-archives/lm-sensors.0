From: mmosny@postel.sk (Martin Mosny)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: Tickets #1322 and #1323
Message-Id: <1403567547.20030708103833@postel.sk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030708093213.642bde1a.khali@linux-fr.org>
In-Reply-To: <20030708093213.642bde1a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> How did you get the lm_sensors Makefile from our CVS repository? I
> suspect you copied-and-pasted it directly from your web browser and that
> tabs were converted into spaces. Please double-check that lines 257 and
> 259 have leading *tabs* and not spaces. That would explain the error you
> see. If I'm right, running "make help" for example would give you the
> same kind of error at line 288.

I get the file:

# wget http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/Makefile

but  I  deleted  the  SPACES  on  line 257 and 259 and I have inserted
instead of them TABS

and all is working.

make help give to me the same error as before (257 missing)

NOW  with  the  tabs  all  works fine, in the next time I will get the
files only with cvs command

- --
Martin

-----BEGIN PGP SIGNATURE-----
Version: PGP 6.5i

iQA/AwUBPwp0+pdguByG9Q4aEQI0nwCeNmpowoD93ZPVcpfgywvhajnG9PcAnAk3
uy2fJnrWjZ2X0oPGe4NIQod/
=lNGF
-----END PGP SIGNATURE-----
