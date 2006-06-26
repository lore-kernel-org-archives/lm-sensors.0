From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 26 Jun 2006 20:34:46 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <44A044E6.1080204@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> The temp <-> pwm mapping standard already exists.

Aha ok. pwm[1-*]_auto_channels_temp I guess.

>>> But the driver uncondionally creates both files? This needs to be
>>> investigated, and fixed (either the driver or the documentation.)
>> I fixed the note. The files are used in SF3 iirc, so we might have them.
> 
> I'm still not exactly happy. Documenting that we implemented things in
> a possibly non-working way is better than not documenting it, agreed,
> but even better would be to have things working in the first place.

This stuff is so complex that even if you think you got it right, then some bits 
will make even bigger mess than it was.

> Also on the to do list is the export of the fan <-> temperature
> mapping, at least read only, as I asked before already. For now pwm4 is
> useless in Temperature Cruise mode, as you don't know what temperature
> channel it is working with.

pwm4 is disabled on my board so I cannot tell which is which. I remmber that on 
david board it is disabled too.

I will put this into my queue, do it soon.

> Anyway, I will apply these patches now, as we have gone trough many
> review cycles already. I made some fixes to the documentation patch to
> fix typos and reword one sentence. Any future change to the w83627ehf
> driver or its documentation should be incremental on top of these
> patches.

Thank you very much. As you know I'm not in exactly good situation so I hope I 
will do better next time when things are sorted out.

Regards
Rudolf

