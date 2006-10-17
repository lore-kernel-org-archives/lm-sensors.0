From: Thilo.Cestonaro.external@fujitsu-siemens.com (Cestonaro, Thilo)
Date: Tue, 17 Oct 2006 07:11:37 +0000
Subject: [lm-sensors] new chip support kernel driver
Message-Id: <F7F9B0BE3E9BD449B110D0B1CEF6CAEF03FA5818@ABGEX01E.abg.fsc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <F7F9B0BE3E9BD449B110D0B1CEF6CAEF03FA5811@ABGEX01E.abg.fsc.net>
In-Reply-To: <F7F9B0BE3E9BD449B110D0B1CEF6CAEF03FA5811@ABGEX01E.abg.fsc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Jean,

here are the patches:
- fschmd_kernel_module_2.6.16.21.patch which is the kernel module stuff, of course ;). Also I created it based on
  the 2.6.16.21 it should fit the other current kernels IMHO.
- fschmd_lm_sensors-2.10.0.patch which is the sensors stuff, including changes in sensors.conf.eg, sensors-detect
  stuff and needed changes for prog sensors to display it.

@Documentation:
Sorry but currently there is no public documentation. But the Chip is compareable to the Hermes Chip (fscher) except that some registers (and reservations) have changed and a thermal sensor and a fan sensor where added.

I will ask for public documentation and of course you can ask me. I know this is not the best.

Thanks,
Thilo
 <<fschmd.tar.bz2>> 
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061017/ca4d538e/attachment-0001.html 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fschmd.tar.bz2
Type: application/octet-stream
Size: 8015 bytes
Desc: fschmd.tar.bz2
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061017/ca4d538e/attachment-0001.obj 
