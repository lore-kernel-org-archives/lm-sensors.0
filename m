From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Feb 2011 12:19:33 +0000
Subject: Re: [lm-sensors] SUSE, 10.2
Message-Id: <20110205131933.6da5a9cd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTikLRKrsr7M2C9+qJry6Qn-C5KHuSgv5mXmxOUj8@mail.gmail.com>
In-Reply-To: <AANLkTikLRKrsr7M2C9+qJry6Qn-C5KHuSgv5mXmxOUj8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 5 Feb 2011 10:04:13 -0200, Marcelo De Cicco wrote:
> Hi people,
> 
> How do I install de lms sensor? I have downloaded the package, but I do not
> know how to install and configure it.  Our system is a cluster - SGI:
> headnode -   XE 320, with 8 nodes (6 XE 320 and 2 XE 340), with MPI. OS SUSE
> 10.2

lm-sensors is already packaged for Suse distributions, install package
"sensors", and optionally "sensord" if you need it, and you're done.
Then run "sensors-detect" and follow the instructions.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
