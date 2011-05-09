From: Harry G McGavran Jr <w5pny@w5pny.com>
Date: Mon, 09 May 2011 20:21:49 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110509202149.C01B91A987F@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 9 May 2011 22:07:10 +0200 Jean Delvare wrote:
> On Mon, 09 May 2011 13:50:41 -0600, Harry G McGavran Jr wrote:
> > On Mon, 9 May 2011 21:42:31 +0200 Jean Delvare wrote:
> > > This is a valuable observation. I presume that these CPUs are too old
> > > to be multicore, best they could have it hyperthreading. Harry, can you
> > > please share the contents of /proc/cpuinfo?
> > 
> > Attached below ...
> 
   .
   .
   .

> 
> Interesting... Your CPU is slightly more recent than Jeff's (stepping
> 10 instead of 1), both advertise HT but yours has it disabled. Maybe
> there's an option in the BIOS to enable or disable HT? Or maybe Linux
> didn't like HT for some reason (in which case it should say so in the
> boot messages.)

I don't see anything about HT in the boot messages.

I didn't change anything in the BIOS regarding the CPU from
whatever the defaults are.  I don't remember seeing any
options for HT (or CPUfreq) in the BIOS and I haven't
changed anything in Linux from the Ubuntu Lucid default distro
regarding either HT or CPUfreq... 

> 
> It also seems like Jeff has CPUfreq enabled on his system and you do
> not. It's unrelated to hardware monitoring, but for the sake of power
> savings, it might be worth investigating.

If I run cpufreq-selector as root, I get:

No cpufreq support

       Harry

> 
> -- 
> Jean Delvare

-- 

Harry G. McGavran, Jr.

E-mail: w5pny@w5pny.com




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
