From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 20 Sep 2009 08:28:21 +0000
Subject: Re: [lm-sensors] [PATCH] Add support for Atom CPUs
Message-Id: <20090920102821.57a55acf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A522794.1020507@assembler.cz>
In-Reply-To: <4A522794.1020507@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 06 Jul 2009 22:38:10 +0200, Rudolf Marek wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi all,
> 
> Thanks Martin for a test. It seems that TAGET MSR is not implemented, also
> driver incorrectly reports that it uses relative temperature scale. Fix it with
> updated patch.
> 
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

As there is increasing pressure to get support for the Atom CPU, I've
included this patch in my unofficial hwmon tree, fixed the two
comments, and will send it to Linus for kernel 2.6.32.  I still believe
adjust_tjmax() could and should be simplified, but this is left for a
future patch.

I've also updated sensors-detect.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
