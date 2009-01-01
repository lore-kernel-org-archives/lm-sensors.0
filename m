From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 01 Jan 2009 14:24:38 +0000
Subject: Re: [lm-sensors] ADT7463
Message-Id: <495CD226.4050801@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200612172022.kBHKMM3N011597@srv1.nickelnetworks.com>
In-Reply-To: <200612172022.kBHKMM3N011597@srv1.nickelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Enrico Ng wrote:
> I have a JVC Mininote XP-MP7431 laptop.  It is pretty old but I know
> that I can control the fan using speedfan in windows.  I'm having
> trouble getting my sensors working in linux.  I am using ubuntu.
> When I do "sensors-detect" it does not detect anything.  I've tried
> loading lm85 but that does not make any difference.  I'm wondering if I
> need to recompile the kernel to add support or something.  I'm not sure
> whats already in there as I can't find the .config.
> 
> I'd appreciate any help.
> Let me know if you need the output from any commands, I'm unsure about
> what to attach.

Hmm,

That chip should be detected just fine, can you please try this version of 
sensors-detect:
http://www.lm-sensors.org/browser/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect?format=raw

(All you need to do is safe the one file and make it executable)

And include the output of running this in your next mail?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
