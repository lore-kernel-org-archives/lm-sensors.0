From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Jun 2012 07:00:18 +0000
Subject: Re: [lm-sensors] Lifebook E8020, no sensors
Message-Id: <20120620090018.4142a0f6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FE0EE87.8080806@gmx.de>
In-Reply-To: <4FE0EE87.8080806@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 19 Jun 2012 23:26:31 +0200, Michael Markusch wrote:
> Hi all,
> 
> I have an old Fujitsu Siemens Lifebook E8020 notebook. Since Ubuntu 9.??
> update I can not read CPU temperature by lm-sensors. Before that it was
> possible to display the temperature, but I can not say how I did it. I
> guess, I used coretemp... Now, the notebook runs with
> Ubuntu 12.04 and the problem is the same, see the log-files.
> 
> What could be the problem?

I'm not sure. Please try:
* The latest version of sensors-detect:
  http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
* Loading the coretemp driver manually even if sensors-detect did not
  recommend it.

If that doesn't work, please provide the contents of /proc/cpuinfo. I
admit I am surprised because your CPU supposedly has feature DTS (so
coretemp should work) although product number is 13 when I thought DTS
was first implemented with family 14.

Do you have a special file named /dev/cpu/0/cpuid after loading the
cpuid driver?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
