From: MrNice <wxcvbn2006@iol.ie>
Date: Wed, 26 Sep 2012 14:01:55 +0000
Subject: Re: [lm-sensors] No such subfeature known when sensors -s
Message-Id: <50630AD3.40103@iol.ie>
List-Id: <lm-sensors.vger.kernel.org>
References: <5051971B.7030608@iol.ie>
In-Reply-To: <5051971B.7030608@iol.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 09/23/2012 07:39 PM, Jean Delvare wrote:
> On Sun, 23 Sep 2012 19:07:05 +0100, MrNice wrote:
>> Question: What program do you advise to heavy load the CPU and get
>> higher temp?
> $ md5sum /dev/zero &
>
> once per logical CPU.
>
Thanks Jean.

Unfortunately after the next boot, fan2 (CPU_FAN1 for ASROCK 970) was 
again at 0 RPM.
I tried more reboots, changes in the UEFI but nothing.
Very strange...

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
