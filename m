From: jamagallon@able.es (J.A. Magallon)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: [BK PATCH] i2c driver fixes for 2.6.2-rc2
Message-Id: <20040129225659.GA11872@werewolf.able.es>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040127233242.GA28891@kroah.com> <20040129004402.GC5830@werewolf.able.es> <1075365845.4018c7d5353d7@imp.gcu.info> <20040129222135.GC5768@werewolf.able.es>
In-Reply-To: <20040129222135.GC5768@werewolf.able.es> (from jamagallon@able.es on Thu, Jan 29, 2004 at 23:21:35 +0100)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com


On 2004.01.29, J.A. Magallon wrote:
> 
> On 2004.01.29, Jean Delvare wrote:
> > Quoting "J.A. Magallon" <jamagallon@able.es>:
> > 
> > > After upgrading to sensors 2.8.3 (first I compiled it, then installed
> > > the Makdrake package when appeared), my temperatures are still
> > > mutiplied by 10. I use 2.6.2-rc2-mm1.
> > > 
> > > Any ideas ?
> > 
> > As stated on our kernel 2.6 dedicated page [1]: You need lm_sensors CVS
> > for kernels 2.6.2-rc1 and later.
> > 
> > We plan to release lm_sensors 2.8.4 as soon as Linux 2.6.2 final is
> > there.
> > 
> > [1] http://secure.netroedge.com/~lm78/kernel26.html
> > 
> 
> Thanks, I dled the cvs version and my redings look normal now:
> 
> werewolf:~# sensors
> w83781d-isa-0290
> Adapter: ISA adapter
> VCore 1:   +1.97 V  (min =  +1.90 V, max =  +2.10 V)              
> VCore 2:   +2.02 V  (min =  +1.90 V, max =  +2.10 V)              
> +3.3V:     +3.23 V  (min =  +3.14 V, max =  +3.46 V)              
> +5V:       +4.97 V  (min =  +4.73 V, max =  +5.24 V)              
> +12V:     +12.04 V  (min = +11.37 V, max = +12.59 V)    

Oops, not so good:
          
> -12V:     -12.18 V  (min = -12.57 V, max = -11.35 V)       ALARM  
> -5V:       -4.96 V  (min =  -5.25 V, max =  -4.74 V)       ALARM  

Why ALARM ?

TIA


-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.2-rc2-jam1 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
