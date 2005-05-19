From: Ilia.Stolov@nsc.com (Ilia Stolov)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: PC87431 mBMC info
Message-Id: <OF02375B25.BA117AFA-ONC2256F7F.003FF5DC-C2256F7F.00404C90@nsc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Following by recently requests about National's PC87431 mBMC device, please find
the
following information:
1. The PC87431 is fully IPMI 1.5 compliant device with remote LAN manageability
support
2. The Host interface of PC87431 is IPMI 1.5/2.0 SSIF (SMBus)
3. The PC87431 supports all mandatory commands of IPMI 1.5
4. System configuration and sensor list can be read using regular IPMI SDR
commands
5. Specific sensor data can be obtained using IPMI "Get Sensor Reading" command

More information about PC87431 can be found on:
http://www.national.com/pf/PC/PC87431M.html

The full PC87431 datasheet can be obtained under NDA.

For more information about IPMI specification, please see IPMI developers
web-site:
http://developer.intel.com/design/servers/ipmi/index.htm

Attached are sample sources of SSIF interface implementation for PC87431.
Sources provided under BSD license agreement.

(See attached file: SSIF_BSD.zip)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: SSIF_BSD.zip
Type: application/zip
Size: 13140 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050104/8c0ac47c/SSIF_BSD.zip
