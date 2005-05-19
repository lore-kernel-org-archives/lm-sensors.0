From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: Pardon this possibly basic question....
Message-Id: <3E136F2E.2070602@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021230203924.GA21715@keimel.com>
In-Reply-To: <20021230203924.GA21715@keimel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

While the drivers can all be built into the kernel,
not all the tools behave well without module support.
See ticket #547 for example, which confirms the problem in sensors-detect.
Khali, perhaps with your perl skills you could fix?

Jean Delvare wrote:
>>Can lmsensors be run on a kernel that does not have modules enabled?
>>If so, are there documents that indicate how this is setup? I'm only
>>finding references to 'sensors-detect' which complains that it "Can't
>>access /proc/modules! at /usr/sbin/sensors-detect line 885." 
>>
>>I am running Debian 3.0 (stable) with 2.4.18, patched with GRsecurity.
>>I've got a Dual Tyan motherboard which has (apparantly) PIIX4 chips in
>>it. 
>>
>>i2c support with i2c /proc is enabled in the kernel. 
>>
>>If you can help point me in the direction of running lmsensors without
>>a modular kernel, I'd appreciate it much. 
> 
> 
> I suppose that using Albert Cranford's patches should do it. Grab them
> there:
> http://home.attbi.com/~ac9410/
> Patch your kernel with them, reconfigure and select everything you need.
> 
> Please let us know if/how it works for you.
> 
