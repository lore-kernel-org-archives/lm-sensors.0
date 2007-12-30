From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 30 Dec 2007 09:29:42 +0000
Subject: Re: [lm-sensors] abituguru3 does not work with Abit IX38
Message-Id: <47776506.20709@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20071229T015954-296@post.gmane.org>
In-Reply-To: <loom.20071229T015954-296@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Bender wrote:
> Hans de Goede <j.w.r.degoede <at> hhs.nl> writes:
> 
>> I'm afraid that the abituguru3 driver only supports reading sensors and 
>> sensors settings, the pwm part is completely unsupported, not even 
>> reading the settings is supported.
> 
> I am willing to spend a few hours staring at assembly before I break down and
> buy their guru control panel.
> 
> Is there anyway to read the microcode on the uguru uC?
> 
> Perhaps looking at the BIOS code may help? I am sure there must be some routine
> for communicating with their uC in that code.
> 

David,

The current abituguru and abituguru3 drivers both have been written by me after 
other people ran the windows software under a debugger and stepped through the 
relevant code. So I guess thats one possible way to proceed, don't ask me for 
help there though, as said others (Louis Kruger in the case of the uguru3) were 
so kind todo the grunt work, I merely turned there results into a usable driver.

I will of course be happy to extend said driver with your results, although you 
might want to consider doing that yourself as I don't own an uguru3 motherboard.

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
