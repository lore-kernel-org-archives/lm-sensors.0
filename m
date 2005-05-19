From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:13 +0000
Subject: lm_sensors ain't updating cpu temp
Message-Id: <20040830184427.1e1f370a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1093792983.3809.5.camel@84.xa.interkam.pl>
In-Reply-To: <1093792983.3809.5.camel@84.xa.interkam.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Usually in /var/log, in files named syslog, messages and/or debug.
> > Exact names and contents depend on the distribution. You can also
> > watch the kernel log buffer by running "dmesg".
> 
> what should I look for?

Any line with "i2c" or "w83781d" or "w83697hf" is a good candidate. If
you see any line with either word which sounds like an error, report to
us.

> > OK, it looks rather good overall. If I understand what you first
> > said correctly, temp1 is changing, but temp2 isn't and will always
> > read 53.5 degrees?
> 
> As I wrote in another mail (maybe he didn't get to the list) it
> usually looks like that: temp1 +39C and temp2 +29C. Of course it
> begins with temp1 smaller that temp2. The sample I've sent you done
> after a couple of hours running and after a reboot. When I reboot the
> temp2 is updated but it seems that it is updated only during bootup.

Your mail made it to the list, I just didn't quote it in my answer.

> > What are the brand and model name of your motherboard?
> 
> I believe it is Jetway V266B.

So I confirm that temp1 is the case temperature and temp2 is the CPU
temperature. No surprise. Both are thermistor-based.

Things to try:

1* Cycle the w83781d driver (as root):
$ rmmod w83781d
$ modprobe w83781d
And see if temp2 changes.

2* Try to pass init=0 to the w83781d module:
In the file /etc/modprobe.conf, add the following line:
options w83781d init=0
I just hope that this file is not generated from other files on your
system. If it is, you'll have to find out which files this one is
generated from, and edit one of them instead.
Then reboot your computer and see if it helps.

I can't remember a similar report so far (by my memory is rather weak).

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
