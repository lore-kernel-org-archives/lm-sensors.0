From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 26 May 2006 06:18:41 +0000
Subject: [lm-sensors] w83792d works under 2.6 kernel, but not 2.4 kernel
Message-Id: <44769DC1.6080100@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44730D34.4080802@morison.biz>
In-Reply-To: <44730D34.4080802@morison.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rod Morison wrote:
> Yes,
> 
> modprobe w83792d force_subclients=0,0x2f,0x4b,0x4c
> 
> works like a champ!
> 
> So that I can learn from this, how would I (or how did you) figure out 
> the subclient addresses from the i2cdump?
> 

The driver has flaw when the w83792d subclients are disabled. This was fixed for 
2.6 but forgotten for 2.4. Moreover it likes to have both subclients on specific 
  addr ranges. Plus I had to select addresses where no device is present.

I will fix the driver hopefuly in the weekend.

Regards
Rudolf

