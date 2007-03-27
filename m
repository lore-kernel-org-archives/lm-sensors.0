From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 27 Mar 2007 15:39:41 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <20070327173941.571d4623.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ivo, Ed,

Ed, please fix your Reply-To.

On Tue, 27 Mar 2007 08:03:58 +0200, Ivo Manca wrote:
> We (three students from the Netherlands) are running quite a similar project 
> right now: adding DMI support to sensors-detect, which tries to find a match 
> with a local-database, then extracts the corresponding configuration. It 
> sounds quite like the project you made.
> 
> I don't have time to look into the software you made right now, but I will 
> tonight. But it sounds like it is at least "very useful".
> 
> I wonder what Jean (and ofcourse: everyone else) will think about it,

Jean didn't have enough time to look into one project, he hardly has
more time looking into two :( So I'll leave it up to you (Ivo and Ed)
and Hans to pick the best ideas and come up with one common solution. I
really don't think we want to have two or more projects doing the same
thing.

As Hans underlined earlier, getting the dynamic chips support in
libsensors first should address a number of problems.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
