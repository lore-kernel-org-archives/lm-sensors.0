From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 26 Feb 2006 18:06:00 +0000
Subject: [lm-sensors] 64bit cleanliness issue
Message-Id: <Qp9UjdSJ.1140977160.4673860.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1140976852.12219.48.camel@thor.tres.org>
In-Reply-To: <1140976852.12219.48.camel@thor.tres.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Tres,

On 2000-02-26, Tres Melton wrote:
> I'm not on the mailing list so please CC me if needed.
>
> 64bit cleanup to lm_sensors-2.9.2
> lib/proc.c:236: warning: passing arg 4 of `sysctl' from incompatible pointer
> type
> lib/proc.c:427: warning: passing arg 4 of `sysctl' from incompatible pointer
> type
> lib/proc.c:468: warning: passing arg 4 of `sysctl' from incompatible pointer
> type

Already fixed in 2.10.0.

Thanks,
--
Jean Delvare

