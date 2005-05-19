From: francois.barre@siemens.com (BARRE Francois)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: TR : RE : VIA VT1211 Port to 2.6.x in progress
Message-Id: <EFEF4C473088B847B64CD953D2A6A10401B08E24@sdso14a.par.siemens.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <400DF5D5.4020209@verizon.net>
In-Reply-To: <400DF5D5.4020209@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

This is my own port of the vt1211 for 2.6.x which seems to work pretty well,
including extensive insmod/rmmod uses, ...
I just have a problem with temp_[hyst|over]2, not solved yet... Working on
it !

I hope it will be of some help...

By the way, should someone include me in the sensors ml ?

Thanks in advance.

-----Message d'origine-----
De : Nuno Grilo [mailto:nuno.grilo@netcabo.pt] 
Envoy? : lundi 26 janvier 2004 00:58
? : Alexander Isacson; Mark Studebaker
Cc : BARRE Francois; 'nuno.grilo@netcabo.pt'; LM Sensors
Objet : Re: TR : RE : VIA VT1211 Port to 2.6.x in progress

Hi

Take a look at my port, I think it should be usable enough for what you
want: 
http://pwp.netcabo.pt/0246517002/vt1211.c

On Sunday 25 January 2004 21:28, Alexander Isacson wrote:
> Hello all.
>
> I'm wondering about the status of the port. I'm approaching the deadline
> for my project and I need to monitor voltages and temperature. Is that
> working in the current version? If so, could someone please e-mail it to
> me?
>
> Thanks allot, keep up the good work!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: vt1211.c
Type: application/octet-stream
Size: 24219 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040311/30edb0f0/vt1211.obj
