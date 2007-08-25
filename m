From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 25 Aug 2007 17:18:19 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] libsensors4: New prototype for
Message-Id: <46D0645B.5060406@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070825150259.0a936215@hyperion.delvare>
In-Reply-To: <20070825150259.0a936215@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Add a parameter to sensors_get_detected_chips(), to optionally let the
> caller select which subset of chips it wants. This is slightly better
> size-wise than letting all applications do the filtering by themselves.
> 
> This will change the way the command line parameters of "sensors" are
> interpreted. Beforehand, the chips were always returned in the order
> in which they were listed by the library. Also, each chip could be listed
> only once. From now on, the chips will be listed in the order in which
> they are passed on the command line, which I think makes more sense. A
> side effect is that chips can be listed more than once, if that's what
> the user asks for. Not very useful though.
> 
> This change makes it possible to make sensors_match_chip() internal
> to the library. Filtering the list of chips returned by
> sensors_get_detected_chips() was the last known external use for this
> function.
> 
> This patch looks much bigger than it really is, but the largest part is
> really only code reindentation.
>

Yes, making it harder to review, anyways reviewed and it looks good.

Maybe next time when there is lot of indentation changes include 2 patches, the 
real one and one made with diff -uBb, the second one will then only show the 
real changes.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
