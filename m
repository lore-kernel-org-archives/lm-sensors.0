From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 05 Jul 2011 08:49:45 +0000
Subject: Re: [lm-sensors] IT8772E info and reports
Message-Id: <20110705104945.15ebcc13@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU0-SMTP109A7F3B6369B02834007CAA05C0@phx.gbl>
In-Reply-To: <BLU0-SMTP109A7F3B6369B02834007CAA05C0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 4 Jul 2011 15:33:52 +0100, Kazuya wrote:
> My system :
> 
> root@teddy:~# uname -a
> 
> Linux teddy 2.6.32-5-amd64 #1 SMP Tue Jun 14 09:42:28 UTC 2011 x86_64
> GNU/Linux
> (...)
> root@ted:~# modprobe it87 force_id=0x8721
> 
> FATAL: Error inserting it87
> (/lib/modules/2.6.32-5-amd64/kernel/drivers/hwmon/it87.ko): No such device
> 
>  
> 
> As you told me I tried modprobe it87 force_id=0x8721

Support for the IT8721F was only added in kernel 2.6.37 according to
http://www.lm-sensors.org/wiki/Devices
Your kernel is too old so you'd have to use the standalone it87 driver:
http://khali.linux-fr.org/devel/misc/it87/
Instructions at:
http://khali.linux-fr.org/devel/misc/INSTALL

If the coretemp driver in your kernel doesn't work for you, it also
exists as a standalone driver:
http://khali.linux-fr.org/devel/misc/coretemp/

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
