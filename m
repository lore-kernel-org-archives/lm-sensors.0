From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Dec 2011 09:53:41 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Fix oops on driver load
Message-Id: <20111206105341.32b5b61f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111201110047.130190a5@endymion.delvare>
In-Reply-To: <20111201110047.130190a5@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 06 Dec 2011 07:26:59 +0800 (HKT), undersys wrote:
> The microcode utility I am using is :-
> http://urbanmyth.org/microcode
> 
> The version of micro code I am using is "microcode-20110915.tgz" :-
> http://downloadcenter.intel.com/Detail_Desc.aspx?agr=Y&DwnldID 429&lang=eng

Did you have to do that with previous kernels too?

> CPU is :-
> Intel Xeon sossaman, model, stepping=4. 
> I don't have the SPEC number on hand let me know if you need more information.

Is this a single or multi-cpu system?

I would like to see the contents of /proc/cpuinfo.

> Micro code was working on 2.6.29 and 2.6.39 , then I jumped to 3.0.6.

I admit I don't quite get it for now. While the device probing logic
was modified a lot in the coretemp driver of kernel 3.0, the microcode
check did not change, so I just don't get why the new driver would
behave differently from the previous ones in this respect.

For testing purposes, I made the 2.6.39 version of the coretemp driver
available as a standalone driver:
http://khali.linux-fr.org/devel/misc/coretemp_old/
(Instructions at http://khali.linux-fr.org/devel/misc/INSTALL )

I would like you to test it on your 3.0 kernel and report whether it is
working or not. You'll have to rmmod the original coretemp driver
before loading coretemp_old, you can't have both loaded at once.

If coretemp_old works, then please rmmod it and modprobe coretemp
again, and see if it then works.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
