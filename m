From: paolo.berva@st.com (Paolo Cesare BERVA)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: SiS735 chipset SMBus driver for kernel 2.6
Message-Id: <4035B7D0.9050008@st.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040219020339.GE21829@earth.solarsys.private>
In-Reply-To: <20040219020339.GE21829@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> Hi Paolo:
> 
> (cc'ed to sensors mailing list...)
> 
> * Paolo Cesare BERVA <paolo.berva@st.com> [2004-02-18 08:22:27 +0100]:
> 
>>Hi Mark, here the tests I did with kernel 2.6.2:
> 
> 
> <snip>
> 
>># setpci -s 00:02.0 0x40
>>98
>># setpci -s 00:02.0 0x40=0xd8
>>
>># lspci -H1 -n | grep "00:02.0"
>>00:02.0 Class 0601: 1039:0018
>># setpci -s 00:02.0 0x40=0x98
>>
>># lspci -H1 -n | grep "00:02.0"
>>00:02.0 Class 0601: 1039:0008
> 
> 
> Excellent, that's just as I expected.
> 
> 
>>Mark M. Hoffman wrote:
> 
> 
> <snip>
> 
>>>You are missing device 1039:0016 here.  I think I understand
>>>why, but I want to make sure.  I asked another user to take
>>>some further steps, but he never responded.  
>>>
>>>You can find the steps here:
>>>
>>>http://archives.andrew.net.au/lm-sensors/msg06132.html
>>>
>>>Everything starting from "With kernel 2.6, the driver" applies
>>>to you.  If you could please follow those steps and send the
>>>results, then next I will send a patch to test.
> 
> 
> So here's the patch vs. 2.6.3.  When you build it, select
> eeprom as a module (and of course i2c-sis96x).  Please try
> it, and send me the results of a few commands...
> 
> lspci -n (again)
> modprobe i2c-sis96x
> modprobe eeprom
> sensors
> 
> If none of that seems to work, then please send the results
> of 'dmesg'.

Hi Mark, applied the patch and rebuilt the kernel, here the results:

# uname -a
Linux localhost 2.6.3 #1 Fri Feb 20 00:02:27 CET 2004 i686 GNU/Linux
# lspci -n
00:00.0 Class 0600: 1039:0735 (rev 01)
00:01.0 Class 0604: 1039:0001
00:02.0 Class 0601: 1039:0018
00:02.1 Class 0c05: 1039:0016
00:02.2 Class 0c03: 1039:7001 (rev 07)
00:02.3 Class 0c03: 1039:7001 (rev 07)
00:02.5 Class 0101: 1039:5513 (rev d0)
00:0f.0 Class 0200: 10ec:8139 (rev 10)
00:11.0 Class 0401: 1274:5880 (rev 02)
01:00.0 Class 0300: 10de:0110 (rev b2)
# modprobe i2c-sis96x
# modprobe eeprom
# sensors
eeprom-i2c-0-50
Adapter: SiS96x SMBus adapter at 0x0c00
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

Thank you
Paolo
