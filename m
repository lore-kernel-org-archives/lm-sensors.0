From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 01 Jul 2006 14:16:41 +0000
Subject: [lm-sensors] [RFC PATCH] include statement in
Message-Id: <20060701161641.9ea19c5b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060701123027.GD3140@jupiter.solarsys.private>
In-Reply-To: <20060701123027.GD3140@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> Before I get started on the code, is everyone OK with this?
> (patch to man page, which serves as spec...)

I like the feature, just one suggestion:

> +.SS INCLUDE STATEMENT
> +.RS
> +include "/etc/sensors/foo.conf"
> +.RE

I think most distribution will use /etc/sensors.d/ instead.

> +.RS
> +include "sensors/foo.conf"
> +.RE
> +.RS
> +include "foo.conf"
> +.RE
> +
> +The
> +.I include
> +statement causes the program to continue reading configuration from the
> +named file.  Upon reaching the end of the named file, the program will
> +continue reading configuration from the original file beginning with the
> +line after the
> +.I include
> +statement.
> +
> +If the filename is not absolute, then the program looks for the file in
> +the current working directory.  

This doesn't sound like a very useful feature and might even be
considered a security problem. I would instead suggest that relative
filenames are resolved based on the directory the including file is
located in.

Thanks,
-- 
Jean Delvare

