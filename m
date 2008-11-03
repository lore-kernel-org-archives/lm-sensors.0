From: Wolfgang Pichl <wolfgang.pichl@univie.ac.at>
Date: Mon, 03 Nov 2008 17:32:48 +0000
Subject: Re: [lm-sensors] Andigilog driver by George Joseph
Message-Id: <Pine.LNX.4.64.0811031801200.7398@belenos.adsl.univie.ac.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0811022213310.5906@belenos.adsl.univie.ac.at>
In-Reply-To: <Pine.LNX.4.64.0811022213310.5906@belenos.adsl.univie.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 3 Nov 2008, Hans de Goede wrote:
>
> Great, note that it is far easier to try this outside of an kernel tree. If 
> you have a pre build distro kernel + headers, then just drop asc7621.c (which 
> should be generated successfully by the patch) and the attached makefile in a 
> dir.
>
> Then in that dir type "make" followed by "insmod asc7621.ko"
>
Many thanks, I'll do that. I don't use a pre build distro kernel, I 
always install vanilla kernels from kernel.org and compile them for my 
machine. So building an additional driver should not be a problem; you are 
right, it is better to do this outside the kernel tree and ignore the 
problem with the patch.
>
> If you use lm_sensors-3.0.x it will automatically work with any new drivers, 
> per chip userspace support luckily is a thing of the past.
>
That is fine. I have still lm_sensors-2.10 from the Slackware distribution 
I'm using; I'll immediately download the latest 3.0.x version.


  Regards
  Wolfgang


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
