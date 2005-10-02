From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 02 Oct 2005 11:35:37 +0000
Subject: [lm-sensors] [PATCH 2.6] Documentation fix (writing-clients)
Message-Id: <20051002113530.141ce698.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200510011330.AA01323@k7.kit.hi-ho.ne.jp>
In-Reply-To: <200510011330.AA01323@k7.kit.hi-ho.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Ohaio Hideki,

> o Remove flags parameter from detect function.

This one I already fixed in one of Jeff Garzik's trees, as part of a
larger documentation patch. It's just a matter of time before it
reaches mainline.

http://www.kernel.org/git/?p=3Dlinux/kernel/git/jgarzik/misc-2.6.git;a=3Dbl=
obdiff;h=9B9b7d0e54f24d447fc07e3a25ac1696e5d60143;hp=CC25797017453600a686bb=
ed6c18e0b8d07e6d03;hb=0Fc9dcdae08ec08daf1efd8e4bda78395a655240;f=3DDocument=
ation/i2c/writing-clients

> o i2c_smbus_read_i2c_block_data is not deleted in 2.6.10. It still exists.

Correct, I've applied this one, thanks.

BTW, do not hesitate to sign the patches you send, by adding the
following line in the header comments:

Signed-off-by: Hideki Iwamoto <h-iwamoto@kit.hi-ho.ne.jp>

That way you'll always get properly credited for your work. This also
allows for easier tracking of changes if anyone has questions about a
particular patch.

Arigato,
--=20
Jean Delvare
