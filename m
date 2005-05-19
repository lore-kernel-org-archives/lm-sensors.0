From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: loading failed@.. skipping
Message-Id: <3C3BA38D.A01B6537@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C39219D.20409@ztel.com>
In-Reply-To: <3C39219D.20409@ztel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Try 'depmod'. Then 'modprobe -l' and make sure i2c-viapro is listed.

Walter Hutchins wrote:
> 
> Everything seemed to compile without complaint.
> Though I am not up to speed with lingo about what to do, I would like to
> use this
> software. I tried as best I could to follow the steps. I am using SuSE
> linux 7.1.
> I would greatly appreciate any suggestions as to why this cannot find
> i2c-viapro.
> 
> root@walterh2:/home/wnh >uname -a
> Linux walterh2 2.4.0-4GB #1 Wed Jan 24 15:55:09 GMT 2001 i686 unknown
> 
> Do you want to probe now? (YES/no): YES
> Probing for PCI bus adapters...
> Use driver `i2c-viapro' for device 00:04.4: VIA Technologies VT 82C686
> Apollo ACPI
> Probe succesfully concluded.
> 
>  We will now try to load each adapter module in turn.
> Load `i2c-viapro' (say NO if built into your kernel)? (YES/no): YES
> modprobe: Can't locate module i2c-viapro
> Loading failed ()... skipping.
> 
> root@walterh2:/home/wnh >find / -name "i2c-viapro*" -print
> /lib/modules/2.4.0/misc/i2c-viapro.o
> /usr/share/doc/packages/sensors/busses/i2c-viapro
> /home/wnh/LM_SENSORS/lm_sensors-2.6.2/doc/busses/i2c-viapro
> /home/wnh/LM_SENSORS/lm_sensors-2.6.2/kernel/busses/i2c-viapro.c
> /home/wnh/LM_SENSORS/lm_sensors-2.6.2/kernel/busses/i2c-viapro.d
> /home/wnh/LM_SENSORS/lm_sensors-2.6.2/kernel/busses/i2c-viapro.o
> root@walterh2:/home/wnh >modprobe i2c-viapro
> modprobe: Can't locate module i2c-viapro
