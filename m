From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 27 Aug 2015 07:30:28 +0000
Subject: Re: [lm-sensors] ASRock AM1H-ITX
Message-Id: <20150827093028.3fec5272@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJV44BPR3uN3NgsFQXHpAenqNyjMSTF3pHe9Vqw=3vAeGfpC-g@mail.gmail.com>
In-Reply-To: <CAJV44BPR3uN3NgsFQXHpAenqNyjMSTF3pHe9Vqw=3vAeGfpC-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 17 Aug 2015 16:02:53 -0700, descart avel wrote:
> ++ Motherboard vendor and model
> ASRock AM1H-ITX
> (...)
> ++ The output of (as root) sensors-detect
> attached

> Driver `nct6775':
>   * ISA bus, address 0x290
>     Chip `Nuvoton NCT5573D/NCT5577D/NCT6776F Super IO Sensors' (confidence: 9)

What happens if you try to load the nct6775 kernel module? ("modprobe
nct6775" as root)

> Copy prog/init/lm_sensors.service to /lib/systemd/system
> and run 'systemctl enable lm_sensors.service'
> for initialization at boot time.

Did you do that?

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
