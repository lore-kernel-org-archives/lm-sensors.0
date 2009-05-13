From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 May 2009 16:16:20 +0000
Subject: Re: [lm-sensors] svn commit: r5724 - lm-sensors/trunk/prog/sensord
Message-Id: <20090513181620.79d1bed6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 13 May 2009 19:24:09 +0200, lm-sensors-notify@lm-sensors.org wrote:
>       Author: andy
>         Date: Wed May 13 18:13:41 2009
> New Revision: 5724
>    Changeset: http://lm-sensors.org/changeset/5724
> 
> Modified:
>    lm-sensors/trunk/prog/sensord/rrd.c
> 
> Log:
> sensord: Refactoring of the rrdInit() function.
> 
> * Fix deep indentation levels
> * Return with unique error code (-1)
> * Rename buffer for struct stat from tmp to sb.

Please also add a few lines in CHANGES for the most important changes.
It is important for the users to know what is happening to the code.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
