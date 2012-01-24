From: Phillip Susi <psusi@ubuntu.com>
Date: Tue, 24 Jan 2012 14:15:55 +0000
Subject: Re: [lm-sensors] Per motherboard config
Message-Id: <4F1EBD1B.6090405@ubuntu.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4F19BC74.7010506@ubuntu.com>
In-Reply-To: <4F19BC74.7010506@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 1/24/2012 2:45 AM, Jean Delvare wrote:
> The missing piece now is a script that would check the DMI data of
> the motherboard, look for a suitable configuration file and
> download it to /etc/sensors.d semi-automatically. This could be
> integrated into sensors-detect or made a separate script. This has
> been discussed in the past already, some implementations have even
> been floating around. Now it's really a matter of someone taking
> the time to integrate it all properly.

Now that sounds like a good idea!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPHr0bAAoJEJrBOlT6nu75R/QH/jU6CAqg8FMSpAzXvc/7CDTt
5m21j6zJPCJmqZm3yX2aUkc5aPrqS8m2gsfg11aBwYeCPCsL5eQq2Ke2fu33hR4l
U22E5QfComWjoYaos52h8F92C2mrBpdcW4Oxx9xp1SqTL42IhRgiQgBGdEEmXH4i
qV2Uhdvdm5XT9IpMajFl8cgN9l88nwdGnVRXMXEBlQ2OAVbzTlBROCToDHu5pRR6
oCje7jrs9KYB+7Qv8NWOoJsp/tWZS8zaC4tx3xGxUGl/nPtZ9CwgH1TvotgxFRT3
6K4+J47MebRpBnfJw502pc1pHdVhYUgSR+aPqIYOOBY71Wb1k8vGYQknvcL0ebM=MiV0
-----END PGP SIGNATURE-----

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
