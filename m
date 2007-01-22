From: vitorenna83@aruba.it (Vito Renna)
Date: Mon, 22 Jan 2007 19:46:09 +0000
Subject: [lm-sensors] coretemp module
Message-Id: <45B51481.3060705@aruba.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <f98ab5760701171008v402baf4lb265e2936926d73c@mail.gmail.com>
In-Reply-To: <f98ab5760701171008v402baf4lb265e2936926d73c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

You have to compile your kernel after editing the files that are listed 
in the patch here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-January/018676.html
This is the way the coretemp module can be installed in your system.

Bye.
> Hello,
>
> I am having trouble installing the 'coretemp' driver.  I downloaded 
> the patch from here: 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-October/018100.html 
> <http://lists.lm-sensors.org/pipermail/lm-sensors/2006-October/018100.html>.
>
> But I don't know what to do with this file.  It downloads a file with 
> a .bin extension.  I have installed lm-sensors, ran sensors-detect.  
> It seemed to detect everything okay, the only thing it said was I have 
> to modprobe coretemp driver.  And in addition, the coretemp driver is 
> not found on the system. 
>
> Any help would be greatly appreciated.  Thanks.
>
> Ryan Murdick
> ------------------------------------------------------------------------
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


