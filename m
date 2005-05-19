From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: [PATCH] Re: prog/init/lm_sensors.init: reduce verbosity,
Message-Id: <20050101130000.2179765f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041213103836.GC4391@neu.nirvana>
In-Reply-To: <20041213103836.GC4391@neu.nirvana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> OK, here comes the second revision
> 
> o removed bashisms
>   - make proper redirects to /dev/null
>   - no bash-i18n
> o no attempt to start lm_sensors is no config file or no modules in
>   the config file
> o removed leading and trailing underscores of displayed module names
> o no /dev manipulation, it's not really part of an init script to
>   create device nodes.

Applied, thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
