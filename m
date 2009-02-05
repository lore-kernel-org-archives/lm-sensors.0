From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Feb 2009 14:32:22 +0000
Subject: Re: [lm-sensors] [Patch] libsensors: Ignore directories and
Message-Id: <20090205153222.6c347598@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090205090331.GA5150@ubuntu>
In-Reply-To: <20090205090331.GA5150@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 5 Feb 2009 15:20:17 +0100, Andre Prendel wrote:
> So I will take a closer look at valgrind. I have used only the
> memcheck tool so far. After that you will get an updated patch.

The memcheck tool is very nice indeed. But in this case the tool I had
in mind is callgrind (with kcachegrind to look at the results.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
