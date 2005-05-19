From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: sensor problems with msi k8t (ticket #1553)
Message-Id: <tF2g8wt9.1100101673.1904010.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200411101004.56332.murray@smigel.org>
In-Reply-To: <200411101004.56332.murray@smigel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Murray,

> I saw your post on the lm_sensors board. I just installed Gentoo on a dual 
> Opteron and the k8t board. It looks like you don't want to use the it87 
> device (at least that is what sensors-detect says). I used w83627hf and
> have what seem like reasonable temperatures coming out. My sensors.conf is 
> attached.

Thanks a lot for the report. You are completely right (and so is
sensors-detect), the MSI K8T series use Winbond W836x7HF/THF chips, not
ITE 87xxF ones. I am updating the ticket right now.

> I have made a few changes that I think label the cpu temps correctly, but
> I am pretty ignorant about these things.

I think you got it wrong. According to MBM's site, temp1 is the
motherboard temp and uses a thermistor, temp2 and temp3 are the CPU
temps and use diodes. Try it! This also makes more sense because temp2
and temp3 have a better resolution.

> (I have no idea what VID data is!)

This is a nominal voltage value provided by the CPU itself. It basically
instructs the hardware monitoring chip of what the Vcore value should
be, so that low and high limits for Vcore can be set to sane values.

The fact that sensors is not able to read it is probably caused by a
version mismatch between libsensors and your kernel. See this page for
details on recommended version combinations:
http://secure.netroedge.com/~lm78/kernel26.html

Thanks,
Jean
