From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 Apr 2009 07:16:42 +0000
Subject: Re: [lm-sensors] "suid root" bug in isadump/isaset
Message-Id: <20090419091642.546a7e06@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <250565.40871.qm@web44705.mail.sp1.yahoo.com>
In-Reply-To: <250565.40871.qm@web44705.mail.sp1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 17 Apr 2009 11:11:38 -0700 (PDT), Linux User wrote:
> Dear Lm- Sensors Developers,
> 
> both isadump and isaset contain the check:
> 
>   if (getuid()) {
>     fprintf(stderr, "Error: Can only be run as root "
>             "(or make it suid root)\n");
>     exit(1);
>   }
> 
> The text of the error message suggests that these programs could be installed "suid root". If  this is the case,
> the check should use "geteuid()" instead of "getuid()".

Done, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
