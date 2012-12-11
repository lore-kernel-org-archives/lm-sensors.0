From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Dec 2012 10:00:58 +0000
Subject: Re: [lm-sensors] Driver for Bulldozer
Message-Id: <20121211110058.1f807d9d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAMcsHH20xPDkTq7+9KyxDodnNYKB+UNS3_T=Exfq=BfP+kaxjw@mail.gmail.com>
In-Reply-To: <CAMcsHH20xPDkTq7+9KyxDodnNYKB+UNS3_T=Exfq=BfP+kaxjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 11 Dec 2012 04:44:50 -0500, Vahid Keykhaey wrote:
> test -d /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon || mkdir
> /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon
> cp k10temp.ko /lib/modules/3.2.0-23-generic/kernel/drivers/hwmon
> depmod -a -F /lib/modules/3.2.0-23-generic/build/System.map 3.2.0-23-generic
> FATAL: Could not open '/lib/modules/3.2.0-23-generic/build/System.map': No
> such file or directory
> make: *** [modules_install] Error 1Your distribution puts the System.map
> file at a different location.
> 
> I got it again with new makefile.

Please show the results of the following command:
$ ls -l /boot/*.map*

If it doesn't return anything you'll have to figure out where your
System.map file is, as I can't guess.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
