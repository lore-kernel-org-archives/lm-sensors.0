From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 Jan 2009 08:15:13 +0000
Subject: Re: [lm-sensors] Problems with f71882fg and NVIDIA graphics card
Message-Id: <20090121091513.769d1da5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1232481045.6371.77.camel@malcolm>
In-Reply-To: <1232481045.6371.77.camel@malcolm>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 21 Jan 2009 08:58:33 +0100, Jean Delvare wrote:
> Malcolm, did you try the pnp boot parameters I suggested on IRC?

If these didn't work (I tried both pnpbios=off and pnp_reserve_io and
neither worked for me) you should try pnpacpi=off, that worked for me.

But of course the real solution is to get your BIOS fixed.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
