From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 25 May 2006 21:25:46 +0000
Subject: [lm-sensors] w83792d works under 2.6 kernel, but not 2.4 kernel
Message-Id: <447620DA.3030103@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <44730D34.4080802@morison.biz>
In-Reply-To: <44730D34.4080802@morison.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> But why would 2.6 distro work and 2.4 not work for w83792d-i2c-0-2f if 
> it was a BIOS problem?
>> Please let me know if
>> modprobe w83792d force_subclients=0,0x2f,0x4a,0x4b

modprobe w83792d force_subclients=0,0x2f,0x4b,0x4c

Sorry this should at least theoreticaly work. The driver has some flaw. I will 
fix it in the weekend.

If the force does not work please use following before loading driver:
i2cset 0 0x2f 0x4a 0x43
modprobe w83792d

regards
Rudolf

