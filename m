From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 Nov 2013 21:56:13 +0000
Subject: Re: [lm-sensors] coretemp readings are static/constant
Message-Id: <20131129225613.100b78d2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20131119T072701-70@post.gmane.org>
In-Reply-To: <loom.20131119T072701-70@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 29 Nov 2013 16:41:37 -0500, Tom Metro wrote:
> So this would appear to be a problem with the coretemp kernel module.
> This CPU (Intel Core 2 Duo P8400) is from the right era to be supported
> by coretemp. Where is the best place to go to file a bug against that
> module?

The driver reports what the hardware says. You may not like it but
there's basically nothing we can do about it. I see no point in opening
a bug about it. I think you have a CPU sample with broken DTS.

The only way I will change my opinion on this is if you run another OS
on the very same system and you get other values for the DTS there. But
really I doubt this will happen.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
