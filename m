From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Mar 2009 10:08:17 +0000
Subject: Re: [lm-sensors] [PATCH] sensord: Remove leading whitespaces in
Message-Id: <20090310110817.1a1c4c25@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090310083014.GA5543@ubuntu>
In-Reply-To: <20090310083014.GA5543@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 10 Mar 2009 09:30:14 +0100, Andre Prendel wrote:
> Hi Jean,
> 
> as you noticed about my last patch series, there were some whitespaces
> in the code. Unfortunately quilt complains only about trailing
> whitespaces, not leading ones in empty lines. So there are some ones left.

That's pretty strange, I pretty much thought it did for me at least at
some point in time...

> With this patch we get rid of the remaining ones.

Sure, please apply.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
