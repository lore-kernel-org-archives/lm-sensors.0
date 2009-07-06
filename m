From: Rudolf Marek <r.marek@assembler.cz>
Date: Mon, 06 Jul 2009 16:44:00 +0000
Subject: Re: [lm-sensors] Test of k8temp
Message-Id: <4A5229D0.2000009@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A520751.3070803@assembler.cz>
In-Reply-To: <4A520751.3070803@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

It seems mine emails are arriving multiple times. I'm sorry about that. Axel, is
it doing mine ISP?


> I totally agree with you that's why I removed the support for 10h as per
> your suggestion.


Ok fine.

> 
>> I'm perfectly fine if you come up with a patch for fam 11h because the Errata 
> is still waiting for your approval.

Aha sorry I forgot about this one. Please can you re-structure it so there are
not a goto's I think kernel codingstyle allows them only for error paths.

Thanks,

Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkpSKdAACgkQ3J9wPJqZRNXepwCfYtwYNNUx5DDmQrh4tavtCoy5
JmwAoLIm4L0L3cunKR44eVbaIuPKeQKL
=pOcu
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
