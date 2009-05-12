From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 May 2009 16:26:32 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/7] sensord: Introduce struct
Message-Id: <20090512182632.532691b6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090511160111.GC17530@ubuntu>
In-Reply-To: <20090511160111.GC17530@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 11 May 2009 18:01:11 +0200, Andre Prendel wrote:
> Introduce struct sensord_args.
> 
> This structure encapsulate all the variables holding the commandline
> arguments. So we get rid of plenty of extern variables. This reduces
> namespace collisions and unifies access.
> 
> Changes in v2:
> 
> Removed needless intitialization in sensord_args.

Looks OK, please commit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
