From: Jonathan Nieder <jrnieder@gmail.com>
Date: Thu, 05 Apr 2012 00:23:25 +0000
Subject: Re: [lm-sensors] asus_atk0110: i8042: keys get stuck and keyboard stops responding
Message-Id: <20120405002325.GE19575@burratino>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120320231656.GC12339@burratino>
In-Reply-To: <20120320231656.GC12339@burratino>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

GSR - FR wrote:
> jrnieder@gmail.com (2012-03-22 at 0940.40 -0500):

>> 	cat DSDT.aml >/sys/kernel/debug/acpi/custom_method
>
> I got some time to try all those things, but that step fails with
> "cat: write error: Invalid argument".

Does "dmesg | tail" give a more detailed message?

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
