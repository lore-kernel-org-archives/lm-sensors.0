From: Rudolf Marek <r.marek@assembler.cz>
Date: Sat, 05 Jan 2008 17:13:45 +0000
Subject: Re: [lm-sensors] error loading coretemp module for 2.6.21.5 kernel
Message-Id: <477FBAC9.6080601@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <975b59c50712271552u8e4b846r9545f817f8d779e1@mail.gmail.com>
In-Reply-To: <975b59c50712271552u8e4b846r9545f817f8d779e1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jean Delvare wrote:
> On Sat, 29 Dec 2007 13:03:55 -0800, Rutul Dave wrote:
>> Thanks Rudolf, your suggestion did work. I was able to load
>> coretemp.ko with the fix. The CPU model for the new processors is 0x17
> 
> Rudolf, care to submit a proper patch for upstream inclusion?

I'm trying to get answer from Intel how to detect the mobile/non mobile CPUs
properly. They are silent. I think what we have now works, so I will prepare a
patch perhaps.

Rudolf

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHf7rJ3J9wPJqZRNURAnIOAJ4p54Xy7PSAEAd/g3E8KjMKFhDHPACfb45N
giY1wzPhXi8E8z1jb4OgKZw=MLRZ
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
