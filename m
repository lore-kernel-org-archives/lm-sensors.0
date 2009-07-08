From: Rudolf Marek <r.marek@assembler.cz>
Date: Wed, 08 Jul 2009 20:38:05 +0000
Subject: Re: [lm-sensors] [PATCH] Add support for Atom CPUs
Message-Id: <4A5503AD.2060800@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A522794.1020507@assembler.cz>
In-Reply-To: <4A522794.1020507@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>> +	/* if we dont use msr EE it means we are desktop CPU (with exeception of Atom) */
> 
> Line too long.

Well I thought the 80 lines limit is not so strict anymore.

> 
>> +	} else if (tjmax = 100000) {
>>  		dev_warn(dev, "Using relative temperature scale!\n");
>>  	}
>>  
> 
> I think function adjust_tjmax() has reached its limit of readability. I
> don't understand why it needs to be so complex. For example, the case
> of the Atom is very simply always return 90 degree C. So why not just:

Yes right, but it is going to be complex for penryns. I will try to simplify it.

> 
> 	/* Atoms seems to have TjMax at 90C */
> 	if (c->x86_model = 0x1c)
> 		return 90000;

Because of multiple returns? If you are OK with multiple returns I will fix it.

> 
> at the beginning of the function, and be done with that case? And I
> suspect the rest can be simplified a bit too.
> 
>> @@ -248,9 +256,9 @@
>>  	platform_set_drvdata(pdev, data);
>>  
>>  	/* read the still undocumented IA32_TEMPERATURE_TARGET it exists
>> -	   on older CPUs but not in this register */
>> +	   on older CPUs but not in this register, Atoms don't have it too */
> 
> s/too/either/

ok
> sensors-detect needs to be updated as well.

yes good catch.

Thanks,
Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkpVA6YACgkQ3J9wPJqZRNVM6wCghNTnneKd3ta0M7X9GO+EeRNZ
OH4An3uuSHgvH/rB+8leDYf7zFAOI9mc
=HIzj
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
