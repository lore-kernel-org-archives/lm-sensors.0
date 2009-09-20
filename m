From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 20 Sep 2009 08:49:07 +0000
Subject: Re: [lm-sensors] [PATCH] Add support for Penryn mobile CPUs
Message-Id: <20090920104907.5751c9d1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A5228B8.7010604@assembler.cz>
In-Reply-To: <4A5228B8.7010604@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Wed, 08 Jul 2009 22:40:05 +0200, Rudolf Marek wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> > Logic is invalid: if there's an error then the value of edx is
> > undefined.
> 
> 
> Yes I know, but there was no place I could create this variable. Perhaps I need
> to re-think it a bit. Maybe on sunday evening :/
> 
> Anyway thanks for the review! I will try to fix it somehow.

Any news about this? I'd like to push this to Linus, it's been delayed
way too long already.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
