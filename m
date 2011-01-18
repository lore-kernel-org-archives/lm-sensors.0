From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Jan 2011 12:59:54 +0000
Subject: Re: [lm-sensors] Sandy Bridge support?
Message-Id: <20110118135954.5b02e309@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <0022152d6d71d9f528049a109a02@google.com>
In-Reply-To: <0022152d6d71d9f528049a109a02@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 17 Jan 2011 23:26:03 +0000, DarkNovaNick@gmail.com wrote:
> I just tried doing "modprobe coretemp" and then when I did "sensors" it  
> seemed to output correctly. I'm not sure why I didn't think of that --  
> thanks. sensors-detect still does not suggest coretemp or any other modules  
> to load though. Thanks,

The problem is that sensors-detect and coretemp don't agree on the
detection method. The coretemp driver now checks CPU flags, while
sensors-detect still uses the old method of checking the CPU model. And
list of supported CPU models hasn't been updated for quite a while.

Unfortunately, the kernel detection method seems difficult to implement
in user-space. One would have to mess with binary access
to /dev/cpu/*/cpuid, which may not even be available on all systems.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
