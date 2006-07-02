From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 02 Jul 2006 21:48:20 +0000
Subject: [lm-sensors] How to submit patches
Message-Id: <44A83F24.6040402@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <fcf695481614.44a7a0d9@urv.cat>
In-Reply-To: <fcf695481614.44a7a0d9@urv.cat>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Carlos,

> I have been working in patches for kernel drivers and libsensors, adding
> / mapping omitted registers about
> pwms and pwm divisors of the winbond family.

Well patches always welcomed. Please post the patches to the list.
Just use diff -uprN a/ b/

where a/ and b/ are two trees of sources. (The diff should be done using
the latest kernel -mm)

Indicate that the mail contains a patch with [PATCH] subject line. You may
include the patch into text attachment. The message body will just contain
a description of the patch and Signed-Off-By line if it is for kernel patch.

You may also read
http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/linux-2.6.17.y.git;a=
=3Dblob;h=C2c85bcb3d438b983ccc1535acbbd185867e26c3;hbRcbb7b78994ea3799f1bbb=
8c03bce1e2f72a271;f=3DDocumentation/SubmittingPatches
and
http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/linux-2.6.17.y.git;a=
=3Dblob;h=CE5d2c038cf54603d76c32b25e563456ebcf6711;hbRcbb7b78994ea3799f1bbb=
8c03bce1e2f72a271;f=3DDocumentation/CodingStyle

The SubmittingPatches document is explaining the procedure of submitting pa=
tches
to kernel. If you follow the rules and just use the lm-sensors mailing list=
 all
will be fine. (I described the rules briefly above)

I hope it is more clear now. If you have more questions ask please.

Regards
Rudolf





