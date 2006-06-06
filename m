From: jirislaby@gmail.com (Jiri Slaby)
Date: Tue, 06 Jun 2006 07:00:40 +0000
Subject: [lm-sensors] [PATCH 1/3] pci: i2c scx200_acb avoid
Message-Id: <4485226B.5030502@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060606083318.8c69a0ff.khali@linux-fr.org>
In-Reply-To: <20060606083318.8c69a0ff.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jean Delvare napsal(a):
> Hi Jiri,
> 
>> i2c scx200_acb avoid pci_find_device
>>
>> i2c scx200_acb bus driver pci_find_device -> pci_get_device conversion.
> 
> The use of pci_find_device in scx200_acb was added by a patch from
> Jordan Crouse which is not yet finished and applied, so I asked Jordan
> to fix it in the next iteration of his patch directly. As a result,
> your patch will no more be necessary. Thanks for pointing out the use
> of a deprecated function though.
> 
> As a side note, I'd suggest that you stop sending patches to three
> mailing lists at once, as this generates lot of traffic and makes
> discussions difficult. Please pick the best list for your patches and
> send to only this list.
Ok, thanks.
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby at gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEhSJrMsxVwznUen4RAqgMAJ9SnTsewLD/STvixdzxSJBuxe+sUQCgla5c
VbUBkFWCxiMH+35CrK0sxdo=xoGY
-----END PGP SIGNATURE-----

