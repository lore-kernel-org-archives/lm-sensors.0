From: oleg@cs.msu.su (Oleg I. Vdovikin)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: [CONTRIBUTION] DDC/CI tool for lm_sensors package
Message-Id: <1093114999.11260.22.camel@proxima>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

	I've recently finished writing a tool which is suitable for
communication with DDC/CI (DDC2Bi) enabled monitors (Samsung,
NEC/Mitsubishi are known to support it) and allows querying monitor
capabilities, reading and writing monitor controls, such as contrast,
brightness, geometry, etc...

	I'm believe, that there is some interest on this, at least googling
shows that. ;-) The reason for contributing is simple - I've spent some
time on this, and do not want to just this into the wastebasket. ;-)

	I've tested it with Samsung SyncMaster 173T with radeonfb and 
Nicolas Boichat, which has independently started digging on the same
thing and now working with GUI version, has tested it with Mitsubishi
Diamond Pro 2060u with rivafb. Mitsubishi Diamond Pro 2060u does not
support capabilities request.

	This program is based on info sniffed on wire, published in USB Monitor
Control Class 1.0 specification for control codes available at
http://www.usb.org/developers/devclass_docs/usbmon10.pdf
and ACCESS.bus (tm) Specifications Version 3.0 available at
http://www.semtech.com/pdf/abusv30.pdf. In fact, up to date information
about DDC/CI standard (Display Data Channel Command Interface (DDC/CI)
Standard (formerly DDC2Bi), Version 1) is available from VESA
(http://www.vesa.org) and the summary is freely available at
http://www.vesa.org/summary/sumddcci.htm

	Attached please find a patch against lm_sensors-2.8.7. I would like if
someone will review this stuff and commit it to the CVS.

	I'm not in the list, so please CC me in your answers.

	Also, I've made a web page available at this address:
http://jaffar.cs.msu.su/oleg/ddcci/

Thanks,
	Oleg.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-2.8.7-ddcci.diff
Type: text/x-patch
Size: 22602 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040821/6ef67f91/lm_sensors-2.8.7-ddcci.bin
