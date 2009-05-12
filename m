From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 May 2009 19:48:29 +0000
Subject: Re: [lm-sensors] [PATCH v2 7/7] sensord: Refactoring of rrdInit()
Message-Id: <20090512214829.4364cd6f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090511160435.GH17530@ubuntu>
In-Reply-To: <20090511160435.GH17530@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 11 May 2009 18:04:35 +0200, Andre Prendel wrote:
> Refactoring of the rrdInit() function.
> 
> * Fix deep indentation levels
> * Return with unique error code (-1)
> 
> Changes in v2:
> 
> Fix wrong condition.
> Rename buffer for struct stat to sb.

Actually from tmp to sb ;)

Looks good, please commit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
