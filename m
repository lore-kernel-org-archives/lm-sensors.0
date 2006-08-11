From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 11 Aug 2006 07:50:37 +0000
Subject: [lm-sensors] BIOS Corruption (was : new abituguru driver in mm
Message-Id: <44DC36CD.1020405@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
In-Reply-To: <ce9ef0d90608052222j74e9f6fes40cbc5edf5678577@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> 
> (As a side note, our sensors-detect script still doesn't know about the
> uGuru. Don't you want to add support for it? Or is it just too
> dangerous because of the non-standard I/O addresses?)
> 

I don't know what else could be behind those addresses, so thats not the 
reason I haven't worked on adding it to the script yets. The real 
problem is that the current detection code in the driver could very well 
miss-detect. The only good way of doing detection would be todo a proof 
read. A better idea would be to use dmidecode and sue the info from 
there, atleast for Abit motherboards this info seems sane. I could do 
that if you want me to (as time permits).

Regards,

Hans

