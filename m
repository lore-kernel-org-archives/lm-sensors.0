From: rob.teel@gmail.com (Robert Teel)
Date: Tue, 11 Oct 2005 10:04:29 +0000
Subject: [lm-sensors] lm_sensors in an embedded environment
Message-Id: <6db3e120510110103w3c290a43o7b9da958f813f5a5@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6db3e120510101405xdbb6920wfdf863ba55896477@mail.gmail.com>
In-Reply-To: <6db3e120510101405xdbb6920wfdf863ba55896477@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I did some research on this subject, and I think lm_sensors would fit my
purposes well. I haven't confirmed if it would work on an non-mmu distro
(uClinux) though.

My goal for this is, as I have said, get uClinux running on a PPC core
inside and FPGA, or use some other small micro to run the lm_sensor package
in order to sense ambient temperature, fan tachs, and voltage levels. I'm
not interested in the core's internal temps or anything like that.

So far I have decided lm_sensors would work great, and I read somewhere that
someone had it working on a blackfin. Not to sure though since the
information was limited.

Rob

On 10/11/05, Jean Delvare <khali@linux-fr.org> wrote:
>
>
> Helly Kjeld,
>
> On 2005-10-10, Kjeld Flarup wrote:
> > You would most likely have to write the drivers your self.
>
> Why would he? What would the benefit be, please?
>
> --
> Jean Delvare
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051011/c2c421d8/attachment.html
