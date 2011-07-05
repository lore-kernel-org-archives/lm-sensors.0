From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 05 Jul 2011 12:17:12 +0000
Subject: Re: [lm-sensors] IT8772E info and reports
Message-Id: <20110705141712.6a7f2dad@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU0-SMTP109A7F3B6369B02834007CAA05C0@phx.gbl>
In-Reply-To: <BLU0-SMTP109A7F3B6369B02834007CAA05C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Tue, 5 Jul 2011 13:01:50 +0100, Kazuya wrote:
 root@teddy:~/driver# modprobe it87
> 
> FATAL: Error inserting it87
> (/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/it87.ko): No such device
> 
> root@teddy:~/driver# rmmod it87
> 
> ERROR: Module it87 does not exist in /proc/modules
> 
> root@teddy:~/driver# insmod it87.ko
> 
> insmod: error inserting 'it87.ko': -1 No such device
> 
> root@teddy:~/driver# rmmod it87
> 
> ERROR: Module it87 does not exist in /proc/modules

As said on the wiki - and as you did before already:

# modprobe it87 force_id=0x8721

> For coretemp, it seems to work perfectly !
>
> Thank you !!!!!

You're welcome.

> I don’t know what to do for it87… How can I get a driver?  Can you help me
> or there is no driver at all…

With the force_id=0x8721 parameter, the driver should load fine.
However we don't know how compatible the IT8772E chip is with the
IT8721F, so it may not work perfectly. That's why we were calling for
testers.

So ideally you'd write down every monitored value in your BIOS, and
compare with the output of "sensors" under Linux, and we can try to
write a configuration file for your board, and we see if any problem
shows up.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
