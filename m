From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 31 Aug 2006 21:38:20 +0000
Subject: [lm-sensors] Is the Intel i945G supported/planned?
Message-Id: <20060831233820.fc57ab21.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <ce9ef0d90608291525r42520432gd67005073da32057@mail.gmail.com>
In-Reply-To: <ce9ef0d90608291525r42520432gd67005073da32057@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sunil,

> $ sensors-detect
> # sensors-detect revision 1.413 (2006/01/19 20:28:00)
> 
> This program will help you determine which I2C/SMBus modules you need to
> load to use lm_sensors most effectively. You need to have i2c and
> lm_sensors installed before running this program.
> Also, you need to be `root', or at least have access to the /dev/i2c-*
> files, for most things.
> If you have patched your kernel and have some drivers built in, you can
> safely answer NO if asked to load some modules. In this case, things may
> seem a bit confusing, but they will still work.
> 
> It is generally safe and recommended to accept the default answers to all
> questions, unless you know what you're doing.
> 
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no): YES
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 00:1f.3: Intel ICH7
> Probe succesfully concluded.

Which kernel is this? You need >= 2.6.11 for ICH7 support in i2c-i801.

> I have i2c_dev in kernel, so I declined that.

Please double check that. I'm quite suspicious given the original lsmod
you posted:

> $ lsmod
> Module                  Size  Used by
> vmnet                  30764  9
> vmmon                  99788  0
> i915                   18304  2
> eeprom                  7568  0
> drm                    62740  3 i915
> snd_intel8x0           31260  0
> snd_ac97_codec         83616  1 snd_intel8x0
> snd_ac97_bus            2816  1 snd_ac97_codec
> intel_agp              21788  1
> intelfb                30628  0
> tg3                    96900  0
> i2c_i801                7820  0
> agpgart                32712  4 drm,intel_agp,intelfb
> i2c_core               20352  2 eeprom,i2c_i801

You can't have i2c-core as a module and i2c-dev built-in, it's
technically impossible.

-- 
Jean Delvare

