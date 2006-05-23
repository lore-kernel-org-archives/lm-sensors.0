From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 23 May 2006 21:21:33 +0000
Subject: [lm-sensors] w83792d works under 2.6 kernel, but not 2.4 kernel
Message-Id: <44737CDD.8050507@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44730D34.4080802@morison.biz>
In-Reply-To: <44730D34.4080802@morison.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,


Rod Morison wrote:
> I am stuck with what it certainly a config problem. I've got lm_sensors 
> 2.10.0 running fine on a SuperMicro PDSMA mobo under 2.6.16 kernel. 
> However, under 2.4.19 (required for the embedded project I'm on), I'm 
> missing sensors for one of the chips. I'm using the same sensors.conf 
> and modules.conf/modprobe.conf settings.
> 

As for the 2.4 version I cannot see that you have loaded the w83792d kernel module.

Please try the modprobe w83792d
and then sensors

regards
Rudolf

